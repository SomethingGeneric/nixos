{
  inputs = {
    nixpkgs.follows = "nixos-cosmic/nixpkgs"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = { self, nixpkgs, nixos-cosmic }: {
    nixosConfigurations = {
      richardnixxon = nixpkgs.lib.nixosSystem {
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" "https://cache.nixos.org" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          ./configuration.nix
        ];
      };
    };
  };
}
