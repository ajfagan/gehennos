{ home-manager, nixpkgs, ...}:
let
in {
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;


  system.stateVersion = "24.11";
}
