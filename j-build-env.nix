{ lib
, pkgs
, symlinkJoin
, j ? pkgs.j
, addons ? [ ]
, extraLibs ? [ ]
}:
let
  addonDependencies = x:
    let
      immediate = x.passthru.addons or [];
    in
      immediate ++ lib.concatMap addonDependencies immediate;

  allAddons = lib.unique (addons ++ lib.concatMap addonDependencies addons);

  wrapped = symlinkJoin
    {
      name = "j-with-addons";
      paths = [ j ] ++ allAddons;
      failOnCollision = true;

      # jconsole uses its actual path to initialize BINPATH_z_; replace
      # the symlink with a copy of the executable so the symlinked
      # addons/ directory is found
      postBuild = ''
        rm $out/bin/jconsole
        cp ${j}/bin/jconsole $out/bin/jconsole
      '';
    };
in
wrapped.overrideAttrs (old: {
  meta = (old.meta or { }) // {
    mainProgram = "j";
  };
})
