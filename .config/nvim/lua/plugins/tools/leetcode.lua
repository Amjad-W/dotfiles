return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- Or function() vim.cmd [[TSUpdate html]] end
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
}
