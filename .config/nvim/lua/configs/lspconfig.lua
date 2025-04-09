local lspconfig = require "lspconfig"

local nvlsp = require "nvchad.configs.lspconfig"
-- NvChad defaults
nvlsp.defaults()
-- Override certain LSP keymappings
local mapped_on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Show hover hint" })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP Show signature" })
end

local default_servers = {
  -- Web
  "html",
  "jsonls",
  "cssls",
  "ts_ls",
  "graphql",
  "terraformls",
  -- Shell
  "bashls",
  "fish_lsp",
  "lua_ls",
  -- DevOps
  "gitlab_ci_ls",
  "helm_ls",
  "nginx_language_server",
  -- Java
  "kotlin_language_server",
}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup {
    on_attach = mapped_on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Configuring servers
-- This force-installs without having to use MasonInstallAll
lspconfig.servers = {
  "lua_ls",
  "gopls",
  "basedpyright",
}

lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    mapped_on_attach(client, bufnr)
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedvariable = true,
      },
      usePlaceholders = true,
      staticcheck = true,
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = mapped_on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  settings = {
    Lua = {
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/love2d/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.basedpyright.setup {
  on_attach = mapped_on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
}
