{ lib
, stdenvNoCC
}:
{ repo
, dependencies ? [ ]
, ...
}@args:
let
  components = lib.strings.splitString "_" repo;
  category = builtins.elemAt components 0;
  name = builtins.elemAt components 1;
in
stdenvNoCC.mkDerivation (
  {
    name = "j-${category}-${name}";
    passthru.addons = dependencies;
    installPhase = ''
      mkdir -p $out/share/j/addons/${category}/${name}/
      cp -r . $out/share/j/addons/${category}/${name}/
    '';
  } // args
)
