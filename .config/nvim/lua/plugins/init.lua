return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "scottmckendry/telescope-resession.nvim",
    opts = {
      extensions = {
        resession = {
          prompt_title = "Find Sessions",
        },
      },
    },
  },
  {
    lazy = false,
    "stevearc/dressing.nvim",
    config = function()
      require "configs.dressing"
    end,
  },
  -- Mini stuff
  {
    "echasnovski/mini.surround",
    lazy = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "echasnovski/mini.align",
    lazy = false,
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    lazy = false,
    config = function()
      require("mini.splitjoin").setup()
    end,
  },
  -- Highlights
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.treesitter"
    end,
  },
  -- Lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
      require "configs.mason-lint"
    end,
  },
  -- Conform
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = { "conform.nvim" },
    config = function()
      require "configs.mason-conform"
    end,
  },
  -- Tree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require "configs.nvimtree"
    end,
  },
  -- Session
  {
    "stevearc/resession.nvim",
    lazy = false,
    config = function()
      require "configs.resession"
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lspconfig" },
    config = function()
      require "configs.mason-lspconfig"
    end,
  },
  {
    "hoffs/omnisharp-extended-lsp.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  -- Command Runner
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerOpen", "OverseerRun", "OverseerToggle", "OverseerBuild" },
    config = function()
      require "configs.overseer"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require "configs.toggleterm"
    end,
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end,
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require "configs.dap-ui"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
      require "configs.dap-python"
    end,
  },
}
