return {
  "rshkarin/mason-nvim-lint",
  dependencies = {
    "mfussenegger/nvim-lint",
    "williamboman/mason.nvim",
  },
  config = function()
    local nvim_lint_ok, lint = pcall(require, "lint")
    if not nvim_lint_ok then
      vim.notify("nvim-lint not found!", vim.log.levels.ERROR)
      return
    end

    lint.linters_by_ft = {
      -- lua = { "luacheck" },
      python = { "ruff" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("CustomNvimLint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    local mason_nvim_lint_ok, mason_nvim_lint = pcall(require, "mason-nvim-lint")
    if not mason_nvim_lint_ok then
      vim.notify("mason-nvim-lint not found!", vim.log.levels.ERROR)
      return
    end

    local ignore_install = {}
    local function table_contains(tbl, value)
      for _, v in ipairs(tbl) do
        if v == value then
          return true
        end
      end
      return false
    end

    local all_linters_to_install = {}
    if lint and lint.linters_by_ft then
      for ft, linters_for_ft in pairs(lint.linters_by_ft) do
        vim.notify("Processing ft: " .. ft, vim.log.levels.INFO) -- Debug
        if type(linters_for_ft) == "table" then
          for _, linter_name in ipairs(linters_for_ft) do
            vim.notify("  Linter: " .. linter_name, vim.log.levels.INFO) -- Debug
            if not table_contains(ignore_install, linter_name) then
              table.insert(all_linters_to_install, linter_name)
            end
          end
        elseif type(linters_for_ft) == "string" then
          vim.notify("  Linter (string): " .. linters_for_ft, vim.log.levels.INFO) -- Debug
          if not table_contains(ignore_install, linters_for_ft) then
            table.insert(all_linters_to_install, linters_for_ft)
          end
        end
      end
    else
      vim.notify("nvim-lint.linters_by_ft not available for mason-nvim-lint setup", vim.log.levels.WARN)
    end

    local unique_linters = {}
    local seen = {}
    for _, linter in ipairs(all_linters_to_install) do
      if not seen[linter] then
        table.insert(unique_linters, linter)
        seen[linter] = true
      end
    end
    all_linters_to_install = unique_linters
    vim.notify("Linters to install: " .. vim.inspect(all_linters_to_install), vim.log.levels.INFO)

    mason_nvim_lint.setup {
      ensure_installed = all_linters_to_install,
      automatic_installation = false,
    }

    vim.notify("Linting plugin (nvim-lint & mason-nvim-lint) configured!", vim.log.levels.INFO)
  end,
}
