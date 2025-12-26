local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "ruff" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

-- Run black before save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})

return options
