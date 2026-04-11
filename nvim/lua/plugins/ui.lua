return {
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, { function() return "😄" end })
    end,
  },
  -- gitsigns
  { "lewis6991/gitsigns.nvim", event = "VeryLazy" },
  -- autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  -- comment
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  -- leap
  { "ggandor/leap.nvim", keys = { "s", "S" }, config = function() require("leap").add_default_mappings() end },
}
