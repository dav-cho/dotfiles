return function(mod)
  local ok, lib = pcall(require, mod)
  if ok then return lib end
  vim.notify('~ ' .. mod .. ' CALL ERROR')
  return nil
end

--return function(...)
--  local status, lib = pcall(require, ...)
--  if (status) then return lib end
--  vim.notify('~ ' .. ... .. ' CALL ERROR')
--  return nil
--end

