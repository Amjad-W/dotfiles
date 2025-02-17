-- This assumes debugerpy is installed
local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
require("dap-python").setup(path)
local map = vim.keymap.set
map("n", "<leader>dpr", function() require("python-dap").test_method() end, { desc = "DAP Python test method"})
