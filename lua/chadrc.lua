local M = {}

M.base46 = {
  theme = "catppuccin",
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "                                                                       ",
    "        ███████████           █████      ██                      ",
    "       ███████████             █████                              ",
    "       ████████████████ ███████████ ███   ███████      ",
    "      ████████████████ ████████████ █████ ██████████████    ",
    "     █████████████████████████████ █████ █████ ████ █████    ",
    "   ██████████████████████████████████ █████ █████ ████ █████   ",
    "  ██████  ███ █████████████████ ████ █████ █████ ████ ██████  ",
    "  ██████   ██  ███████████████   ██ █████████████████  ",
    "",
  },

  --   " ███████████████████████████ ",
  --   " ███████▀▀▀░░░░░░░▀▀▀███████ ",
  --   " ████▀░░░░░░░░░░░░░░░░░▀████ ",
  --   " ███│░░░░░░░░░░░░░░░░░░░│███ ",
  --   " ██▌│░░░░░░░░░░░░░░░░░░░│▐██ ",
  --   " ██░└┐░░░░░░░░░░░░░░░░░┌┘░██ ",
  --   " ██░░└┐░░░░░░░░░░░░░░░┌┘░░██ ",
  --   " ██░░┌┘▄▄▄▄▄░░░░░▄▄▄▄▄└┐░░██ ",
  --   " ██▌░│██████▌░░░▐██████│░▐██ ",
  --   " ███░│▐███▀▀░░▄░░▀▀███▌│░███ ",
  --   " ██▀─┘░░░░░░░▐█▌░░░░░░░└─▀██ ",
  --   " ██▄░░░▄▄▄▓░░▀█▀░░▓▄▄▄░░░▄██ ",
  --   " ████▄─┘██▌░░░░░░░▐██└─▄████ ",
  --   " █████░░▐█─┬┬┬┬┬┬┬─█▌░░█████ ",
  --   " ████▌░░░▀┬┼┼┼┼┼┼┼┬▀░░░▐████ ",
  --   " █████▄░░░└┴┴┴┴┴┴┴┘░░░▄█████ ",
  --   " ███████▄░░░░░░░░░░░▄███████ ",
  --   " ██████████▄▄▄▄▄▄▄██████████ ",
  --
  --
  -- "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
  -- "████╗  ██║██║   ██║██║████╗ ████║",
  -- "██╔██╗ ██║██║   ██║██║██╔████╔██║",
  -- "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  -- "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  -- "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
  --
  -- "                                                                       ",
  -- "        ███████████           █████      ██                      ",
  -- "       ███████████             █████                              ",
  -- "       ████████████████ ███████████ ███   ███████      ",
  -- "      ████████████████ ████████████ █████ ██████████████    ",
  -- "     █████████████████████████████ █████ █████ ████ █████    ",
  -- "   ██████████████████████████████████ █████ █████ ████ █████   ",
  -- "  ██████  ███ █████████████████ ████ █████ █████ ████ ██████  ",
  -- "  ██████   ██  ███████████████   ██ █████████████████  ",
  --
  --
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠟⠛⠛⠛⠛⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠙⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢀⣀⣀⣄⣤⣤⣦⣶⣶⣤⣀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣰⠿⡏⠁⠕⢚⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠰⠠⠀⠀⠀⠀⠲⠚⠉⠓⢿⣿⣧⣄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠔⠀⠂⠀⠀⠀⠀⠀⠀⠐⠠⠈⢻⣿⣷⡀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡋⢀⠀⠀⠀⢰⣾⠀⠀⠀⠀⠀⠀⠔⠐⠛⣿⠆⠀⢀⠔⢀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠠⠀⢠⣺⣿⡀⠀⠀⠀⠲⣷⡊⠨⢲⡩⠇⠀⣈⠁⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢳⠀⢀⠸⠭⠅⠲⠀⠀⠐⠀⢄⠉⠊⠙⠀⠀⠀⢸⣁⡁⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡜⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⠀⠀⠀⠀⠀⠀⠈⣡⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⠁⠀⠐⠀⠠⠠⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣾⢟⣽⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣟⣿⣿⣿⣿⣿⣿⣇⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣄⣀⣀⣀⣀⠀⠀⢛⣏⣽⣿⣿⣿⣾⣿⣿⣿⣿⣾⣶⣯⣍⡛⡛⠿⢿⣿⣿⣿⣿⣿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢹⡕⠀⠀⠸⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣽⣿⠟⢫⠘⢑⠴⣢⣄⡉⠛⠻⢿",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣶⡀⠀⢺⣿⠟⣹⣿⣿⣿⣿⣿⣿⣿⣷⣇⠀⠀⠀⠀⠘⡵⠫⢴⡗⠄",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣻⣕⢾⣿⣿⣦⠀⠘⠫⠐⣿⣿⣿⣾⣿⣿⣿⣿⣿⢗⣅⠀⠀⠀⠀⠀⠐⢼⠟⠇",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣶⢛⡟⡍⢸⣟⡼⡘⠀⠀⠀⠈⢹⣿⠃⠉⠈⠁⠙⢑⣉⣁⣀⣤⣤⣤⣤⣶⣶⠔⠀⠀",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣫⣞⠵⡕⣮⣬⣴⡾⡿⢶⣷⠀⠀⠀⡆⠈⣁⡠⠔⢶⡞⢫⢻⢿⠙⠛⠋⣻⢿⡿⣿⠃⠀⡠⣴",
  -- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢟⣭⣷⣶⣦⢠⡿⣠⣿⣶⣧⣴⣐⣠⡬⠉⠃⠀⡜⡠⠾⠙⠃⠀⠀⠀⠠⢄⢆⡐⠤⢑⠟⠟⠏⠀⠀⣼⣿⣿",
  -- "⣿⣿⣿⡿⢟⣻⣭⣶⣾⣿⣿⣿⣿⣿⣟⣁⣽⡏⢝⢿⣯⢷⣝⠋⠀⠀⠉⠛⡗⠁⠀⠀⠀⢀⡠⣴⣾⡻⠞⠾⣨⡀⡀⠀⠀⠀⠈⢿⣿⣻",
  -- "⣿⠟⣫⣾⣿⣿⣿⣿⣿⡿⢻⣿⣿⣷⣿⣿⣼⣿⡡⣘⠚⠏⠀⠀⠀⠀⠀⠀⠈⠄⠀⡄⢠⣀⡋⣷⣿⣿⣖⡁⢔⡅⠂⠀⠀⠀⠀⠀⠋⠞",
  -- "⣡⣾⣿⣿⣿⣿⣿⡿⠋⣴⣿⣿⣿⣿⣿⣻⡻⠿⠑⡽⢿⠖⡝⠁⠀⠀⠀⠀⠀⠂⢀⠤⣘⣙⣽⣻⡿⣈⡆⠭⠀⠈⠨⠡⠀⠀⠀⠀⠀⠀",
  -- "⣿⣿⣿⣿⣿⣿⡿⠓⢇⢾⣿⣿⣿⢛⣿⣷⣿⣿⢻⡧⣝⠏⠀⠀⠀⠀⠀⣀⢀⡂⣲⢢⢨⣭⣼⡣⡉⠁⠀⠁⠄⠀⠀⠈⠀⠀⠀⠀⠀⠀",
  -- "⣿⣿⣿⣿⣿⣿⡇⠀⢠⡿⢿⢿⣇⡿⠛⢻⢻⠐⠘⠈⠀⢀⠀⠀⠀⠀⢠⠷⢋⡛⣆⣭⡪⠦⠍⠃⠀⠀⠀⠀⠊⠀⠀⠀⠀⠀⢑⣶⣆⣄",
}

vim.cmd "hi St_relativepath guifg=#dbe0ee guibg=#2e2e3e"

M.ui = {
  transparency = true,
  -- Add hl_override to force transparent backgrounds
  hl_override = {
    Normal = { bg = "none" },
    NormalFloat = { bg = "none" },
    NormalNC = { bg = "none" },
    Pmenu = { bg = "none" },
    FloatBorder = { bg = "none" },
    NotifyBackground = { bg = "none" },
  },
  statusline = {
    theme = "default",
    separator_style = "default",
    order = {
      "macro",
      "mode",
      "relativepath",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
      "cursor",
    },

    modules = {
      macro = function()
        local recording_reg = vim.fn.reg_recording()
        if recording_reg ~= "" then
          return "%#StText# ● REC @" .. recording_reg .. " "
        end
        return ""
      end,

      relativepath = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" then
          return ""
        end

        local relative_path = vim.fn.expand "%:.:h"
        if relative_path == "" then
          relative_path = "."
        end

        return "%#St_relativepath#" .. relative_path .. " /"
      end,
    },
  },
}

-- Additional force transparency commands
vim.cmd [[
  augroup TransparentNvChad
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=none ctermbg=none
    autocmd ColorScheme * highlight NormalFloat guibg=none ctermbg=none
    autocmd ColorScheme * highlight TelescopeNormal guibg=none ctermbg=none
    autocmd ColorScheme * highlight NvimTreeNormal guibg=none ctermbg=none
    autocmd ColorScheme * highlight Pmenu guibg=none ctermbg=none
  augroup END
]]

-- Apply immediately
vim.defer_fn(function()
  vim.cmd "highlight Normal guibg=none"
  vim.cmd "highlight NormalFloat guibg=none"
end, 100)

-- Изменяем цвет ASCII текста
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.api.nvim_set_hl(0, "NvDashAscii", { fg = "#888BA6" })
    vim.api.nvim_set_hl(0, "NvDashButtons", { fg = "#8be9fd" })
  end,
})

-- Быстрый запуск .py, .js, .sh файлов
-- Robust Run command with better error handling
vim.api.nvim_create_user_command("Run", function()
  local ft = vim.bo.filetype
  local filename = vim.fn.expand "%"
  local cmd

  -- Check if file exists and is not empty
  if filename == "" or vim.fn.filereadable(filename) == 0 then
    print "Error: No file or file not readable"
    return
  end

  if ft == "python" then
    cmd = "belowright vsp | terminal python3 '" .. filename .. "'"
  elseif ft == "javascript" or ft == "javascriptreact" then
    cmd = "belowright vsp | terminal node '" .. filename .. "'"
  elseif ft == "sh" or ft == "bash" then
    -- Check if file is executable, if not make it executable
    if vim.fn.executable(filename) == 0 then
      cmd = "belowright vsp | terminal chmod +x '" .. filename .. "' && '" .. filename .. "'"
    else
      cmd = "belowright vsp | terminal '" .. filename .. "'"
    end
  elseif ft == "lua" then
    cmd = "belowright vsp | terminal nvim -l '" .. filename .. "'"
  else
    print("Unsupported filetype: " .. ft .. ". Supported: python, js, sh, lua")
    return
  end

  vim.cmd(cmd)
end, {})

-- Переключение диагностики
vim.keymap.set("n", "<leader>df", function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.diagnostic.is_disabled(bufnr) then
    vim.diagnostic.enable(bufnr)
    print "Diagnostics enabled"
  else
    vim.diagnostic.disable(bufnr)
    print "Diagnostics disabled"
  end
end, { desc = "Toggle LSP diagnostics" })

return M
