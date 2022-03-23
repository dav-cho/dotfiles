local ok, colorizer = pcall(require, 'colorizer')
if not ok then
  vim.notify('~ Colorizer Call Error!')
  return
end

colorizer.setup({ '*' }, {
  mode = 'foreground',
})

