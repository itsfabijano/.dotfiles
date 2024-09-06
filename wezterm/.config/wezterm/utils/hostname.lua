local _M = {}

function _M.getHostname()
	local f = io.popen("/bin/hostname")
	if not f then
		return ""
	end
	local hostname = f:read("*a") or ""
	f:close()
	hostname = string.gsub(hostname, "\n$", "")
	return hostname
end

return _M
