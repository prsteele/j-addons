{ lib
, fetchFromGitHub
, stdenvNoCC
}:
stdenvNoCC.mkDerivation {
  name = "j-general-misc";
  version = "2.6.0";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = "general_misc";
    rev = "3133b02e50ce8110df1959ca72ec4933c661a504";
    hash = "sha256-D0fHU/oBwryVhuzGDN4qd7AswC10x7y00lVnwO7WaTA=";
  };

  passthru.addons = [ ];

  installPhase = ''
    mkdir -p $out/share/j/addons/general/misc/
    cp -r . $out/share/j/addons/general/misc/
  '';

  meta = {
    description = "J addon for miscellaneous general scripts";
    homepage = "https://github.com/jsoftware/general_misc";
    license = lib.licenses.mit;
  };
}
