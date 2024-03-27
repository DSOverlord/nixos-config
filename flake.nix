{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, stylix, agenix, ... }@inputs: {
    nixosConfigurations =
      let
        system = "x86_64-linux";
      in
      with nixpkgs.lib;
      let
        machines = builtins.attrNames (builtins.readDir ./machines);
        mkHost = name:
          nixosSystem {
            inherit system;
            modules = [
              {
                imports = [
                  ./system
                  ./machines/${name}
                  ./machines/${name}/disks.nix
                ];

                networking.hostName = "${name}";
              }
            ];
            specialArgs = { inherit inputs; };
          };
      in
      genAttrs machines mkHost;
  };
}
