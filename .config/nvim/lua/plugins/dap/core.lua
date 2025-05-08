return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    -- map("n", "<leader>dpr", function() require("dap-python").test_method() end, { desc = "DAP Python Test Method" })

    local debugger = require "dap"
    local ui = require "dapui"
    ui.setup {
      layouts = {
        {
          elements = {
            { id = "breakpoints", size = 0.35 },
            { id = "stacks", size = 0.35 },
            { id = "repl", size = 0.30 },
          },
          position = "right",
          size = 45,
        },
        {
          elements = {
            { id = "scopes", size = 0.5 },
            { id = "watches", size = 0.5 },
            { id = "console", size = 0.20 },
          },
          position = "bottom",
          size = 15,
        },
      },
    }

    -- Hooks
    debugger.listeners.after.attach_dapui_config = function()
      ui.open()
    end
    debugger.listeners.after.launch_dapui_config = function()
      ui.open()
    end
    debugger.listeners.after.event_terminated_dapui_config = function()
      ui.close()
    end
    debugger.listeners.before.event_exited_dapui_config = function()
      ui.close()
    end

    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
  end,
  keys = {
    {
      "<leader>dr",
      function()
        require("dap").continue()
      end,
      { desc = "DAP Continue", mode = "n" },
    },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      { desc = "DAP Continue (F5)", mode = "n" },
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      { desc = "DAP Step Over", mode = "n" },
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      { desc = "DAP Step Into", mode = "n" },
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      { desc = "DAP Step Out", mode = "n" },
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      { desc = "DAP Toggle Breakpoint", mode = "n" },
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle { reset = true }
      end,
      { desc = "DAP Toggle UI", mode = "n" },
    },
  },
}
