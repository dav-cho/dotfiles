return function(...)
  local status, lib = pcall(require, ...)
  if (status) then return lib end
  vim.notify('~ ' .. ... .. ' CALL ERROR')
  return nil
end

