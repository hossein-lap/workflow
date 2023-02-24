function Meta(m)
	if m.date == nil then
		m.date = os.date("%B %e, %Y")
		return m
	end
end
