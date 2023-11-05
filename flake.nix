{
        description = "femblake";

        inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = { 
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        };
#  hyprland.url = "github:hyprwm/hyprland";
        
};


        outputs = { self, nixpkgs, home-manager,   ... }@inputs: 
        let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
        inherit system;
        config = {
        allowunfree = true;
        };
        };
in 
{
        nixosConfigurations = {

rider = nixpkgs.lib.nixosSystem { 
        specialArgs = { inherit inputs system; };
        


        modules = [
	./configuration.nix
  home-manager.nixosModules.home-manager

{
	    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.theNameOfTheUser = import ./home.nix;
} 

     #    hyprland.nixosModules.default
      #    { programs.hyprland.enable = true; }
          home-manager.nixosModules.home-manager
           {
            # ...
            home-manager.extraSpecialArgs = { inherit inputs; };
           }
 #       ./nixos/configuration.nix
        ];
        };      
        };
        };
        }
