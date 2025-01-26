local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "ruff" },
    -- python = { "isort", "black" },
    bash = { "shfmt" },
    c_sharp = { "csharpier" },
    go = { "gofumpt", "golines" },
  },
  formatters = {
    -- Go
    golines = {
      prepend_args = { "--max-len=80" },
    },
    -- Python
    -- black = {
    --   prepend_args = {
    --     "--fast",
    --     "--line-length",
    --     "80",
    --   },
    -- },
    -- isort = {
    --   prepend_args = {
    --     "--profile",
    --     "black",
    --   },
    -- },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
require("conform").setup(options)
