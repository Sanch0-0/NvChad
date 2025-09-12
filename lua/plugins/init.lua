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
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup()
      require("dap-python").setup "~/.virtualenvs/debugpy/bin/python"

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
    end,
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

  -- Funcion signature helper
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup {
        bind = true,
        hint_enable = false,
        floating_window = true,
        floating_window_above_cur_line = true,
        handler_opts = { border = "rounded" },
        max_height = 4,
        max_width = 80,
        zindex = 50,
        transparency = 10,
        doc_lines = 0,
      }
    end,
  },

  -- Fast text jumping (Flash)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#f8f8f2", bg = "#717593", bold = false })
      vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#50fa7b", bg = "#717593", bold = true })
      vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#21222c", bg = "#f28ba8", bold = true })

      -- Затем настраиваем flash
      require("flash").setup {
        search = {
          mode = "exact",
          incremental = false,
        },
        highlight = {
          backdrop = true,
          groups = {
            match = "FlashMatch",
            current = "FlashCurrent",
            label = "FlashLabel",
          },
        },
        modes = {
          char = {
            enabled = true,
            jump_labels = false,
          },
        },
      }
    end,
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump {
            search = {
              mode = "exact",
              incremental = false,
              wrap = true,
              multi_window = true,
            },
          }
        end,
        desc = "Flash search",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },

  -- Better messages, popup, etc...
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
    end,
  },

  -- Better Quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf", -- Загружать только для quickfix
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "junegunn/fzf", -- Опционально, для лучшей производительности
    },
  },
}
