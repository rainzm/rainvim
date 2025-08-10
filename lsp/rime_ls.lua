vim.g.rime_enabled = false

local rime_on_attach = function(client, _)
	local toggle_rime = function()
		client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
			if ctx.client_id == client.id then
				vim.g.rime_enabled = result
				local cmp = require("cmp")
				if vim.g.rime_enabled then
					-- 新增自定义映射
					print("Rime enabled, adding custom mapping for <Space>")
					cmp.setup({
						mapping = {
							["<Space>"] = cmp.mapping(function(fallback)
								if not vim.g.rime_enabled then
									fallback()
								end
								local entry = cmp.get_selected_entry()
								-- if entry == nil then
								-- 	entry = cmp.core.view:get_first_entry()
								-- end
								if
									entry
									and entry.source.name == "nvim_lsp"
									and entry.source.source.client.name == "rime_ls"
								then
									cmp.confirm({
										behavior = cmp.ConfirmBehavior.Replace,
										select = true,
									})
								else
									fallback()
								end
							end, { "i" }),
						},
					})
				else
					print("Rime disabled, removing custom mapping for <Space>")
					cmp.setup({
						mapping = {
							["<Space>"] = cmp.mapping(function(fallback)
								fallback()
							end, { "i" }),
						},
					})
				end
			end
		end)
	end
	-- keymaps for executing command
	vim.keymap.set("n", "<leader><space>", toggle_rime, { desc = "Toggle [R]ime" })
	vim.keymap.set("i", "<C-x>", toggle_rime, { desc = "Toggle Rime" })
	vim.keymap.set("n", "<leader>rs", function()
		vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" })
	end, { desc = "[R]ime [S]ync" })

	-- set trigger for different filetypes
	local set_rime_trigger = function(trigger)
		local clients = vim.lsp.get_clients({
			bufnr = vim.api.nvim_get_current_buf(),
			name = "rime_ls",
		})
		for _, client in ipairs(clients) do
			local settings = { trigger_characters = trigger }
			client.config.settings = settings
			client.notify("workspace/didChangeConfiguration", { settings = settings })
		end
	end
	local filetype = vim.bo.filetype
	if
		filetype == "text"
		or filetype == "markdown"
		or filetype == "tex"
		or filetype == "typst"
		or filetype == "copilot-chat"
		or filetype == "AvanteInput"
	then
		set_rime_trigger({})
	else
		set_rime_trigger({ ">" })
	end
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

return {
	name = "rime_ls",
	cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
	-- cmd = { "/Users/rain/.local/bin/rime_ls" },
	-- filetypes = { "markdown" },
	init_options = {
		enabled = false, -- 初始关闭, 手动开启
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
}
