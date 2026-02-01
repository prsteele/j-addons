{
  description = "J addons";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, systems }:
    let
      forAllSystems = nixpkgs.lib.genAttrs (import systems);
      mkPkgs = system: import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
    in
    {
      legacyPackages = forAllSystems (system:
        let
          pkgs = mkPkgs system;

          jAddons = pkgs.lib.packagesFromDirectoryRecursive {
            inherit (pkgs) callPackage newScope;
            directory = ./src;
          };
          buildJEnv = pkgs.callPackage ./j-build-env.nix { };
        in
        {
          inherit (jAddons) jAddons;
          inherit buildJEnv;
          jWithAddons = f: buildJEnv.override { addons = f jAddons.jAddons; };
        }
      );

      packages = forAllSystems (system:
        let
          pkgs = mkPkgs system;

          wrapFHS = j: pkgs.buildFHSEnv {
            name = "j";
            targetPkgs = _: [ j ];
            runScript = pkgs.lib.getExe j;
          };

        in
        rec {
          inherit (pkgs) j;
          default = pkgs.j;
          j-fhs = wrapFHS j;

          j-with-addons = self.legacyPackages.${system}.jWithAddons (ps: with ps;
            [
              math.misc
              graphics.plot
            ]);
          j-fhs-with-addons = wrapFHS j-with-addons;
        }
      );

      devShells = forAllSystems (system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            packages = [ self.packages.${system}.j-fhs-with-addons ];
          };
        });

      overlays = rec {
        # j with `j` as a symlink to `jconsole`
        j-symlink = final: prev: {
          j = prev.j.overrideAttrs
            (old: {
              postInstall = ''
                ln -s ./jconsole $out/bin/j
              '';
              meta = old.meta // { mainProgram = "j"; };
            });
        };

        default = nixpkgs.lib.composeManyExtensions [ j-symlink ];
      };
    };
}
