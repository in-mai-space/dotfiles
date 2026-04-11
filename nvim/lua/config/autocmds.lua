vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py", "*.ts", "*.js", "*.go", "*.lua", "*.sh", "*.md", "*.tex" },
  callback = function()
    local ft = vim.bo.filetype
    if ft == "tex" and vim.fn.executable("latexindent") == 1 then
      vim.cmd("silent! %!latexindent -")
    else
      vim.lsp.buf.format({ async = false })
    end
  end,
})
