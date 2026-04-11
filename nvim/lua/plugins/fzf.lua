return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        winopts = { height = 0.85, width = 0.8, border = "rounded" },
        fzf_opts = { ["--layout"] = "reverse", ["--info"] = "inline" },
      })
    end,
  },
}
