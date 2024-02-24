{
  description = "OpenGFW is a flexible, easy-to-use, open source implementation of GFW on Linux.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=23.11";
    flake-utils.url = "github:numtide/flake-utils";
    opengfw-src = {
      url = "github:apernet/opengfw";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    opengfw-src,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnsupportedSystem = true;
        };
      in {
        formatter = pkgs.alejandra;

        packages = rec {
          opengfw = pkgs.callPackage ./package.nix {src = opengfw-src;};
          default = opengfw;
        };

        devShells.default = pkgs.mkShell {
          OPENGFW_LOG_LEVEL = "debug";
          nativeBuildInputs = with pkgs; [go];
          inputsFrom = [
            self.packages.${system}.opengfw
          ];
        };
      }
    )
    // {
      nixosModules.opengfw = import ./module.nix self.packages;

      hydraJobs = {
        inherit (self) packages;
      };
    };
}
