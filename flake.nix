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
          inherit (pkgs) j j-fhs;
          default = pkgs.j;
        }
      );

      devShells = forAllSystems (system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            packages = [ pkgs.j-fhs ];
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

        # j built in a FHS environment
        j-fhs = final: prev: {
          j-fhs = final.buildFHSEnv {
            name = "jconsole";
            targetPkgs = pkgs: [ pkgs.j ];
            executableName = final.lib.getName final.j;
            runScript = final.lib.getName final.j;
          };
        };

        default = nixpkgs.lib.composeManyExtensions [ j-symlink j-fhs ];
      };
    };
}
