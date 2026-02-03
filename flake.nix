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
      packages = forAllSystems (system:
        let
          pkgs = mkPkgs system;
        in
        {
          inherit (pkgs) j;
          default = pkgs.j;
          j-fhs = pkgs.j.wrapFHS pkgs.j;

          j-with-addons = pkgs.j.withAddons (ps: with ps;
            [
              math.misc
              graphics.plot
            ]);
          j-fhs-with-addons = pkgs.j.wrapFHS (pkgs.j.withAddons (ps: with ps;
            [
              math.misc
              graphics.plot
            ]));
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

        # j with addon helpers attached
        j-with-addons = final: prev:
          let
            pkgs = mkPkgs final.stdenv.hostPlatform.system;
            _jAddons = pkgs.lib.packagesFromDirectoryRecursive {
              inherit (pkgs) callPackage newScope;
              directory = ./src;
            };
            buildJEnv = pkgs.callPackage ./j-build-env.nix { };
          in
          {
            j = prev.j // {
              inherit buildJEnv;
              jAddons = _jAddons.jAddons;
              wrapFHS = j: pkgs.buildFHSEnv {
                name = "j";
                targetPkgs = _: [ j ];
                runScript = pkgs.lib.getExe j;
              };
              withAddons = f: buildJEnv.override { addons = f _jAddons.jAddons; };
            };
          };

        default = nixpkgs.lib.composeManyExtensions [ j-symlink j-with-addons ];
      };
    };
}
