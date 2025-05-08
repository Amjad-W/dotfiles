return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "LazyGitToggle", "ToggleTerm" },
  keys = {
    {
      "<leader>gg",
      function()
        require("plugins.tools.terminals.lazygit").ToggleLazyGit()
      end,
      desc = "Toggle LazyGit",
    },
  },
  config = function()
    require("toggleterm").setup {
      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.4)
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.5)
        end
      end,
      -- open_mapping = [[<c-\>]], -- A common mapping, but can be removed if using keys table exclusively
      start_in_insert = true,
      persist_size = true,
      -- persist_mode = true, -- Persists the mode of the terminal, default is true
      close_on_exit = true,
      direction = "float",
      float_opts = {
        border = "double",
        -- winblend = 0,
        -- highlights = {
        --   border = "Normal",
        --   background = "Normal",
        -- }
      },
      on_open = function(term)
        local opts = { buffer = term.bufnr, noremap = true, silent = true }
        -- Exit terminal mode
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        -- Window navigation
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        -- Pass C-w to Neovim for window management (e.g., C-w C-w to switch windows)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end,
      shell = vim.o.shell,
      -- winbar = {
      --   enabled = false,
      --   name_formatter = function(term) -- Show terminal name in winbar
      --     return term.name
      --   end,
      -- },
    }
  end,
}
