local M = {
	-- hack, wiat for neovim 0.10 vim.lsp.get_clients
	_rimels_clients = {},
}

local global_rime_status = "nvim_rime#global_rime_enabled"
local buffer_rime_status = "buf_rime_enabled"

function M.global_rime_enabled()
	local exist, status = pcall(vim.api.nvim_get_var, global_rime_status)
	return (exist and status)
end

function M.buf_rime_enabled(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local exist, status = pcall(vim.api.nvim_buf_get_var, bufnr, buffer_rime_status)
	return exist, status
end

local function change_buf_rime_flag(bufnr, value, with_key)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if with_key then
		if value then
			vim.keymap.set({ "i", "s" }, "<Space>", function()
				local cmp = require("cmp")
				local entry = cmp.get_selected_entry()
				if entry == nil then
					entry = cmp.core.view:get_first_entry()
				end
				if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					})
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Space>", true, true, true), "ni", false)
				end
			end, { buffer = bufnr })
		else
			vim.keymap.del({ "i", "s" }, "<Space>", { buffer = bufnr })
		end
	end
	vim.api.nvim_buf_set_var(bufnr, buffer_rime_status, value)
end

function M.buf_toggle_rime(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	local init, buf_rime_enabled = M.buf_rime_enabled(bufnr)
	if not init then
		vim.notify("Rime is not init for this buffer", vim.log.levels.Warning)
		return
	end
	if buf_rime_enabled ~= M.global_rime_enabled() then
		change_buf_rime_flag(bufnr, not buf_rime_enabled, true)
		return
	end

	local client = M.buf_get_rime_ls_client(bufnr)
	if not client then
		M.buf_attach_rime_ls(bufnr)
		client = M.buf_get_rime_ls_client(bufnr)
	end
	if not client then
		vim.notify("Failed to get rime_ls client", vim.log.levels.ERROR)
		return
	end

	M.toggle_rime(client, function()
		change_buf_rime_flag(bufnr, not buf_rime_enabled, true)
	end)
end

function M.buf_on_rime(client, bufnr)
	if not M.global_rime_enabled() then
		M.toggle_rime(client, function()
			change_buf_rime_flag(bufnr, true, true)
		end)
	else
		change_buf_rime_flag(bufnr, true, true)
	end
end

function M.setup_rime()
	-- add rime-ls to lspconfig as a custom server
	-- see `:h lspconfig-new`
	local lspconfig = require("lspconfig")
	local configs = require("lspconfig.configs")
	if not configs.rime_ls then
		configs.rime_ls = {
			default_config = {
				name = "rime_ls",
				-- cmd = { "rime_ls" },
				cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
				filetypes = { "*" },
				single_file_support = true,
			},
			settings = {},
			docs = {
				description = [[
	https://www.github.com/wlh320/rime-ls

	A language server for librime
	]],
			},
		}
	end

	local rime_on_attach = function(client, bufnr)
		local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
		if ft == "markdown" or ft == "norg" or ft == "copilot-chat" then
			M.buf_on_rime(client, bufnr)
		else
			change_buf_rime_flag(bufnr, false, false)
		end
		M._rimels_clients[bufnr] = client
		--M.create_autocmd_toggle_rime_according_buffer_status()
		vim.keymap.set("n", "<leader><space>", M.buf_toggle_rime)
		vim.keymap.set("n", "<leader>rp", M.buf_get_rime_ls_client)
		vim.keymap.set("n", "<leader>rs", function()
			vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" })
		end)
	end

	-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	lspconfig.rime_ls.setup({
		name = "rime_ls",
		cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
		-- cmd = { "/Users/rain/.local/bin/rime_ls" },
		-- filetypes = { "markdown", "gitcommit", "norg", "TelescopePrompt", "go" },
		filetypes = { "*" },
		init_options = {
			enabled = M.global_rime_enabled(), -- 初始关闭, 手动开启
			shared_data_dir = "/Library/Input Methods/Squirrel.app/Contents/SharedSupport", -- rime 公共目录
			user_data_dir = "~/.local/share/rime-ls", -- 指定用户目录, 最好新建一个
			log_dir = "~/.local/share/rime-ls/log", -- 日志目录
			-- trigger_characters = { ",", "." },
			schema_trigger_character = "&", -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
			max_tokens = 4, -- 强制在删除到4字的时候重建一次候选词，避免用退格造成的空列表的问题
			always_incomplete = true, -- 将 incomplete 永远设为 true，防止任何时候的过滤代替候选词重建
			paging_characters = { "=", ",", "." },
		},
		on_attach = rime_on_attach,
		capabilities = capabilities,
	})
	M.create_autocmd_toggle_rime_according_buffer_status()
end

function M.create_autocmd_toggle_rime_according_buffer_status()
	-- Close rime_ls when opening a new window
	local rime_group = vim.api.nvim_create_augroup("RimeAutoToggle", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = "*",
		group = rime_group,
		callback = function(ev)
			local bufnr = ev.buf
			local client = M.buf_get_rime_ls_client(bufnr)
			if not client then
				local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
				-- hack
				if ft == "copilot-chat" then
					M.buf_attach_rime_ls(bufnr)
					client = M.buf_get_rime_ls_client(bufnr)
				end
				if not client then
					return
				end
			end
			local init, buf_rime_enabled = M.buf_rime_enabled(bufnr)
			if not init then
				return
			end
			local global_rime_enabled = M.global_rime_enabled()
			if buf_rime_enabled ~= global_rime_enabled then
				-- hack for copilot-chat which will exec twice
				vim.api.nvim_buf_set_var(bufnr, buffer_rime_status, global_rime_enabled)
				M.toggle_rime(client, function()
					change_buf_rime_flag(bufnr, M.global_rime_enabled(), true)
				end)
			end
		end,
		desc = "Start or stop rime_ls according current buffer",
	})
	vim.api.nvim_create_autocmd("BufDelete", {
		pattern = "*",
		group = rime_group,
		callback = function(ev)
			M._rimels_clients[ev.buf] = nil
		end,
	})
end

function M.toggle_rime(client, callback)
	client = client or M.buf_get_rime_ls_client()
	if not client or client.name ~= "rime_ls" then
		return
	end
	client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
		if ctx.client_id == client.id then
			vim.api.nvim_set_var(global_rime_status, result)
			if callback then
				callback()
			end
		end
	end)
end

function M.buf_attach_rime_ls(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	if M.buf_get_rime_ls_client(bufnr) then
		return
	end

	local active_clients = vim.lsp.get_active_clients()
	if #active_clients > 0 then
		for _, client in ipairs(active_clients) do
			if client.name == "rime_ls" then
				vim.lsp.buf_attach_client(bufnr, client.id)
				return
			end
		end
	end
end

function M.buf_get_rime_ls_client(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local client = M._rimels_clients[bufnr]
	if client then
		return client
	end
	local current_buffer_clients = vim.lsp.buf_get_clients(bufnr)
	if #current_buffer_clients > 0 then
		for _, pclient in ipairs(current_buffer_clients) do
			if pclient.name == "rime_ls" then
				return client
			end
		end
	end
	return nil
end

return M
