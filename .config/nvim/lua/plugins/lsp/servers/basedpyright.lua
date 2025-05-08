local handlers = require "plugins.lsp.handlers"

vim.lsp.config("basedpyright", {
  on_attach = handlers.on_attach,
  on_init = handlers.on_init,
  capabilities = handlers.capabilities(),
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
})
