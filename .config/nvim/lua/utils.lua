local M = {}

M.get_stdpath = function(path)
  local stdpath = vim.fn.stdpath(path)
  if type(stdpath) == "table" then
    return table.concat(stdpath, "")
  end
  return stdpath
end

return M
