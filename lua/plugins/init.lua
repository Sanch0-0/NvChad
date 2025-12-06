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
        -- LSP servers
        "pyright",
        "ruff",
        "html",
        "cssls",

        -- Formatters
        "black",
        "stylua",
        "prettier",

        -- Debuggers
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
      require("notify").setup {
        background_colour = "#000000",
      }
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
        --  siw"     - Окружить слово двойными кавычками
        --  siw'     - Окружить слово одинарными кавычками
        --  siw(     - Окружить слово круглыми скобками
        --  siw[     - Окружить слово квадратными скобками
        --  siw{     - Окружить слово фигурными скобками
        --  siwt     - Окружить слово HTML тегом (спросит какой)
        --  siwb     - Окружить слово **Markdown жирным**
        --  siwi     - Окружить слово *Markdown курсивом*
        --
        --  ss"      - Окружить всю строку двойными кавычками
        --  ssb      - Окружить всю строку **жирным**
        --
        --  Visual mode: выделите текст и нажмите S" (или Sb, Si и т.д.)
        --
        --  ds"      - Удалить двойные кавычки вокруг слова
        --  ds(      - Удалить круглые скобки
        --  dsb      - Удалить **жирное** Markdown оформление
        --
        --  cs"'     - Изменить двойные кавычки на одинарные
        --  cs(b     - Изменить круглые скобки на **жирный** Markdown
        --  csw"     - Изменить окружение слова на двойные кавычки
        surrounds = {
          -- Дополнительные окружения
          ["b"] = { add = { "**", "**" } }, -- Markdown bold
          ["i"] = { add = { "*", "*" } }, -- Markdown italic
          ["c"] = { add = { "/* ", " */" } }, -- CSS comment
        },
      }
    end,
  },

  -- Git merge conflict
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    config = function()
      local actions = require "diffview.actions"

      require("diffview").setup {
        enhanced_diff_hl = true,
        -- merge_tool scope — эти бинды активны в merge view (правильное место)
        key_bindings = {
          merge_tool = {
            -- hunk-level (один конфликт)
            { { "n", "x" }, "<leader>co", actions.conflict_choose "ours", { desc = "Choose OURS (local) - hunk" } },
            {
              { "n", "x" },
              "<leader>ct",
              actions.conflict_choose "theirs",
              { desc = "Choose THEIRS (remote) - hunk" },
            },
            { { "n", "x" }, "<leader>cb", actions.conflict_choose "base", { desc = "Choose BASE - hunk" } },
            {
              { "n", "x" },
              "<leader>ca",
              actions.conflict_choose "all",
              { desc = "Choose ALL (keep all) - hunk" },
            },

            -- file-level (всё файл)
            { "n", "<leader>cO", actions.conflict_choose_all "ours", { desc = "Choose OURS - whole file" } },
            { "n", "<leader>cT", actions.conflict_choose_all "theirs", { desc = "Choose THEIRS - whole file" } },
            { "n", "<leader>cB", actions.conflict_choose_all "base", { desc = "Choose BASE - whole file" } },
            { "n", "<leader>cA", actions.conflict_choose_all "all", { desc = "Choose ALL - whole file" } },

            -- навигация между конфликтами
            { "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
            { "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
          },
        },
      }
    end,
  },
}
