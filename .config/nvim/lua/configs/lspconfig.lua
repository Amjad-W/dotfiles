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
  "htmx",
  "jsonls",
  "cssls",
  -- Python
  "pyright",
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
  "omnisharp",
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

lspconfig.omnisharp.setup {
  on_attach = mapped_on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "dotnet", "/home/amjadw/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
  handlers = {
    ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
    ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
    ["textDocument/references"] = require("omnisharp_extended").references_handler,
    ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
  },
  settings = {
    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,
    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,
    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = true,
    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,
    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = true,
    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,
    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
  },
}
