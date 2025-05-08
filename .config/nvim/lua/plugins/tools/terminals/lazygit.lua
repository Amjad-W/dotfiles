local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit_terminal = Terminal:new {
  cmd = "lazygit",
  hidden = true,
  display_name = "LazyGit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
    width = function()
      return math.floor(vim.o.columns * 0.9)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.9)
    end,
  },
  on_open = function(term)
    -- Lazygit is a TUI. Forcing Neovim into insert mode is often not needed
    -- and might conflict with Lazygit's own keybindings.
    -- The original config had `vim.cmd "startinsert!"` here.
    -- If lazygit doesn't behave as expected without it, you can uncomment the line below.
    -- vim.cmd "startinsert!"

    -- Add a 'q' mapping in Normal mode to close this specific floating terminal
    -- Ensure the terminal buffer is in normal mode for this mapping to trigger,
    -- or that lazygit itself doesn't capture 'q' before Neovim does.
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- on_close = function(term)
  --   -- Code to run when this specific terminal closes
  -- end,
}

-- Expose the toggle function globally for the command and keymaps
-- Using _G is simple; for more complex setups, consider a dedicated module.
M.ToggleLazyGit = function()
  lazygit_terminal:toggle()
end

-- Expose the toggle function via a user command for easy access
vim.api.nvim_create_user_command("LazyGitToggle", "_G.ToggleLazyGit()", {
  desc = "Toggle LazyGit terminal window",
})

return M
