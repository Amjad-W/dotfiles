return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerRun",
    "OverseerToggle",
    "OverseerBuild",
    "OverseerClose",
    "OverseerTaskAction",
    "OverseerSaveBundle",
    "OverseerLoadBundle",
    "OverseerDeleteBundle",
  },
  keys = {
    { "<leader>cr", "<cmd>OverseerRun<cr>", desc = "Overseer Run" },
    { "<leader>ct", "<cmd>OverseerToggle<cr>", desc = "Overseer Toggle" },
  },
  config = function()
    local overseer = require "overseer"

    overseer.setup {
      strategy = {
        "toggleterm",
        direction = "vertical",
        size = 100,
        auto_scroll = true,
      },
    }

    -- Templates
    overseer.register_template {
      name = "go run",
      builder = function()
        return {
          cmd = { "go", "run" },
          args = { "." },
          cwd = ".", -- Consider making this dynamic, e.g., vim.fn.expand('%:p:h') for current file's dir
          components = {
            "unique",
            "default",
            "on_output_quickfix",
          },
        }
      end,
      condition = {
        filetype = { "go" },
        root = { "go.mod" },
      },
    }

    -- Example of another template:
    -- overseer.register_template({
    --   name = "npm run dev",
    --   builder = function(params)
    --     return {
    --       cmd = { "npm", "run", "dev" },
    --       cwd = params.dir or vim.fn.getcwd(),
    --       components = { "default", "unique" },
    --     }
    --   end,
    --   condition = {
    --     -- Only suggest if a package.json is found in the current dir or parent dirs
    --     callback = function()
    --       return vim.fn.filereadable(vim.fn.findfile("package.json", ".;")) == 1
    --     end,
    --   },
    --   -- This makes it the default task for projects with a package.json
    --   -- and a "dev" script.
    --   -- priority = 50
    -- })
  end,
}
