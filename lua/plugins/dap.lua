-- Debug
local M = {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        --"leoluz/nvim-dap-go",
    },
    keys = {
        { "<leader>dc", "<cmd>lua require'dap'.continue()<CR>",          desc = "Start or continue debug" },
        { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle breakpoints" },
    }
}

function M.config()
    local ms = require("mappings")
    ms.nnoremap("<leader>ds", "<cmd>lua require'dap'.step_over()<CR>")
    ms.nnoremap("<leader>di", "<cmd>lua require'dap'.step_into()<CR>")
    ms.nnoremap("<leader>do", "<cmd>lua require'dap'.step_out()<CR>")
    ms.nnoremap("<leader>dt", "<cmd>lua require'dap'.stop()<CR>")
    ms.nnoremap("<leader>dg", "<cmd>lua require'dap'.run_to_cursor()<CR>")
    --ms.nnoremap("<leader>dd", "<cmd>lua package.loaded['dap_conf'] = nil; require('dap_conf')<CR>")
    ms.nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>")
    ms.nnoremap("<leader>du", "<cmd>lua require'dapui'.toggle()<CR>")

    local dap = require("dap")
    --vim.fn.sign_define('DapBreakpoint', { text = '⛔', texthl = '', linehl = '', numhl = '' })
    --vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = '', numhl = '' })
    dap.adapters.go = function(callback, _)
        local stdout = vim.loop.new_pipe(false)
        local handle
        local pid_or_err
        local port = 38697
        local opts = {
            stdio = { nil, stdout },
            args = { "dap", "-l", "127.0.0.1:" .. port },
            detached = true
        }
        handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
                stdout:close()
                handle:close()
                if code ~= 0 then
                    print('dlv exited with code', code)
                end
            end)
        assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
        stdout:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    require('dap.repl').append(chunk)
                end)
            end
        end)
        -- Wait for delve to start
        vim.defer_fn(
            function()
                callback({ type = "server", host = "127.0.0.1", port = port })
            end,
            100)
    end
    dap.configurations.go = {
        {
            type = "go",
            name = "zytest",
            request = "launch",
            program = "${workspaceFolder}/main.go"
        },
        {
            type = "go",
            name = "Debug test", -- configuration for debugging test files
            request = "launch",
            mode = "test",
            program = "${file}"
        },
        -- works with go.mod packages and sub packages
        {
            type = "go",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}"
        }
    }
    require('dap.ext.vscode').load_launchjs()
    local dapui = require 'dapui'
    dapui.setup({
        icons = {
            expanded = "",
            collapsed = ""
        },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
        },
        expand_lines = vim.fn.has("nvim-0.7"),
        layouts = {
            {
                elements = {
                    { id = "scopes",      size = 0.5 },
                    { id = "breakpoints", size = 0.2 },
                    { id = "watches",     size = 0.3 },
                },
                size = 50,
                open_on_start = true,
                position = "left" -- Can be "left" or "right"
            },
            {
                --open_on_start = false,
                elements = {
                    "repl",
                    --"console",
                },
                size = 0.25, -- 25% of total lines
                position = "bottom" -- Can be "bottom" or "top"
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
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

return M
