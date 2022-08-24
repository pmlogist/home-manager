{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ (import ./packages/apple-fonts.nix) ];
      };
    in {
      homeConfigurations.evgeniya = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./modules/apps/editors/neovim.nix
          ./modules/desktop/fonts.nix
          ./modules/shell/alacritty.nix
          ./modules/shell/direnv.nix
          ./modules/shell/git.nix
          ./modules/shell/kitty.nix
          ./modules/shell/tmux.nix
          ./modules/shell/zsh.nix
          ./hosts/evgeniya.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
