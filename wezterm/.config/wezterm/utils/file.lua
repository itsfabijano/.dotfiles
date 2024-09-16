local M = {}

-- see if the file exists
function M.exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function M.read_lines(file)
	if not M.exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		print("line", line)
		lines[#lines + 1] = line
	end
	return lines
end

function M.basename(str)
	local name = string.gsub(str, "(.*/)(.*)", "%2")
	return name
end

function M.scandirs(directories)
	local t = {}
	for _, d in ipairs(directories) do
		local i, popen = 0, io.popen
		local pfile = popen("find " .. d .. " -mindepth 1 -maxdepth 1 -type d ")
		if not pfile then
			return {}
		end
		for filename in pfile:lines() do
			i = i + 1
			t[i] = { label = filename, id = filename }
		end
		pfile:close()
	end
	return t
end

return M
