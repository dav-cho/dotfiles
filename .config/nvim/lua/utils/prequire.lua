return function(module)
  local ok, lib = pcall(require, module)
  if ok then return lib end
  vim.notify(string.format('~ %s Call Error!', module))
  return nil
end

--return function(...)
--  local status, lib = pcall(require, ...)
--  if (status) then return lib end
--  vim.notify('~ ' .. ... .. ' CALL ERROR')
--  return nil
--end

