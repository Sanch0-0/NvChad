require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

