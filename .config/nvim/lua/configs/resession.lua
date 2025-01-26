local resession = require "resession"

resession.setup {
  -- autosave = {
  --   enabled = true,
  --   interval = 60,
  --   notify = true,
  -- },
  extensions = {
    overseer = {},
  },
}

-- Save sessions per git branch
local function get_session_name()
  local name = vim.fn.getcwd()
  local branch = vim.trim(vim.fn.system "git branch --show-current")
  if vim.v.shell_error == 0 then
    return name .. branch
  else
    return name
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only load the session if nvim was started with no args
    if vim.fn.argc(-1) == 0 then
      resession.load(get_session_name(), { silence_errors = true })
    end
  end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    resession.save(get_session_name(), { notify = false })
  end,
})

-- Mappings
local map = vim.keymap.set
local function opts(desc)
  return {
    desc = "Resession: " .. desc,
  }
end
map("n", "<leader>ss", resession.save, { desc = "Save" })
map("n", "<leader>sl", resession.load, { desc = "Load" })
map("n", "<leader>sd", resession.delete, { desc = "Delete" })
