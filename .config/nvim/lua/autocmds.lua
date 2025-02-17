vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

vim.api.nvim_create_autocmd({ "TermClose" }, {
  callback = function(args)
    if type(vim.g.nvchad_terms) ~= "table" then
      return
    end

    local term = vim.g.nvchad_terms[tostring(args.buf)]
    if term and term["id"] == "lazygit" and vim.api.nvim_buf_is_valid(args.buf) then
      vim.cmd("bw " .. args.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    local opts = { buffer = true }
    vim.keymap.set("t", "<C-x>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set("t", "<C-w>", [[<C-\><C-n>:bd!<CR>]], opts)

    vim.keymap.set("t", "<leader>ta", [[<C-\><C-n>:tabnew<CR>]], opts)
    vim.keymap.set("t", "<leader>tc", [[<C-\><C-n>:tabclose<CR>]], opts)
    vim.keymap.set("t", "<leader>tn", [[<C-\><C-n>:tabn<CR>]], opts)
    vim.keymap.set("t", "<leader>tp", [[<C-\><C-n>:tabp<CR>]], opts)
  end,
})
