return {
    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'

        config = function() -- This is the function that runs, AFTER loading
            local wk = require("which-key")
            wk.setup()
            local pickers = require("telescope.pickers")

            local function insert_markdown_fence(language, original_pos)
                -- Immediate capture of the buffer to recall its essence
                local buffer = vim.api.nvim_get_current_buf()

                -- Crafting the markdown magic with the user's chosen language
                local markdown_fence = { "```" .. language, "", "```" }

                -- Insert the markdown fence into the buffer, right at the cursor's original coordinate, saved against the fabric of time
                vim.api.nvim_buf_set_lines(buffer, original_pos[1], original_pos[1], false, markdown_fence)

                -- Calculating the new position within the markdown sanctuary and transitioning into insert mode
                local insertion_point = original_pos[1] + 2
                vim.api.nvim_win_set_cursor(0, { insertion_point, 0 })
                vim.api.nvim_input("A")
            end

            local function language_picker()
                -- Immediate capture of the cursor's position to anchor it against time's flow before `pickers.new` resets it
                local cursor_position = vim.api.nvim_win_get_cursor(0)

                pickers
                    .new({}, {
                        prompt_title = "Language for markdown fence: ",
                        finder = require("telescope.finders").new_table({
                            results = {
                                "bash",
                                "c",
                                "cpp",
                                "css",
                                "dart",
                                "dockerfile",
                                "elixir",
                                "go",
                                "html",
                                "java",
                                "javascript",
                                "json",
                                "lua",
                                "markdown",
                                "php",
                                "python",
                                "ruby",
                                "rust",
                                "sql",
                                "shell",
                                "typescript",
                                "vim",
                                "yaml",
                            },
                        }),
                        sorter = require("telescope.config").values.generic_sorter({}),
                        attach_mappings = function(prompt_bufnr)
                            require("telescope.actions.set").select:replace(function(_, type)
                                local entry = require("telescope.actions.state").get_selected_entry()
                                require("telescope.actions").close(prompt_bufnr)
                                -- Reusing the cursor position captured before `pickers.new` was invoked
                                insert_markdown_fence(entry.value, cursor_position)
                            end)
                            return true
                        end,
                    })
                    :find()
            end
            -- Document existing key chains
            wk.add({
                { "<leader>C", "<cmd>lua require('notify').dismiss()<CR>", desc = "Clear Notifs" },
                { "<leader>c", group = "[C]ode" },
                { "<leader>c_", hidden = true },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>d_", hidden = true },
                { "<leader>lf", language_picker, desc = "Insert Markdown Fence" },
                { "<leader>r", group = "[R]ename" },
                { "<leader>r_", hidden = true },
                { "<leader>s", group = "[S]earch" },
                { "<leader>s_", hidden = true },
                { "<leader>w", group = "[W]orkspace" },
                { "<leader>w_", hidden = true },
            })
        end,
    },
}
