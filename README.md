# OpenGFW-nix
> Nix Package and NixOS Module for [OpenGFW](https://gfw.dev/)

`nix run github:eum3l/opengfw-nix`

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    opengfw.url = "github:eum3l/opengfw-nix";
  };

  outputs = {
    opengfw,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.default = let 
      system = "x86_64-linux";
    in nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        opengfw.nixosModules.opengfw
        {
          # Module
          services.opengfw.enable = true;
          
          # Package
          environment.systemPackages = [
            opengfw.packages.${system}.default
          ];
        
          # Cache
          nix.settings = {
            trusted-public-keys = [
              "opengfw.cachix.org-1:vuygVQLuz+GEsqd6RrPOU8ckphW1MVe8MFm22cOo2is="
            ];
            substituters = [
              "https://opengfw.cachix.org" 
            ];
          };
        }
      ];
    };
  };
}
```
