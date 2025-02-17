return {
  -- {
  --   "nanozuki/tabby.nvim",
  --   event = "VimEnter",
  --   dependencies = "nvim-tree/nvim-web-devicons",
  --   config = function()
  --     require "configs.tabby"
  --   end,
  -- },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "scottmckendry/telescope-resession.nvim",
    opts = function(_, conf)
      conf.extensions = {
        resession = {
          prompt_title = "Find Sessions",
        },
        projects = {},
      }
    end,
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
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = false,
    config = function()
      require("scrollbar").setup {}
      require("scrollbar.handlers.gitsigns").setup {}
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
    dependencies = { "hoffs/omnisharp-extended-lsp.nvim" },
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
    cmd = { "LazyGitToggle" },
    config = function()
      require "configs.toggleterm-config"
    end,
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapToggleBreakPoint", "DapStepOver", "DapStepInto", "DapStepOut" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.dap-config"
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require "configs.debuggers.go"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require "configs.debuggers.python"
    end,
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    ft = "lua",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require "configs.debuggers.lua"
    end,
  },
  -- Other
  {
    "j-hui/fidget.nvim",
    config = function()
      require "configs.fidget"
    end,
  },
  {
    "nvzone/minty",
    cmd = { "Shades", "Hue" },
  },
}
