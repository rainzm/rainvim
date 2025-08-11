local function bd(_)
	--require("mini.bufremove").delete(0, false)
	Snacks.bufdelete(0)
end

local function bdforce()
	Snacks.bufdelete({
		buf = 0,
		force = true,
	})
end

local function rg(opts)
	if opts.args == nil or opts.args == "" then
		Snacks.picker.grep({
			layout = { preset = "rain" },
		})
	else
		Snacks.picker.grep_word({
			layout = { preset = "rain" },
			search = function(_)
				return opts.args
			end,
		})
	end
end

vim.api.nvim_create_user_command("Bd", bd, {})
vim.api.nvim_create_user_command("BD", bdforce, {})
vim.api.nvim_create_user_command("Mkdn2HTML", require("markdown").cToHTML, {})
vim.api.nvim_create_user_command("Mkdn2HTMLBrowse", require("markdown").cToHTMLOpen, {})
vim.api.nvim_create_user_command("Mkdn2HTMLAll", require("markdown").allToHTML, {})
vim.api.nvim_create_user_command("MkdnBrowse", require("markdown").browse, {})
vim.api.nvim_create_user_command("Rg", rg, { nargs = "?", force = true })

local function markdown_format()
	local filepath = vim.fn.expand("%:p")
	if filepath == "" then
		return
	end
	local result, err, exit_code = vim.fn.systemlist({ "autocorrect", "--fix", filepath })
	if exit_code and exit_code ~= 0 then
		print("Error running autocorrect:" .. exit_code)
		print(err) -- err 通常包含 stderr 的内容
		return
	end

	-- 保存当前视图（光标位置、滚动位置等）
	local view = vim.fn.winsaveview()
	-- 重新编辑文件以从磁盘重新加载
	-- 'silent' 在 Lua 中通过 vim.cmd 实现
	vim.cmd("silent edit")
	-- 恢复之前保存的视图
	vim.fn.winrestview(view)
	-- 重绘屏幕以避免可能的视觉问题
	vim.cmd("redraw!")
end

local markdown_format_group = vim.api.nvim_create_augroup("MarkdownFormat", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = markdown_format_group,
	callback = function()
		if vim.bo.filetype == "markdown" then
			markdown_format()
		end
	end,
	desc = "Format markdown files with autocorrect on save",
})

vim.api.nvim_create_autocmd("User", {
	pattern = "OpencodeEvent",
	callback = function(args)
		-- See the available event types and their properties
		vim.notify(vim.inspect(args.data), vim.log.levels.DEBUG)
		-- Do something interesting, like show a notification when opencode finishes responding
		if args.data.type == "session.idle" then
			vim.notify("opencode finished responding", vim.log.levels.INFO)
		end
	end,
})
