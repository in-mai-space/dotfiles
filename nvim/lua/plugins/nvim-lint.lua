return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        -- python = {"flake8"},
        javascript = {"eslint_d"},
        typescript = {"eslint_d"},
        go = {"revive"},
        sh = {"shellcheck"},
        lua = {"luacheck"},
        markdown = {"markdownlint"},
      }

      vim.api.nvim_create_autocmd({"BufWritePost", "TextChanged"}, {
        pattern = {"*.py", "*.js", "*.ts", "*.go", "*.sh", "*.lua", "*.md"},
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
