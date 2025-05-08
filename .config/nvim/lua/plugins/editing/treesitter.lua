return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ensure_installed = {
      -- Defaults
      "vim",
      "vimdoc",
      -- Web
      "html",
      "css",
      "typescript",
      "javascript",
      "toml",
      -- Lua
      "lua",
      -- Shell
      "bash",
      "fish",
      -- Go
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "gowork",
      -- Other
      "c_sharp",
      "python",
      "rust",
      "terraform",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  },
  build = ":TSUpdate",
}
