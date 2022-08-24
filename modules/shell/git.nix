{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.shell.git;
  inherit (lib) mkIf mkOption types;
in
{
  options.modules.shell.git = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.lazygit ];
    programs.git = {
      enable = true;
      userName = "pmlogist";
      userEmail = "42704376+pmlogist@users.noreply.github.com";
      ignores = [ "/.vscode" ".direnv" ];
      extraConfig = {
        color.ui = true;
        pull.rebase = true;
        url."git@github.com:".insteadOf = [ "https://github.com/" ];
        init = { defaultBranch = "main"; };
      };
    };

  };
}
