rec {
  description = "OpenGFW is a flexible, easy-to-use, open source implementation of GFW on Linux.";

  nixConfig = {
    extra-substituters = [ "https://opengfw.cachix.org" ];
    extra-trusted-public-keys = [ "opengfw.cachix.org-1:vuygVQLuz+GEsqd6RrPOU8ckphW1MVe8MFm22cOo2is=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    uspkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    options-nix.url = "github:eum3l/options.nix";
    src = {
      type = "github";
      owner = "apernet";
      repo = "OpenGFW";
      ref = "v0.4.0";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      options-nix,
      src,
      uspkgs,
    }:
    let
      platforms = [
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    flake-utils.lib.eachSystem platforms (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnsupportedSystem = true;
        };
        unstable = import uspkgs { inherit system; };
      in
      rec {
        formatter = unstable.nixfmt-rfc-style;

        packages = rec {
          default = opengfw;
          opengfw = pkgs.callPackage ./package.nix {
            inherit platforms src;
            version = pkgs.lib.removePrefix "v" inputs.src.ref;
          };

          options = options-nix.lib.mkOptionScript {
            inherit system;
            module = self.nixosModules.default;
            modulePrefix = "services.opengfw";
          };
        };

        checks.default = pkgs.callPackage ./check { opengfw = self.nixosModules.default; };

        devShells.default = pkgs.mkShellNoCC {
          OPENGFW_LOG_LEVEL = "debug";
          CGO_ENABLED = 0;
          OPENGFW_TMP = "/tmp/opengfw";

          inputsFrom = [ packages.opengfw ];

          shellHook = ''
            rm -r $OPENGFW_TMP
            cp -r --no-preserve=mode,ownership ${src} $OPENGFW_TMP
            cd $OPENGFW_TMP
          '';
        };
      }
    )
    // {
      nixosModules.default = import ./module.nix self.packages;

      hydraJobs = {
        inherit (self) packages;
      };
    };
}
