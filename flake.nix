{
  description = "Oh look it's my WHOLE FUCKING SYSTEM";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

	nixpkgs.follows = "nixos-cosmic/nixpkgs-stable"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release
	nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    
  };

  outputs = { self, nixpkgs, nixos-cosmic, ... }@inputs: {
    nixosConfigurations.richardnixxon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
        	nix.settings = {
        		substituters = ["https://cosmic.cachix.org/"];
        		trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];    			
        	};
        }
        nixos-cosmic.nixosModules.default
        ./configuration.nix
      ];
    };
  };
}
