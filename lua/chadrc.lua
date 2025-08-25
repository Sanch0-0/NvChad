local M = {}

M.base46 = {
  theme = "chadracula",
}

M.nvdash = {
  load_on_startup = true,
}

vim.cmd "hi St_relativepath guifg=#bbb9b7 guibg=#41434f"

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "relativepath", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },

    modules = {
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

return M
