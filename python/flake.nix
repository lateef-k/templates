{
  inputs = {
    nixpkgs.url = "nixpkgs";
    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      flake = {
        # Put your original flake attributes here.
      };
      systems = [
        # systems for which you want to build the `perSystem` attributes
        "x86_64-linux"
        "aarch64-linux"
        # ...
      ];
      perSystem = arg@{ system, ... }:

        let pkgs = inputs.nixpkgs.legacyPackages.${system};

        in {
          devShells.default = pkgs.mkShellNoCC {
            packages = with pkgs;
              [
                # (mkPoetryEnv { projectDir = self; })
                poetry
              ];
          };
        };
    };

}
