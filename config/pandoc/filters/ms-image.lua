--** NOTE: enabling toc WILL BREAK this **--
-- Rudimentary image support for pandoc roff ms export.
--	 See also cf. https://github.com/jgm/pandoc/issues/4475
--
-- A rewritten and simplified version of the filter by Bernard Fisseni (teoric):
-- https://github.com/teoric/pandoc-filters/blob/master/image-ms.lua
--
-- Limitations:
--	 * Works only with local images.
--	 * Primarily intended for 'figures', i.e. images with caption, appearing
--		 by themselves in a paragraph.
--	 * Other images will appear also (without caption) but are not really
--		 inline; they will break the text and appear on a line by themselves.
--	 * Floats and inlines are thus beyond our scope but are handled by teoric's
--		 filter mentioned above.
--	 * Image directories must be writable or already contain PDF images.
--	 * PDF conversion requires ImageMagick (the "convert" command).
--	 * Automatic size determination requires pdfinfo (part of Poppler).

local utils = require 'pandoc.utils'
local system = require 'pandoc.system'
local path = require 'pandoc.path'

-- in points -- about 19.05 cm
local max_width = 540
-- Since all images take up their own "paragraph", very small ones
-- do not make much sense. Let's say about 1 cm min width.
local min_width = 28

function endswith(str, ending)
	return ending == '' or str:sub(-#ending) == ending
end

function file_exists(path)
	-- file exists if it is readable
	local file = io.open(path, "rb")
	if file then file:close() end
	return file ~= nil
end

function get_img_size(given_w, given_h, src)
	if given_w ~= nil then
		given_w = img_dim(given_w, min_width, max_width)
		if given_h ~= nil then
			given_h = img_dim(given_h, 1, max_width * 1.4)
		end
		return given_w, given_h
	end
	-- Get intrinsic size from PDF file
	size = pandoc.pipe('pdfinfo', {src}, "")
	local w, h
	_, _, w, h = size:find("Page size:%s+([%d%.]+)%s+x%s+([%d%.]+)")
	if w then
		return img_dim(w .. 'pt', min_width, max_width), img_dim(h .. 'pt', 1, max_width * 1.4)
	end
end

function img_dim(x, min, max)
	x = to_points(x)
	if x ~= nil then
		if x < min then
			return tostring(min) .. 'p'
		elseif x > max then
			return tostring(max) .. 'p'
		else
			return tostring(x) .. 'p'
		end
	end
end

function to_points(val)
	-- Convert HTML/CSS measurements to points (given certain assumptions).
	-- Note that '%'/'vw' are only appropriate for width. Using them for height
	-- will often yield inappropriate results.
	-- First, remove trailing separators.
	val = val:gsub('[;:,]$', '')
	-- Note that px assumes 300dpi (not 96dpi), and that '%'/'vw' take the content
	-- width (excluding) margins) to be about 425 points.
	local known_units = {
		pt=1.0, em=12.0, rem=12.0, en=6.0, ex=6.0, ch=6.0, mm=2.83, cm=28.3,
		["in"]=71.882, pc=12.0, px=0.24, vw=425, ["%"]=4.25, }
	local unit
	local val_num = tonumber(val)
	if val_num ~= nil then
		unit = 'px'
	else
		val_num, unit = val:match('([%d%.]+)([^%d%.]+)')
	end
	if val_num ~= nil and known_units[unit] then
		return tonumber(val_num) * known_units[unit]
	end
end

function get_absolute_path(needle)
	-- Referencing the image by absolute path is necessary if the .ms file
	-- is placed in a different directory than the markdown file or if it
	-- depends on images in '--resource-path' directories.
	try_dirs = {}
	for _,v in ipairs(PANDOC_STATE.input_files) do
		table.insert(try_dirs, path.directory(v))
	end
	if PANDOC_STATE.source_url ~= nil then
		table.insert(try_dirs, PANDOC_STATE.source_url)
	end
	table.insert(try_dirs, system.get_working_directory())
	for _, v in ipairs(PANDOC_STATE.resource_path) do
		table.insert(try_dirs, v)
	end
	for k,v in ipairs(try_dirs) do
		if file_exists(path.join({v, needle})) then
			return v
		end
	end
	return '.'
end

local im_count = 1

function solo_image (im)
	-- Centered image with italic caption in smaller font.
	ret = '.LP\n.PDFPIC -C'
	local width, height
	im, width, height = convert_and_get_size(im)
	ret = ret .. string.format(' "%s"', im.src)
	if width ~= nil then
		ret = ret .. string.format(' %s', width)
		-- height only matters if width was given
		if height ~= nil then
			ret = ret .. string.format(' %s', height)
		end
	end
	cap = utils.stringify(im.caption)
	if cap ~= nil and cap ~= '' then
		ret = ret .. '\n.CD\n\\s-2Figure ' .. im_count .. ': \\f[R]' .. cap .. '\\f[R]\\s0\n.DE\n'
		im_count = im_count + 1
	end
	return pandoc.RawInline("ms", ret)
end

function inline_image (im)
	local width, height
	im, width, height = convert_and_get_size(im)
	ret = "\n.PDFPIC -I 1 " .. string.format('"%s"', im.src)
	if width ~= nil then
		ret = ret .. string.format(' %s', width)
		-- height only matters if width was given
		if height ~= nil then
			ret = ret .. string.format(' %s', height)
		end
	end
	ret = ret .. '\n'
	return pandoc.RawInline("ms", ret)
end

function convert_and_get_size(im)
	local im_src_old = im.src
	if not endswith(im.src:lower(), ".pdf") then
		local im_src_new = string.gsub(im.src, "%.[^.]+$", ".pdf")
		if im_src_new:sub(1,1,'/') == '/' then
			im.src = im_src_new
		else
			leading_path = get_absolute_path(im_src_old)
			im.src = path.join({leading_path, im_src_new})
			im_src_old = path.join({leading_path, im_src_old})
		end
	end
	if not file_exists(im.src) and file_exists(im_src_old) then
		-- if this fails, check policies in /etc/ImageMagick-[67]/policy.xml
		-- whether they forbid conversion of EPS, PDF etc.
		pandoc.pipe("convert", {im_src_old, im.src}, "")
	end
	local width, height = get_img_size(im.attributes.width, im.attributes.height, im.src)
	return im, width, height
end

return {
	{
		Inlines = function(inl)
			if FORMAT == "ms" and #inl==1 and inl[1].t == 'Image' then
				return solo_image(inl[1])
			end
		end,
	},
	{
		Image = function(im)
			if FORMAT == 'ms' then
				return inline_image(im)
			end
		end,
	}
}
