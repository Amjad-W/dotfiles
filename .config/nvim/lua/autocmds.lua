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
    local term = vim.g.nvchad_terms[tostring(args.buf)]
    if term and term["id"] == "lazygit" and vim.api.nvim_buf_is_valid(args.buf) then
      vim.cmd("bw " .. args.buf)
    end
  end,
})
