{
  inputs = {
    nixpkgs-unstable.url = "nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
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

        let pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};

        in {
          devShells.default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              # (mkPoetryEnv { projectDir = self; })
              uv
              python312
              zlib
              stdenv.cc.cc.lib # This provides libstdc++
            ];
            LD_LIBRARY_PATH =
              pkgs.lib.makeLibraryPath [ pkgs.zlib pkgs.stdenv.cc.cc.lib ];
          };
        };
    };

}
