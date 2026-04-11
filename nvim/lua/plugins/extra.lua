return {
  {
    "saghen/blink.cmp",
    opts = {
      enabled = function()
        return vim.g.blink_cmp_enabled ~= false
      end,
    },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        enabled = function()
          return vim.g.blink_cmp_enabled ~= false
        end,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = {"G", "Git", "Gstatus", "Gblame"},
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup({
        window = { width = 0.8, options = { number = false, relativenumber = false } },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = {"TroubleToggle", "Trouble"},
    config = function()
      require("trouble").setup({})
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gcc", "gc" },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
}
