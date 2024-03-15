rec {
  description = "OpenGFW is a flexible, easy-to-use, open source implementation of GFW on Linux.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=23.11";
    flake-utils.url = "github:numtide/flake-utils";
    src = {
      type = "github";
      owner = "apernet";
      repo = "OpenGFW";
      ref = "v0.2.3";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    src,
  }: let
    platforms = ["aarch64-linux" "x86_64-linux"];
  in
    flake-utils.lib.eachSystem platforms (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnsupportedSystem = true;
        };
      in {
        formatter = pkgs.alejandra;

        packages = rec {
          default = opengfw;
          opengfw = pkgs.callPackage ./package.nix {
            inherit platforms src;
            version = pkgs.lib.removePrefix "v" inputs.src.ref;
          };
        };

        devShells.default = pkgs.mkShell {
          OPENGFW_LOG_LEVEL = "debug";
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
