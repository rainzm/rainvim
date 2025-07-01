local function bd(_)
	require("mini.bufremove").delete(0, false)
end

local function bdforce()
	require("mini.bufremove").delete(0, true)
end

local function rg(opts)
	-- 这里引用了telescope，就算telescope没有被load，也会自动load，lazy.nvim的功劳
	require("telescope.builtin").grep_string({
		search = opts.args,
		disable_coordinates = true,
		additional_args = { "--no-ignore-parent" },
	})
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
vim.api.nvim_create_user_command("Rg", rg, { nargs = 1, force = true })
vim.api.nvim_create_user_command("Rt", RimeT, { nargs = 1, force = true })
