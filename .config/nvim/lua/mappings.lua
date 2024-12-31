require "nvchad.mappings"
local map = vim.keymap.set

-- Basics
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>t", "<cmd>Telescope buffers<CR>", { desc = "Telescope: find buffers" })
