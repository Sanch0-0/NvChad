require "nvchad.mappings"

local map = vim.keymap.set

map("i", "jk", "<ESC>")

-- Скролл на пол-экрана вниз/вверх
map("n", "<C-j>", "<C-d>zz")
map("n", "<C-k>", "<C-u>zz")
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
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Ресайз терминала
map("t", "<C-Down>", "<cmd>resize -2<CR>")
map("t", "<C-Up>", "<cmd>resize +2<CR>")
map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Normal mode: двигать строку вверх/вниз
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Normal mode: двигать строку влево/вправо (переопределяем Alt+h)
map("n", "<A-h>", "<<", { desc = "Indent left" })
map("n", "<A-l>", ">>", { desc = "Indent right" })

-- Visual mode: двигать выделенный блок
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Visual mode: двигать выделенный блок влево/вправо
map("v", "<A-h>", "<gv", { desc = "Indent left and keep selection" })
map("v", "<A-l>", ">gv", { desc = "Indent right and keep selection" })

-- Insert mode: двигать строку из режима вставки
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })

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

-- DiffView
map("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Open diff view" })
map("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" })
map("n", "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", { desc = "File history" })

map("n", "<leader>gD", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "Toggle deleted lines" })

-- Просмотр всей истории файла
map("n", "<leader>gH", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "Toggle file history" })

-- todo-comments quickfix list
map("n", "<leader>qa", function()
  vim.cmd "TodoQuickFix"
  vim.cmd "copen"
end, { desc = "Open TODO quickfix" })

map("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix" })

-- Ренейм через LSP
map("n", "<leader>rr", function()
  vim.lsp.buf.rename()
end, { desc = "LSP Rename" })
