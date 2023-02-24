--** lua-filter **--
-- helper: store output of a command into a varaible
function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

-- set date metadata if it's empty
function Meta(m)
	if m.date == nil then
		m.date = os.capture("jdate '+%e %V %Y'")
		return m
	end
end
