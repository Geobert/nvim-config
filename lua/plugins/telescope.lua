return {
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            {
                "<leader><leader>",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
                desc = "Switch Buffer",
            },
            { "<leader>,", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
            {
                "<leader>sB",
                LazyVim.pick("grep_string", { grep_open_files = true, search = "" }),
                desc = "Grep (opened files)",
            },
        },
        config = function()
            -- The easiest way to use Telescope, is to start by doing something like:
            --  :Telescope help_tags
            --
            -- Two important keymaps to use while in Telescope are:
            --  - Insert mode: <c-/>
            --  - Normal mode: ?
            --
            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`

            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local function open_files_in_mode(prompt_bufnr, mode)
                local picker = action_state.get_current_picker(prompt_bufnr)
                local selections = picker:get_multi_selection()
                local num_selections = #selections

                if num_selections > 1 then
                    local files_to_open = {}
                    for _, entry in ipairs(selections) do
                        table.insert(files_to_open, entry.value)
                    end

                    local cmd
                    if mode == "newtab" then
                        cmd = "tabnew | e"
                    elseif mode == "vsplit" then
                        cmd = "vsplit"
                    elseif mode == "split" then
                        cmd = "split"
                    end

                    vim.cmd(cmd .. " " .. table.concat(files_to_open, " | " .. cmd .. " "))
                    vim.cmd("stopinsert")
                else
                    -- Handle single file selection based on mode
                    local entry = action_state.get_selected_entry()
                    local cmd
                    if mode == "newtab" then
                        cmd = "tabnew"
                    elseif mode == "vsplit" then
                        cmd = "vsplit"
                    elseif mode == "split" then
                        cmd = "split"
                    else
                        cmd = "edit"
                    end
                    vim.cmd(cmd .. " " .. entry.value)
                end
            end

            local function fzf_multi_select_newtab(prompt_bufnr)
                open_files_in_mode(prompt_bufnr, "newtab")
            end

            local function fzf_multi_select_vsplit(prompt_bufnr)
                open_files_in_mode(prompt_bufnr, "vsplit")
            end

            local function fzf_multi_select_split(prompt_bufnr)
                open_files_in_mode(prompt_bufnr, "split")
            end

            require("telescope").setup({
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                defaults = {
                    winblend = 20,
                    mappings = {
                        i = {
                            ["<c-enter>"] = "to_fuzzy_refine",
                            ["<C-BS>"] = function()
                                vim.api.nvim_input("<C-W>")
                            end,
                            ["<C-Up>"] = actions.cycle_history_prev,
                            ["<C-Down>"] = actions.cycle_history_prev,
                            ["<C-T>"] = fzf_multi_select_newtab,
                            ["<C-V>"] = fzf_multi_select_vsplit,
                            ["<C-S>"] = fzf_multi_select_split,
                            ["<C-f>"] = function(prompt_bufnr)
                                require("telescope.actions.generate").refine(prompt_bufnr, {
                                    prompt_to_prefix = true,
                                    sorter = false,
                                })
                            end,
                        },
                    },
                },
                -- pickers = {}
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                    file_browser = {
                        theme = "sonokai",
                        hijack_netrw = true,
                    },
                },
            })

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
        end,
    },
}
