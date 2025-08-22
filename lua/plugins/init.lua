return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "jedi-language-server",
        "black",
        "ruff",
        "isort",
        "debugpy",
      })
    end,
  },

  -- Python LSP
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "black",
        "ruff",
        "debugpy",
      })
    end,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lint").linters_by_ft = {
        python = { "ruff" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup()
      require("dap-python").setup "~/.virtualenvs/debugpy/bin/python" -- or your python path

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Live Server Preview (like VScode ServerPreview)
  {
    "turbio/bracey.vim",
    cmd = { "Bracey", "BraceyStop" },
    build = "npm install --prefix server",
    ft = { "html", "htmldjango" },
  },

  -- venv quick changing
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    config = function()
      require("venv-selector").setup {
        fd_binary_name = "fdfind",
      }
    end,
  },
}
