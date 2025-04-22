return {
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_italic = false
      vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = true
  },
  {
      -- use vim fugitive instead
    "lewis6991/gitsigns.nvim",
    config = true,
    enabled = false
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  {
    "nvim-tree/nvim-tree.lua",
    -- it doesn't want to be loaded lazily
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup()

        -- somehow we ought to be able to map nvim-tree.api.toggle
        -- local ntapi = require("nvim-tree.api")
        vim.api.nvim_set_keymap("n", "<C-o>", ":NvimTreeToggle<CR>", {noremap=true})
    end
  },
  {
    "tpope/vim-fugitive",
    init = function()
       -- nothing to do
    end
  },
  {
    "Yggdroot/indentLine",
    init = function()
        vim.g.indentLine_char = '⦙'
    end
  },
  {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline"
      },
      event = "InsertEnter",
      -- originally taken from https://github.com/scalameta/nvim-metals/discussions/39
      opts = function()
        local cmp = require("cmp")
        local conf = {
            sources = {
                { name = "nvim_lsp" }
            }
        }
        return conf
      end
  },
  {
      "folke/trouble.nvim",
      config = true,
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },
    {
        "Olical/conjure",
        ft = {"clojure", "fennel"},
        lazy = true,
        init = function()
            -- vim.g["conjure#debug"] = true
        end,
        dependencies = { "PaterJason/cmp-conjure" },
    },
    {
        "PaterJason/cmp-conjure",
        lazy = true,
        config = function()
          local cmp = require("cmp")
          local config = cmp.get_config()
          table.insert(config.sources, { name = "conjure" })
          return cmp.setup(config)
        end,
    },
    -- structural editing
    'guns/vim-sexp',
    'tpope/vim-sexp-mappings-for-regular-people',
    'tpope/vim-repeat',
    'tpope/vim-surround',
}
