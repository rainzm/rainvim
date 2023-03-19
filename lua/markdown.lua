local M = {
	notebookPath = "/Users/rain/Documents/vimwiki",
	htmlDirName = "site_html",
}

local function splitFilename(path)
	local dir, file, ext = "", "", ""
	for d in path:gmatch("(.-)[/]+") do
		dir = dir .. d .. "/"
	end
	for f, e in path:gmatch("([^/]+)%.([^%.]+)$") do
		file = f
		ext = e
	end
	return dir, file, ext
end

function M.toHTML(path)
	local src = path
	local dir, file, ext = splitFilename(src)
	if ext ~= "md" then
		vim.notify("It is not a markdown file", "error")
		return
	end
	local dest = string.format("%ssite_html/%s.%s", dir, file, "html")
	local status = os.execute(string.format("~/.config/nvim/trans.sh %s %s", src, dest))
	if status == 0 then
		vim.notify(string.format("Transfer %s success.", src), "info")
		return dest
	else
		vim.notify(string.format("Transfer %s failed.", src), "error")
		return ""
	end
end

function M.cToHTML(_)
	local filename = vim.api.nvim_buf_get_name(0)
	M.toHTML(filename)
end

function M.cToHTMLOpen()
	local filename = vim.api.nvim_buf_get_name(0)
	local dest = M.toHTML(filename)
	if dest == "" then
		return
	end
	os.execute(string.format("open %s", dest))
end

function M.allToHTML()
	local lfs = require("lfs")
	for file in lfs.dir(M.notebookPath) do -- 遍历目录
		if file ~= "." and file ~= ".." then -- 排除 . 和 ..
			local ext = file:match("%.([^%.]+)$") -- 获取文件扩展名
			if ext == "md" then -- 如果扩展名是 md
				M.toHTML(file)
			end
		end
	end
end

function M.browse()
	local filename = vim.api.nvim_buf_get_name(0)
	local src = filename
	local dir, file, ext = splitFilename(src)
	if ext ~= "md" then
		vim.notify("It is not a markdown file", "error")
		return
	end
	local dest = string.format("%ssite_html/%s.%s", dir, file, "html")
	os.execute(string.format("open %s", dest))
end

return M
