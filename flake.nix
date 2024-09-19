{
  description = "Configuration for AJ's home desktop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    sops-nix.url = "github:Mic92/sops-nix";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    supportedSystems = [ system ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

    users = [ "aj" "guest" ];
    forEachUser = val: builtins.listToAttrs ( builtins.map( user: { name = user; value = val user; }) users );
    buildUserHome = user: 
    let
      inherit system;
      username = user;
      stateVersion = "24.11";

      pkgs = import nixpkgs {
	inherit system;

	config.allowUnfree = true;
      };

      homeDirPrefix = "/home";
      homeDirectory = "${homeDirPrefix}/${username}";
    in
      (import ./home/${user}/home.nix {
	inherit homeDirectory pkgs stateVersion system username;
      });
  in
  {
    
    nixosConfigurations = {
      gehennos = nixpkgs.lib.nixosSystem {
	inherit system;
	specialArgs = {
	  inherit system;
	  hostName = "gehennos";
	  users = [ "aj" "guest" ]; # Do not include root user
	  rootUser = "root";
	} // inputs;
	modules = [
	  ./.
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users = forEachUser buildUserHome;
	  }
	  ({users.users = forEachUser (user: { isNormalUser = true; extraGroups = [ user ]; initialPassword = "temp123"; } );})
	];
      };
    };

  #formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
  };
}
