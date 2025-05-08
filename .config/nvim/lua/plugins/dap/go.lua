return {
  "leoluz/nvim-dap-go",
  ft = "go",
  dependencies = { "mfussenegger/nvim-dap" },
  opts = {
    dap_configurations = {
      {
        type = "go",
        name = "Debug main.go",
        request = "launch",
        -- program = "${workspaceFolder}/main.go",
        program = "${workspaceFolder}",
        cwd = vim.fn.getcwd(),
      },
    },
  },
}
