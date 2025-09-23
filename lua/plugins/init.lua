return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  --
  -- Autorun required
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "black",
        "pyright",
        "ruff",
        "debugpy",
      })
    end,
  },

  -- Telescope configs
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          i = {
            -- insert mode
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-h>"] = actions.move_selection_previous, -- или другое действие
            ["<C-l>"] = actions.move_selection_next, -- или другое действие
          },
          n = {
            -- normal mode внутри telescope
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-h>"] = actions.move_selection_previous,
            ["<C-l>"] = actions.move_selection_next,
          },
        },
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function()
          vim.opt_local.number = true
          vim.opt_local.relativenumber = false
        end,
      })
    end,
  },

  -- Signatures
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      floating_window = true,
      hint_enable = true,
      hint_prefix = "🗿",
      hi_parameter = "LspSignatureActiveParameter",
      handler_opts = {
        border = "rounded",
      },
      doc_lines = 10,
      max_height = 10,
      max_width = 15,
    },
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
            enabled = false,
            jump_labels = true,
          },
        },
      }
    end,
    keys = {
      {
        "f",
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
        "F",
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
        signature = {
          enabled = false, -- !!! полностью отключаем Noice signature help
          auto_open = {
            enabled = false,
          },
        },
        hover = {
          enabled = true, -- оставляем hover
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
          ["cmp.entry.get_documentation"] = false,
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

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          normal = "s",
          normal_cur = "ss",
          visual = "S",
          delete = "ds",
          change = "cs",
        },
        --	Окружить слово = ysiw" --> siw"
        --	Окружить строку = yss" --> ss"
        --	Окружить выделение = visual + S"
        --	Удалить окружение	= ds"
        --	Изменить окружение = cs"'
        surrounds = {
          -- Дополнительные окружения
          ["b"] = { add = { "**", "**" } }, -- Markdown bold
          ["i"] = { add = { "*", "*" } }, -- Markdown italic
          ["c"] = { add = { "/* ", " */" } }, -- CSS comment
        },
      }
    end,
  },
}
