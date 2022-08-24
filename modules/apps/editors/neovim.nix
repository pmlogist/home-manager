{ config, lib, options, pkgs, ... }:

let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.editors.neovim;

in {
  options.modules.apps.editors.neovim = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      #extraConfig = ''
      #  lua << EOF
      #    require "main"
      #  EOF
      #'';
      extraPackages = with pkgs;
        with vimPlugins;
        with nodePackages; [
          # Language servers
          gopls
          pyright
          rnix-lsp
          sumneko-lua-language-server
          typescript-language-server
          # Formatters
          black
          nixfmt
          stylua

          # Needed dependencies
          gcc
          nodejs
          wget
          tree-sitter
          (nvim-treesitter.withPlugins (_: tree-sitter.allGrammars))
          (python39.withPackages (pp: with pp; [ pynvim ]))
          ripgrep
          unzip
        ];
    };
  };
}
