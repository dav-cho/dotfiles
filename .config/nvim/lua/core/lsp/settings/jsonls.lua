local ok, schemastore = pcall(require, 'schemastore')
if not ok then
  vim.notify('~ Schemastore CALL ERROR')
  return
end

-- TODO: need?
--local default_schemas = nil
--local status_ok, jsonls_settings = pcall(require, "nlspsettings.jsonls")
--if status_ok then
--  default_schemas = jsonls_settings.get_default_schemas()
--end

local schemas = {
  {
    description = "TypeScript compiler configuration file",
    fileMatch = {
      "tsconfig.json",
      "tsconfig.*.json",
    },
    url = "https://json.schemastore.org/tsconfig.json",
  },
  {
    description = "NPM configuration file",
    fileMatch = {
      "package.json",
    },
    url = "https://json.schemastore.org/package.json",
  },
  {
    description = "ESLint config",
    fileMatch = {
      ".eslintrc.json",
      ".eslintrc",
    },
    url = "https://json.schemastore.org/eslintrc.json",
  },
  {
    description = "Prettier config",
    fileMatch = {
      ".prettierrc",
      ".prettierrc.json",
      "prettier.config.json",
    },
    url = "https://json.schemastore.org/prettierrc",
  },
  --{
  --  description = "golangci-lint configuration file",
  --  fileMatch = {
  --    ".golangci.toml",
  --    ".golangci.json",
  --  },
  --  url = "https://json.schemastore.org/golangci-lint.json",
  --},
  --{
  --  description = "Packer template JSON configuration",
  --  fileMatch = {
  --    "packer.json",
  --  },
  --  url = "https://json.schemastore.org/packer.json",
  --},
}

return {
  settings = {
    json = {
      schemas = vim.list_extend(schemas, schemastore.json.schemas()),
    },
  },
}

