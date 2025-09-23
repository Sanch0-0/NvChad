-- lua/configs/lspconfig.lua
local lsp_defaults = require("nvchad.configs.lspconfig").defaults() or {}
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- заглушаем встроенный модуль сигнатур NvChad
pcall(function()
  local sig = require "nvchad.signature"
  if sig and type(sig.setup) == "function" then
    sig.setup = function() end
  end
end)

local on_attach = function(client, bufnr)
  -- Отключаем стандартное всплывающее окно Neovim
  vim.lsp.handlers["textDocument/signatureHelp"] = function() end
end

-- НОВЫЙ СПОСОБ для Neovim 0.11+
local servers = { "pyright", "html", "cssls", "ruff" }

for _, server_name in ipairs(servers) do
  -- Получаем конфиг по умолчанию для сервера
  local config = vim.lsp.config[server_name] or {}

  -- Объединяем с нашими настройками
  config = vim.tbl_deep_extend("force", config, {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Активируем LSP сервер
  vim.lsp.enable(server_name, config)
end

-- Кастомные настройки для Ruff
vim.lsp.config.ruff = vim.lsp.config.ruff or {}
vim.lsp.config.ruff = vim.tbl_deep_extend("force", vim.lsp.config.ruff, {
  on_attach = on_attach,
  init_options = {
    settings = {
      args = { "--select=ALL", "--ignore=E501" },
      organizeImports = true,
    },
  },
})
vim.lsp.enable "ruff"

-- Кастомные настройки для Pyright
vim.lsp.config.pyright = vim.lsp.config.pyright or {}
vim.lsp.config.pyright = vim.tbl_deep_extend("force", vim.lsp.config.pyright, {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable "pyright"
