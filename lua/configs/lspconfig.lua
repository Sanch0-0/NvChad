-- lua/configs/lspconfig.lua
local lspconfig = require "lspconfig"
local lsp_defaults = require("nvchad.configs.lspconfig").defaults() or {}

local servers = { "pyright", "html", "cssls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(vim.tbl_deep_extend("force", lsp_defaults, {}))
end

lspconfig.pyright.setup {
  on_attach = lsp_defaults.on_attach,
  capabilities = lsp_defaults.capabilities,
  settings = {
    pyright = {
      disableDiagnosticCodes = { "reportUnreachable" }, -- именно unreachable code
    },
  },
}
