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

local function RimeT(opts)
	vim.lsp.set_log_level("debug")
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_current_buf(buf)
	vim.api.nvim_buf_set_option(buf, "filetype", opts.args)
	vim.api.nvim_buf_set_name(buf, "/Users/rain/" .. opts.args)
	local buf = vim.api.nvim_get_current_buf()
	local rime_ls_client = vim.lsp.get_clients({ name = "rime_ls" })
	if #rime_ls_client == 0 then
		vim.cmd("LspStart rime_ls")
		rime_ls_client = vim.lsp.get_clients({ name = "rime_ls" })
	end
	if #rime_ls_client > 0 then
		vim.lsp.buf_attach_client(buf, rime_ls_client[1].id)
	end
end

vim.api.nvim_create_user_command("Bd", bd, {})
vim.api.nvim_create_user_command("BD", bdforce, {})
vim.api.nvim_create_user_command("Mkdn2HTML", require("markdown").cToHTML, {})
vim.api.nvim_create_user_command("Mkdn2HTMLBrowse", require("markdown").cToHTMLOpen, {})
vim.api.nvim_create_user_command("Mkdn2HTMLAll", require("markdown").allToHTML, {})
vim.api.nvim_create_user_command("MkdnBrowse", require("markdown").browse, {})
vim.api.nvim_create_user_command("Rg", rg, { nargs = "?", force = true })
vim.api.nvim_create_user_command("Rt", RimeT, { nargs = 1, force = true })

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

-- 1. 先声明该保存哪些 shada
-- vim.opt.shada = { "'10", "<0", "s10", "h" }

-- 2. 只在 BufReadPost 里做一次恢复光标即可
-- local grp = vim.api.nvim_create_augroup("RestorePersistentCursor", { clear = true })
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	group = grp,
-- 	pattern = "*",
-- 	callback = function(args)
-- 		print("Restoring cursor position for buffer: " .. args.buf)
-- 		local buf = args.buf
-- 		local ok, mark = pcall(vim.api.nvim_buf_get_mark, buf, '"')
-- 		-- mark 形如 { line, col }
-- 		if ok then
-- 			print("mark found for buffer " .. buf .. ": " .. vim.inspect(mark))
-- 		else
-- 			print("no mark found for buffer " .. buf)
-- 		end
-- 		if ok and mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(buf) then
-- 			vim.api.nvim_win_set_cursor(0, mark)
-- 		end
-- 	end,
-- })
