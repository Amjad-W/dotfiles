return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap" },
  opts = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python",
  keys = {
    {
      "<leader>dpr",
      function()
        require("python-dap").test_method()
      end,
      { desc = "DAP Python test method" },
    },
  },
}
