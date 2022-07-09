-- TODO: Also in plugins.lua
local download_packer = function()
  if vim.fn.input "Download Packer? (y for yes)" ~= "y" then
    return
  end

  -- Auto Install Packer
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  end

  -- local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")

  -- vim.fn.mkdir(directory, "p")

  -- local out = vim.fn.system(
  --   string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  -- )

  print(out)
  print "Downloading packer.nvim..."
  print "( You'll need to restart now )"
  vim.cmd [[qa]]
end

return function()
  if not pcall(require, "packer") then
    download_packer()

    return true
  end

  return false
end
