require "nvchad.mappings"
local map = vim.keymap.set

map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "DAP Toggle Break Point" })
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP Toggle Break Point" })
-- map("n", "<leader>dpr", function() require("dap-python").test_method() end, { desc = "DAP Python Test Method" })
