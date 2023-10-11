return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        -- event = "VeryLazy",
        ft = "norg",
        dependencies = { "nvim-lua/plenary.nvim", "folke/zen-mode.nvim", "nvim-neorg/neorg-telescope" },
        keys = {
            {
                "<Leader>nn",
                "<cmd>Neorg index<cr>",
                desc = "Neorg index",
            },
            {
                "<Leader>nwn",
                "<cmd>Neorg workspace work<cr><cmd>Neorg index<cr>",
            },
            {
                "<Leader>nwt",
                "<cmd>Neorg workspace work<cr><cmd>Neorg journal today<cr>",
            },
        },
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {
                        config = {
                            icons = {
                                code_block = {
                                    conceal = true,
                                    --width = "content",
                                },
                            },
                        },
                    }, -- Adds pretty icons to your documents
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                            name = "neorg",
                        },
                    },
                    ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                note = "~/Documents/neorg/note",
                                work = "~/Documents/neorg/work",
                            },
                            default_workspace = "note",
                        },
                    },
                    ["core.highlights"] = {
                        config = {
                            highlights = {
                                headings = {
                                    [1] = {
                                        prefix = "+GruvboxOrange",
                                        title = "+GruvboxOrange",
                                    },
                                    [2] = {
                                        prefix = "+GruvboxPurple",
                                        title = "+GruvboxPurple",
                                    },
                                    [3] = {
                                        title = "+GruvboxYellow",
                                        prefix = "+GruvboxYellow",
                                    },
                                    [4] = {
                                        title = "+GruvboxGreen",
                                        prefix = "+GruvboxGreen",
                                    },
                                    [5] = {
                                        title = "+GruvboxAqua",
                                        prefix = "+GruvboxAqua",
                                    },
                                    [6] = {
                                        title = "+GruvboxGreen",
                                        prefix = "+GruvboxGreen",
                                    },
                                },
                                todo_items = {
                                    undone = "+GruvboxRed",
                                },
                            },
                        },
                    },
                    ["core.keybinds"] = {
                        config = {
                            hook = function(keybinds)
                                keybinds.unmap("norg", "n", "<Leader>nid")
                                keybinds.remap_event("norg", "n", "<Leader>nc", "core.looking-glass.magnify-code-block")
                                keybinds.remap_event(
                                    "norg",
                                    "n",
                                    "<Leader>ni",
                                    "core.integrations.telescope.insert_link"
                                )
                                keybinds.remap_event(
                                    "norg",
                                    "n",
                                    "<Leader>nwl",
                                    "core.integrations.telescope.switch_workspace"
                                )
                                keybinds.map("norg", "n", "<Leader>np", "<Cmd>Neorg presenter start<CR>")
                            end,
                            neorg_leader = "<Leader>n",
                        },
                    },
                    ["core.integrations.telescope"] = {},
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "norg",
                callback = function()
                    vim.opt_local.conceallevel = 3
                end,
            })
        end,
    },
    {
        "3rd/image.nvim",
        --enabled = false,
        ft = { "markdown", "vimwiki", "norg" },
        config = function()
            require("image").setup({
                backend = "kitty",
                integrations = {
                    syslang = {
                        enabled = false,
                    },
                    markdown = {
                        enabled = false,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = true,
                        filetypes = { "norg" },
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = 40,
                max_height_window_percentage = 30,
                window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            })
        end,
    },
    {
        "rainzm/nvim-picgo",
        ft = { "norg", "markdown" },
        opts = {
            notice = "notify",
            image_name = false,
            debug = false,
        },
    },
}
