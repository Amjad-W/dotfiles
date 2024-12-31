local home_dir = vim.fn.expand "$HOME"
local projects_dir = home_dir .. "/Projects"

require("persisted").setup {
  autostart = true,
  should_save = function()
    local current_file_directory = vim.fn.expand "%:p:h"
    if string.find(file_dir, projects_dir, 1, true) then
      return true
    end
    return false
  end,
}
require("telescope").load_extension "persisted"

local map = vim.keymap.set
map("n", "<leader>fs", "<cmd> Telescope persisted <CR>", { desc = "Persisted: Open sessions in telescope" })
