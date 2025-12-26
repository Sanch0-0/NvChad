-- lua/configs/lspconfig.lua
local lsp_defaults = require("nvchad.configs.lspconfig").defaults() or {}
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Заглушаем встроенный модуль сигнатур NvChad
pcall(function()
  local sig = require "nvchad.signature"
  if sig and type(sig.setup) == "function" then
    sig.setup = function() end
  end
end)

-- Функция on_attach
local on_attach = function(client, bufnr)
  -- Отключаем всплывающие окна signature help от LSP
  vim.lsp.handlers["textDocument/signatureHelp"] = function() end
end

-- Список серверов
local servers = { "pyright", "html", "cssls", "ruff" }

for _, server_name in ipairs(servers) do
  local config = vim.lsp.config[server_name] or {}

  config = vim.tbl_deep_extend("force", config, {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.enable(server_name, config)
end

-- Кастомная настройка Ruff
vim.lsp.config.ruff = vim.lsp.config.ruff or {}
vim.lsp.config.ruff = vim.tbl_deep_extend("force", vim.lsp.config.ruff, {
  on_attach = on_attach,
  init_options = {
    settings = {
      args = {
        "--select=ALL",
        "--fix", -- включаем авто-исправление
        "--show-source", -- выводит короткие, user-friendly сообщения
        "--remove-unused-imports", -- удаляет неиспользуемые импорты
        "--line-length=88", -- как в Black
      },
      organizeImports = true,
    },
  },
})
vim.lsp.enable "ruff"

-- Сохраняем оригинальный обработчик
local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  -- Фильтруем только Pyright
  if client and client.name == "pyright" and result.diagnostics then
    for _, diagnostic in ipairs(result.diagnostics) do
      local msg = diagnostic.message

      -- Ищем паттерн: 3 или более пробелов
      -- %s%s%s+ означает "два пробела и затем один или более пробелов"
      local tail = msg:match ".*%s%s%s+(.*)"

      if tail then
        -- Если нашли "хвост" после пробелов, заменяем сообщение на него
        -- Дополнительно убираем возможные лишние пробелы по краям
        diagnostic.message = tail:gsub("^%s*(.-)%s*$", "%1")
      elseif msg:find "\n" then
        -- Если длинных пробелов нет, но есть переносы строк,
        -- часто самая суть в Pyright идет на ПОСЛЕДНЕЙ строке
        local lines = {}
        for line in msg:gmatch "([^\n]+)" do
          table.insert(lines, line)
        end
        diagnostic.message = lines[#lines]:gsub("^%s*(.-)%s*$", "%1")
      end
    end
  end

  -- Передаем измененный результат дальше
  original_handler(err, result, ctx, config)
end

-- Загружаем дефолты NvChad (сокращения, капабилити и т.д.)
-- local nvlsp = require "nvchad.configs.lspconfig"
-- local on_attach = nvlsp.on_attach
-- local on_init = nvlsp.on_init
-- local capabilities = nvlsp.capabilities
--
-- -- Список серверов для стандартной настройки
-- local servers = { "html", "cssls" }
--
-- -- Настройка стандартных серверов через новый API
-- for _, name in ipairs(servers) do
--   vim.lsp.enable(name, {
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--   })
-- end
--
-- -- 1. PYRIGHT: Интеллект без "шума"
-- vim.lsp.enable("pyright", {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--   settings = {
--     python = {
--       analysis = {
--         typeCheckingMode = "on",
--         diagnosticMode = "workflow",
--       },
--     },
--   },
-- })
--
-- -- 2. RUFF: Линтинг, Форматирование и Сигнатуры
-- vim.lsp.enable("ruff", {
--   on_attach = function(client, bufnr)
--     on_attach(client, bufnr)
--     -- Отключаем hover у Ruff, чтобы Pyright мог показывать доки/сигнатуры
--     if client.server_capabilities then
--       client.server_capabilities.hoverProvider = false
--     end
--   end,
--   on_init = on_init,
--   capabilities = capabilities,
--   init_options = {
--     settings = {
--       args = {
--         "--select=ALL",
--         "--fix",
--         "--show-source",
--         "--remove-unused-imports",
--         "--line-length=88",
--       },
--       organizeImports = true,
--     },
--   },
-- })
