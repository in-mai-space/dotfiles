return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      -- use latexmk
      vim.g.vimtex_compiler_method = "latexmk"

      vim.g.vimtex_compiler_latexmk = {
        continuous = true,
      }

      -- PDF viewer: Skim
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "open"
      vim.g.vimtex_view_general_options = "-a Skim"

      -- open PDF automatically
      vim.g.vimtex_view_automatic_open = 1

      -- disable vimtex quickfix auto popup
      vim.g.vimtex_quickfix_mode = 0
    end,
  },
}
