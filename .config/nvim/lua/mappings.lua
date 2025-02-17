require "nvchad.mappings"
local map = vim.keymap.set
local unmap = vim.keymap.del

-- Basics
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical Split", noremap = true })
map("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split", noremap = true })

-- Tabs
map({ "n", "t" }, "<leader>ta", ":$tabnew<CR>", { noremap = true })
map({ "n", "t" }, "<leader>tc", ":tabclose<CR>", { noremap = true })
map({ "n", "t" }, "<leader>tn", ":tabn<CR>", { noremap = true })
map({ "n", "t" }, "<leader>tp", ":tabp<CR>", { noremap = true })

-- Move to buffer using Alt+bufnr
for i = 1, 9 do
  map("n", string.format("<A-%s>", i), function()
    local buf = vim.t.bufs[i]
    if buf and vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_set_current_buf(buf)
    else
      vim.notify(string.format("No buffer assigned to Alt-%d", i), vim.log.levels.WARN)
    end
  end, { silent = true, noremap = true })
end

-- Telescope
map("n", "<A-tab>", "<cmd>Telescope buffers sort_lastused=true<CR>", { desc = "Telescope: Find buffers" })
map("n", "<leader>fs", "<cmd>Telescope resession<CR>", { desc = "Telescope: Find sessions" })
map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Telescope: Recent projects" })
map("n", "<leader>cr", "<cmd>OverseerRun<CR>", { desc = "Overseer: Run task" })

-- Terminal
unmap("n", "<leader>h") -- Originally used for NvChad term splits
unmap("n", "<leader>v")

map("n", "<leader>t|", function()
  require("nvchad.term").new {
    pos = "vsp",
  }
end, {
  desc = "Term: Vertical Split",
  noremap = true,
})

map("n", "<leader>t-", function()
  require("nvchad.term").new {
    pos = "sp",
  }
end, {
  desc = "Term: Horizontal Split",
  noremap = true,
})

map({ "n", "t" }, "<leader>gg", function()
  require("nvchad.term").runner {
    pos = "float",
    id = "lazygit",
    cmd = "lazygit && exit",
  }
end, { noremap = true, silent = true, desc = "Open LazyGit Terminal" })

-- map({ "i", "n", "t" }, "<A-v>", function()
--   require("toggleterm").toggle(nil, nil, nil, "vertical", "Vertical")
-- end, { desc = "ToggleTerm: New vertical term" })
--
-- map({ "i", "n", "t" }, "<A-h>", function()
--   require("toggleterm").toggle(nil, nil, nil, "horizontal", "Horizontal")
-- end, { desc = "ToggleTerm: New horizontal term" })
--
-- map({ "i", "n", "t" }, "<A-i>", function()
--   require("toggleterm").toggle(nil, nil, nil, "float", "Float")
-- end, { desc = "ToggleTerm: Toggle floating term" })

-- map(
--   "n",
--   "<leader>gg",
--   "<cmd>LazyGitToggle<CR>",
--   { noremap = true, silent = true, desc = "ToggleTerm: Open LazyGit Terminal" }
-- )

-- Dap
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "DAP Continue" })
map("n", "<F5>", function()
  require("dap").continue()
end)
map("n", "<F10>", function()
  require("dap").step_over()
end)
map("n", "<F11>", function()
  require("dap").step_into()
end)
map("n", "<F12>", function()
  require("dap").step_out()
end)

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP Toggle Break Point" })
map("n", "<leader>du", "<cmd> lua require('dapui').toggle({ reset = true })<CR>", { desc = "DAP Toggle UI" })
