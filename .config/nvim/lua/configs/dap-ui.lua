local dap = require "dap"
local dapui = require "dapui"
dapui.setup()

local map = vim.keymap.set
map("n", "<leader>du", "<cmd> lua require('dapui').toggle()<CR>", { desc = "DAP Toggle UI" })

-- Hooks
dap.listeners.after.attach_dapui_config = function()
  dapui.open()
end
dap.listeners.after.launch_dapui_config = function()
  dapui.open()
end
dap.listeners.after.event_terminated_dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited_dapui_config = function()
  dapui.close()
end
