{ config, pkgs, ... }:

{
  #targets.genericLinux.enable = true;

  modules = {
    apps = { editors = { neovim.enable = true; }; };
    desktop = { fonts.enable = true; };
    shell = {
      alacritty.enable = true;
      direnv.enable = true;
      git.enable = true;
      kitty.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
  };
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pmlogist";
  home.homeDirectory = "/home/pmlogist";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ stow wl-clipboard jq ];
}
