{ lib
, fetchFromGitHub
, stdenvNoCC
}:
stdenvNoCC.mkDerivation {
  name = "j-graphics-afm";
  version = "1.0.15";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = "graphics_afm";
    rev = "a5dd48482aa0f37a1e917d3651148203312a8107";
    hash = "sha256-fbrlsLdNBYKajvyE8dit3OuUJlR+8/38ipcNYkFA9E8=";
  };

  installPhase = ''
    mkdir -p $out/share/j/addons/graphics/afm/
    cp -r . $out/share/j/addons/graphics/afm/
  '';

  meta = {
    description = "J addon for Adobe font metrics";
    homepage = "https://github.com/jsoftware/graphics_afm";
    license = lib.licenses.mit;
  };
}
