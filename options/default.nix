{
  path,
  module,
  nixosOptionsDoc,
  pkgs,
  writers,
}:
let
  src =
    (nixosOptionsDoc {
      inherit
        (import (path + "/nixos/lib/eval-config.nix") {
          specialArgs.pkgs = pkgs;
          system = null;
          modules = [ module ];
        })
        options
        ;
    }).optionsJSON;
in
writers.writeNuBin "update-options.nu" ''
  open "${src}/share/doc/nixos/options.json" 
    | rotate
    | rename option name
    | where name starts-with "services.opengfw"
    | each {
      | i |
  $'
  ## ($i.name)
  > ($i.option.description | str trim)
  + **Type:** ($i.option.type)(try {$"\n### Default\n```nix\n($i.option.default.text)\n```"})(try {$"\n### Example \n```nix\n($i.option.example.text)\n```"})
  ---
  '
    }
    | prepend "# Options"
    | str join " "
    | save -rf OPTIONS.md
''
