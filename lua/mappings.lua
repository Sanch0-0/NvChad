require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "jk", "<ESC>")

-- Склеивает текущую строку со следующей
map("n", "J", "mzJz")
-- Скролл на пол-экрана вниз/вверх
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- При поиске (n/N) перемещает курсор на следующее совпадение
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Движение между окнами
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Движение между окнами терминалов
map("t", "<C-h>", "<cmd>wincmd h<CR>")
map("t", "<C-j>", "<cmd>wincmd j<CR>")
map("t", "<C-k>", "<cmd>wincmd k<CR>")
map("t", "<C-l>", "<cmd>wincmd l<CR>")

-- Ресайз окна
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Ресайз терминала
map("t", "<C-Up>", "<cmd>resize -2<CR>")
map("t", "<C-Down>", "<cmd>resize +2<CR>")
map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Перемещать вбок через < и >
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Перемещать выделенный блок вниз
map("v", "<A-j>", ":m '>+2<CR>gv=gv", { desc = "Move block down" })
-- Перемещать выделенный блок вверх
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Normal mode: двигать строку
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Найти все места, где используется данный символ
map("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")

-- Удалять на d без копирования
map({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
map({ "n", "v" }, "D", '"_D', { desc = "Delete to end of line without yanking" })
map({ "n", "v" }, "x", '"_x', { desc = "Delete char without yanking" })

-- Выбор venv окружения
map("n", "<leader>V", ":VenvSelect<CR>", { desc = "Select virtual env" })

-- Переходы по табам
map("n", "<A-t>", ":tabnew<CR>", { desc = "Open new tab" })
map("n", "<A-T>", ":tabclose<CR>", { desc = "Close current tab" })
map("n", "<A-Right>", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<A-Left>", ":tabprevious<CR>", { desc = "Previous tab" })

-- Быстрое сохранение
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Подсказка по типу под курсором
map("n", "K", ":lua vim.lsp.buf.hover()<CR>", { desc = "Hover docs" })

-- Очистка поиска и уведомлений по Esc
map("n", "<Esc>", "<cmd>noh<CR><cmd>lua require('notify').dismiss()<CR>", { desc = "Clear search and notifications" })

-- Git blame маппинги
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle git blame" })
map("n", "<leader>gB", "<cmd>Gitsigns blame_line<CR>", { desc = "Show blame for line" })

-- Git diff и изменения
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Show git diff" })
map("n", "<leader>gD", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "Toggle deleted lines" })

-- Просмотр всей истории файла
map("n", "<leader>gH", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "Toggle file history" })

-- Открыть/закрыть quickfix list
map("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })

-- Прикрепить сигнатуру
map("n", "K", function()
  require("lsp_signature").toggle_float_win()
end, { desc = "Toggle signature help" })
