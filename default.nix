{ home-manager, nixpkgs, pkgs, ...}:
let
in {
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  #services.xserver.enable = true;
  #services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.desktopManager.plasma6.enable = true;
  services.getty.autologinUser = "aj";

  system.stateVersion = "24.11";
}
