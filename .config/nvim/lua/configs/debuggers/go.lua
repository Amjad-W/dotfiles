require("dap-go").setup {
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
}
