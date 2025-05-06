return {
  -- {
  --   "nanozuki/tabby.nvim",
  --   event = "VimEnter",
  --   dependencies = "nvim-tree/nvim-web-devicons",
  --   config = function()
  --     require "configs.tabby"
  --   end,
  -- },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewRefresh" },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "scottmckendry/telescope-resession.nvim", "nvim-telescope/telescope-media-files.nvim" },
    opts = function(_, conf)
      conf.extensions = {
        resession = {
          prompt_title = "Find Sessions",
        },
        projects = {},
        media_files = {},
      }
    end,
  },
  -- {
  --   lazy = false,
  --   "stevearc/dressing.nvim",
  --   config = function()
  --     require "configs.dressing"
  --   end,
  -- },
  -- Mini stuff
  { "echasnovski/mini.surround", lazy = false, opts = {} },
  { "echasnovski/mini.align", lazy = false, opts = {} },
  { "echasnovski/mini.splitjoin", lazy = false, opts = {} },
  -- { "echasnovski/mini.notify", lazy = false, opts = {} },
  -- Highlights
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.treesitter"
    end,
  },
  -- Lint
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     require "configs.lint"
  --   end,
  -- },
  -- {
  --   "rshkarin/mason-nvim-lint",
  --   event = "VeryLazy",
  --   dependencies = { "nvim-lint" },
  --   config = function()
  --     require "configs.mason-lint"
  --   end,
  -- },
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
    "nvzone/minty",
    cmd = { "Shades", "Hue" },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require "configs.noice"
    end,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = "leetcode.nvim" ~= vim.fn.argv(0, -1),
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      arg = "leetcode.nvim",
      lang = "go",
      injector = {
        ["go"] = {
          before = { "package main", "import ()" },
        },
      },
    },
  },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*",
  --   lazy = true,
  --   ft = "markdown",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "Coding",
  --         path = "~/documents/obsidian/Coding/",
  --       },
  --     },
  --     completion = {
  --       nvim_cmp = true,
  --       min_chars = 2,
  --     },
  --     mappings = {
  --       -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
  --       ["gf"] = {
  --         action = function()
  --           return require("obsidian").util.gf_passthrough()
  --         end,
  --         opts = { noremap = false, expr = true, buffer = true },
  --       },
  --       -- Toggle check-boxes.
  --       ["<leader>ch"] = {
  --         action = function()
  --           return require("obsidian").util.toggle_checkbox()
  --         end,
  --         opts = { buffer = true },
  --       },
  --       -- Smart action depending on context, either follow link or toggle checkbox.
  --       ["<cr>"] = {
  --         action = function()
  --           return require("obsidian").util.smart_action()
  --         end,
  --         opts = { buffer = true, expr = true },
  --       },
  --     },
  --   },
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {
      completions = {
        lsp = {
          enabled = true,
        },
      },
    },
  },
}
