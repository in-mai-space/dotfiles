local M = {}

function M.apply(config, wezterm)
  local dotfiles = wezterm.home_dir .. "/dotfiles"

  config.launch_menu = {
    {
      label = "Shell (home)",
      args = { "zsh", "-l" },
      cwd = wezterm.home_dir,
    },
    {
      label = "Neovim (dotfiles)",
      args = { "nvim" },
      cwd = dotfiles,
    },
    {
      label = "LazyGit (dotfiles)",
      args = { "lazygit" },
      cwd = dotfiles,
    },
  }
end

return M
