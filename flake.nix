{
  description = "My fiest flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:bruhng/nix-vim";
  };
  
  outputs = inputs:
    let 
      lib = inputs.nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = import ./lib/overlays.nix {inherit inputs system; };
      };
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
	inherit system;
	modules = [./configuration.nix];
      };
    };
    homeConfigurations = {
      bruhng = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [ ./home.nix ];
        inherit pkgs;
      };
    };
    packages.${system} = {
      inherit (pkgs) bazecor;
    };
  };
}
