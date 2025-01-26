require "nvchad.mappings"
local map = vim.keymap.set

-- Basics
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>t", "<cmd>Telescope buffers<CR>", { desc = "Telescope: find buffers" })
map("n", "<leader>fs", "<cmd>Telescope resession<CR>", { desc = "Telescope: find sessions" })
map("n", "<leader>cr", "<cmd>OverseerRun<CR>", { desc = "Overseer: Run task" })

-- ToggleTerm

-- map("n", "<leader>h", function()
--   toggleterm.toggle(nil, hsize, "horizontal", "Vorizontal")
-- end, { desc = "ToggleTerm: New horizontal term" })
--
-- map("n", "<leader>v", function()
--   toggleterm.toggle(nil, vsize, "vertical", "Vertical")
-- end, { desc = "ToggleTerm: New vertical term" })

-- toggleable
-- local nomap = vim.keymap.del
-- nomap({ "n", "t" }, "<A-v>")
-- nomap({ "n", "t" }, "<A-h>")
-- nomap({ "n", "t" }, "<A-i>")

local toggleterm = require "toggleterm"
map({ "i", "n", "t" }, "<A-v>", function()
  toggleterm.toggle(nil, nil, nil, "vertical", "Vertical")
end, { desc = "ToggleTerm: New vertical term" })

map({ "i", "n", "t" }, "<A-h>", function()
  toggleterm.toggle(nil, nil, nil, "horizontal", "Horizontal")
end, { desc = "ToggleTerm: New horizontal term" })

map({ "i", "n", "t" }, "<A-i>", function()
  toggleterm.toggle(nil, nil, nil, "float", "Float")
end, { desc = "ToggleTerm: Toggle floating term" })
