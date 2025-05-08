return {
  "stevearc/resession.nvim",
  lazy = false,
  opts = {
    extensions = {
      overseer = {},
    },
  },
  keys = {
    {
      "<leader>ss",
      function()
        require("resession").save()
      end,
      desc = "Resession: Save Session",
    },
    {
      "<leader>sl",
      function()
        require("resession").load()
      end,
      desc = "Resession: Load Session",
    },
    {
      "<leader>sd",
      function()
        require("resession").delete()
      end,
      desc = "Resession: Delete Session",
    },
  },
}

-- Save sessions per git branch
-- local function get_session_name()
--   local name = vim.fn.getcwd()
--   local branch = vim.trim(vim.fn.system "git branch --show-current")
--   if vim.v.shell_error == 0 then
--     return name .. branch
--   else
--     return name
--   end
-- end

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     -- Only load the session if nvim was started with no args
--     if vim.fn.argc(-1) == 0 then
--       require("resession").load(get_session_name(), { silence_errors = true })
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   callback = function()
--     require("resession").save(get_session_name(), { notify = false })
--   end,
-- })
