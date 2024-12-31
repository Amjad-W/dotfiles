local home_dir = vim.fn.expand "$HOME"
local projects_dir = home_dir .. "/Projects"

require("persisted").setup {
  autostart = true,
  use_git_branch = true,
  allowed_dirs = { "~/Projects" },
}
require("telescope").load_extension "persisted"

local map = vim.keymap.set
map("n", "<leader>fs", "<cmd> Telescope persisted <CR>", { desc = "Persisted: Open sessions in telescope" })
