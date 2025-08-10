local function get_arguments()
	return coroutine.create(function(dap_run_co)
		local args = {}
		vim.ui.input({ prompt = "Args: " }, function(input)
			args = vim.split(input or "", " ")
			coroutine.resume(dap_run_co, args)
		end)
	end)
end

local function dapui_opened()
	local lys = require("dapui.windows").layouts or {}
	local opened = false
	for _, ly in ipairs(lys) do
		if ly:is_open() == true then
			opened = true
		end
	end
	return opened
end

local function wcloud_debug_close()
	--require("dap").close()
	require("dap").terminate()
	if dapui_opened() then
		require("dapui").close()
	end
end

local function wcloud_debug(opts)
	--local str = "host=10.0.50.50 port=12345 service=/root/host"
	local config = {}

	for k, v in string.gmatch(opts.args, "(%w+)=(%S+)") do
		config[k] = v
	end

	if not config.host then
		config.host = "10.0.50.50"
	end

	if not config.port then
		config.port = 12345
	end

	if not config.service then
		vim.notify("need service", vim.log.levels.ERROR)
		return
	end

	local service_name = config.service:match("([^/]+)$")

	local args = {}
	if service_name == "host" or service_name == "host-deployer" then
		args = {
			"--common-config-file",
			"/etc/wcloud/common.conf",
			"--config",
			"/etc/wcloud/host.conf",
		}
	else
		args = {
			"--config",
			"/etc/wcloud/" .. service_name .. ".conf",
		}
	end
	local dap = require("dap")
	dap.adapters.wcloud = {
		type = "server",
		host = config.host,
		port = config.port,
	}
	dap.run({
		type = "wcloud",
		request = "launch",
		mode = "exec",
		program = config.service,
		args = args,
        substitutePath = {
        {
            from = "/Users/rain/code/go/wcloud/backend",
            to = "git.wcloud.cool/wcloud/backend"
        }
    }
	}, {})
	if not dapui_opened() then
		require("dapui").open()
	end
end

return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			--"theHamsta/nvim-dap-virtual-text",
		},
		lazy = true,
		keys = { { "mb" } },
		config = function()
			vim.api.nvim_create_user_command("DapWcloud", wcloud_debug, { nargs = "?" })
			require("dapui").setup({
				icons = {
					expanded = "",
					collapsed = "",
				},
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
				},
				expand_lines = false,
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.5 },
							{ id = "breakpoints", size = 0.2 },
							{ id = "watches", size = 0.3 },
						},
						size = 50,
						open_on_start = true,
						position = "left", -- Can be "left" or "right"
					},
					{
						--open_on_start = false,
						elements = {
							"repl",
							--"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom", -- Can be "bottom" or "top"
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
			})
			local ms = require("mappings")
			local keys = {
				--["mr"] = { f = require("go.dap").run, doc = "run" },
				["mc"] = { f = require("dap").continue, doc = "continue" },
				["mn"] = { f = require("dap").step_over, doc = "step_over" },
				["ms"] = { f = require("dap").step_into, doc = "step_into" },
				["mo"] = { f = require("dap").step_out, doc = "step_out" },
				["mS"] = { f = wcloud_debug_close, doc = "stop" },
				["mu"] = { f = require("dap").up, doc = "up" },
				["mD"] = { f = require("dap").down, doc = "down" },
				["mC"] = { f = require("dap").run_to_cursor, doc = "run_to_cursor" },
				["mb"] = { f = require("dap").toggle_breakpoint, doc = "toggle_breakpoint" },
				["mP"] = { f = require("dap").pause, doc = "pause" },
				["mp"] = { f = require("dapui").eval, m = { "n", "v" }, doc = "eval" },
				["mK"] = { f = require("dapui").float_element, doc = "float_element" },
				-- ["B"] = {
				-- 	f = function()
				-- 		require("dapui").float_element("breakpoints")
				-- 	end,
				-- 	doc = "float_element('breakpoints')",
				-- },
				-- ["R"] = {
				-- 	f = function()
				-- 		require("dapui").float_element("repl")
				-- 	end,
				-- 	doc = "float_element('repl')",
				-- },
				-- ["O"] = {
				-- 	f = function()
				-- 		require("dapui").float_element("scopes")
				-- 	end,
				-- 	doc = "float_element('scopes')",
				-- },
				["ta"] = {
					f = function()
						require("dapui").float_element("stacks")
					end,
					doc = "float_element('stacks')",
				},
				-- ["w"] = {
				-- 	f = function()
				-- 		require("dapui").float_element("watches")
				-- 	end,
				-- 	doc = "float_element('watches')",
				-- },
			}
			ms.nvim_load_mapping(keys)

			--local dap = require("dap")
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
		end,
	},
	{
		"leoluz/nvim-dap-go",
		event = "VeryLazy",
		config = function()
			require("dap-go").setup({
				dap_configurations = {
					-- {
					-- 	type = "go",
					-- 	name = "Debug Package",
					-- 	request = "launch",
					-- 	program = "${fileDirname}",
					-- 	args = get_arguments,
					-- },
				},
			})
		end,
	},
}
