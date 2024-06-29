return {
    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
                config = function()
                    require("telescope").load_extension("file_browser")
                end,
            },
            -- Useful for getting pretty icons, but requires a Nerd Font.
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
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

            -- See `:help telescope.builtin`
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<leader>si", builtin.grep_string, { desc = "R[i]pgrep" })
            vim.keymap.set("n", "<leader>sb", function()
                require("telescope").extensions.file_browser.file_browser()
            end, { desc = "File [B]rowse" })

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set("n", "<leader>/", function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = "[/] Fuzzily search in current buffer" })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set("n", "<leader>s/", function()
                builtin.live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                })
            end, { desc = "[S]earch [/] in Open Files" })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set("n", "<leader>sn", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "[S]earch [N]eovim files" })
        end,
    },
}
