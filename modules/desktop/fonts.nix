{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.desktop.fonts;

in {
  options.modules.desktop.fonts = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      jetbrains-mono
      apple-fonts
      (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
    ];
  };
}
