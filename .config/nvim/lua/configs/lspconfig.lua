dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

local lspconfig = require "lspconfig"
local map = vim.keymap.set

-- export on_attach & capabilities
local on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map("n", "gh", vim.lsp.buf.hover, opts "Show hover hint")
  map("n", "gH", vim.diagnostic.open_float, opts "Show hover diagnostic")

  map("n", "gs", vim.lsp.buf.signature_help, opts "LSP Show signature")

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")

  map("n", "gr", vim.lsp.buf.references, opts "Show signature")

  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")

  map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code Actions")
end

-- disable semanticTokens
local on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    on_attach(_, args.buf)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

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
  -- DevOps
  "gitlab_ci_ls",
  "helm_ls",
  "nginx_language_server",
  "taplo",
  -- Java
  "kotlin_language_server",
  -- Haskell
  "hls",
}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Configuring servers
lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
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

local function get_lua_library_paths()
  local library_paths = {
    vim.fn.expand "$VIMRUNTIME/lua",
    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
    "${3rd}/love2d/library",
  }

  -- If we're in our nvim config dir, add every plugin's `lua/` folder:
  if vim.fn.getcwd() == vim.fn.expand "~/.config/nvim" then
    local lazy_root = vim.fn.stdpath "data" .. "/lazy"
    for _, plugin in ipairs(vim.fn.readdir(lazy_root)) do
      local lua_dir = lazy_root .. "/" .. plugin .. "/lua"
      if vim.fn.isdirectory(lua_dir) == 1 then
        table.insert(library_paths, lua_dir)
      end
    end
  end

  return library_paths
end

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = function(client)
    on_init(client)
    client.settings.Lua.workspace.library = get_lua_library_paths()
  end,
  capabilities = capabilities,

  settings = {
    Lua = {
      workspace = {
        library = get_lua_library_paths(),
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.basedpyright.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
}
