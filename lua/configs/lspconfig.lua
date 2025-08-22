-- lua/configs/lspconfig.lua
local lspconfig = require "lspconfig"
local lsp_defaults = require("nvchad.configs.lspconfig").defaults() or {}

local servers = { "pyright", "jedi_language_server", "html", "cssls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(vim.tbl_deep_extend("force", lsp_defaults, {}))
end
