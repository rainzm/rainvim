local function get_arguments()
	return coroutine.create(function(dap_run_co)
		local args = {}
		vim.ui.input({ prompt = "Args: " }, function(input)
			args = vim.split(input or "", " ")
			coroutine.resume(dap_run_co, args)
		end)
	end)
end

return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			--"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
		},
		lazy = true,
		keys = { { "mb" } },
		--cmd = { "GoDebug" },
		config = function()
			local ms = require("mappings")
			local keys = {
				["mr"] = { f = require("go.dap").run, doc = "run" },
				["mc"] = { f = require("dap").continue, doc = "continue" },
				["mn"] = { f = require("dap").step_over, doc = "step_over" },
				["ms"] = { f = require("dap").step_into, doc = "step_into" },
				["mo"] = { f = require("dap").step_out, doc = "step_out" },
				["mS"] = { f = require("go.dap").stop, doc = "stop" },
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
		config = function()
			require("dap-go").setup({
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						type = "go",
						name = "Debug Package",
						request = "launch",
						program = "${fileDirname}",
						args = get_arguments,
					},
				},
				-- delve configurations
				delve = {
					-- the path to the executable dlv which will be used for debugging.
					-- by default, this is the "dlv" executable on your PATH.
					path = "dlv",
					-- time to wait for delve to initialize the debug session.
					-- default to 20 seconds
					initialize_timeout_sec = 20,
					-- a string that defines the port to start delve debugger.
					-- default to string "${port}" which instructs nvim-dap
					-- to start the process in a random available port
					port = "${port}",
					-- additional args to pass to dlv
					args = {},
					-- the build flags that are passed to delve.
					-- defaults to empty string, but can be used to provide flags
					-- such as "-tags=unit" to make sure the test suite is
					-- compiled during debugging, for example.
					-- passing build flags using args is ineffective, as those are
					-- ignored by delve in dap mode.
					build_flags = "",
				},
			})
		end,
	},
}
