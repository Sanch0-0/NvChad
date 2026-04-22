return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Autorun required
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- LSP servers
        "pyright",
        "html",
        "cssls",
        "ruff",

        -- Formatters
        "stylua",
        "prettier",
        "black",

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
        layout_config = {
          horizontal = {
            preview_width = 0.5,
          },
          preview_cutoff = 1,
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-h>"] = actions.move_selection_previous,
            ["<C-l>"] = actions.move_selection_next,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-h>"] = actions.move_selection_previous,
            ["<C-l>"] = actions.move_selection_next,
          },
        },
      })

      -- Автокоманда для нумерации строк в preview – она безопасна
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
      floating_window_above_cur_line = true,
      -- hint
      hint_enable = false,
      hint_prefix = "🗿",
      hint_scheme = "String",
      hi_parameter = "LspSignatureActiveParameter",
      handler_opts = {
        border = "rounded",
      },
      -- doc lines
      doc_lines = 10,
      max_height = 3,
      max_width = 60,
      wrap = true,
      -- big signatures
      always_trigger = false,
      toggle_key = "<M-s>", -- Alt+s
      scroll_bar = false,
      timer_interval = 200,
      zindex = 10,
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
    lazy = false,
    config = function()
      require("conform").setup(require "configs.conform")
    end,
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
      vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#D9E0EE", bg = "#21222c", bold = false })
      vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#C7A0DC", bg = "#21222c", bold = true })
      vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#161621", bg = "#B4BEFE", bold = true })

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
        progress = {
          enabled = false,
        },
        signature = {
          enabled = false,
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

  -- TODO
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead",
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "#FFC0B9",
          alt = { "FIXME", "FIXIT", "ISSUE" },
        },
        BUG = {
          icon = " ",
          color = "#F38BA8",
        },
        NOTE = {
          icon = " ",
          color = "#ABE9B3",
          alt = { "INFO" },
        },
        TEST = {
          icon = " ",
          color = "#89DCEB",
        },
      },
    },
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        background_colour = "#000000",
        render = "compact",
        stages = "fade_in_slide_out",
      }
      vim.notify = require "notify"
    end,
  },

  -- Cut without copying
  {
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup {
        cut_key = "x",
      }
    end,
  },

  -- -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      local surround = require "nvim-surround"

      surround.setup {
        surrounds = {
          ["b"] = { add = { "**", "**" } }, -- Markdown bold
          ["i"] = { add = { "*", "*" } }, -- Markdown italic
          ["c"] = { add = { "/* ", " */" } }, -- CSS comment
        },
      }
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
      vim.keymap.set("n", "s", "<Plug>(surround)")
      vim.keymap.set("n", "ss", "<Plug>(surround_line)")
      vim.keymap.set("n", "ds", "<Plug>(delete_surround)")
      vim.keymap.set("n", "cs", "<Plug>(change_surround)")
      vim.keymap.set("v", "S", "<Plug>(visual_surround)")
    end,
  },

  -- Default NvChad notifications

  {
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        ignore_done_already = true,
        ignore_empty_message = true,
      },
    },
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

  -- Multi line editint
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-;>",
        ["Find Next"] = "<C-;>",
        ["Select All"] = "<C-a>",
        ["Add Cursor Down"] = "<C-j>",
        ["Add Cursor Up"] = "<C-k>",
        ["Visual All"] = "<C-;>",
      }
      vim.g.VM_mouse_mappings = 1
    end,
  },

  -- Smooth scroll
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      local neoscroll = require "neoscroll"
      neoscroll.setup {
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        duration_multiplier = 1.0,
        easing = "sine",
        performance_mode = false,
      }

      local keymap = {
        ["<C-u>"] = function()
          neoscroll.ctrl_u { duration = 150 }
        end,
        ["<C-d>"] = function()
          neoscroll.ctrl_d { duration = 150 }
        end,
        ["<C-b>"] = function()
          neoscroll.ctrl_b { duration = 150 }
        end,
        ["<C-f>"] = function()
          neoscroll.ctrl_f { duration = 150 }
        end,
        ["<C-y>"] = function()
          neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
        end,
        ["<C-e>"] = function()
          neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
        end,
        ["zt"] = function()
          neoscroll.zt { half_win_duration = 150 }
        end,
        ["zz"] = function()
          neoscroll.zz { half_win_duration = 150 }
        end,
        ["zb"] = function()
          neoscroll.zb { half_win_duration = 150 }
        end,
      }

      for key, func in pairs(keymap) do
        vim.keymap.set({ "n", "v", "x" }, key, func, { desc = "neoscroll " .. key })
      end
    end,
  },
}
