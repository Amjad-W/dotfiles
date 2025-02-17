local toggleterm = require "toggleterm"
local M = {}

toggleterm.setup {
  size = function(term)
    if term.direction == "horizontal" then
      return math.floor(vim.o.lines * 0.6)
    elseif term.direction == "vertical" then
      return math.floor(vim.o.columns * 0.85)
    end
  end,
  -- open_mapping = "<A-t>",
  start_in_insert = true,
  -- persist_size = false,
}

-- Terminal Commands
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
vim.cmd "autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()"

-- Custom Terminals
local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new {
  cmd = "lazygit",
  hidden = true,
  display_name = "LazyGit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  on_close = function()
    vim.cmd "startinsert!"
  end,
}

function M.lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_create_user_command("LazyGitToggle", function()
  M.lazygit_toggle()
end, {})

return M
