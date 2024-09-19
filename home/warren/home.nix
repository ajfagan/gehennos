{ homeDirectory
, pkgs
, stateVersion
, system
, username 
}:
let
  #packages = import ./packages.nix { inherit pkgs; };
in {
  home = {
    inherit homeDirectory stateVersion username;

    shellAliases = {
      reload-home-manager-config = "home-manager switch --flake ${builtins.toString ./.}";
    };
  };

  nixpkgs = {
    config = {
      inherit system;
      allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  #programs = import ./programs.nix { inherit pkgs homeDirectory; };
  wayland.windowManager.hyprland.enable = false;
  wayland.windowManager.hyprland.settings = {};
}
