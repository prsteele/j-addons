{ lib
, fetchFromGitHub
, stdenvNoCC
}:
stdenvNoCC.mkDerivation {
  name = "j-graphics-bmp";
  version = "1.0.17";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = "graphics_bmp";
    rev = "3e17ccaf925039c6b225f6a759a1941c191612ae";
    hash = "sha256-oB239TG+9vj3XqkjLntbDFXrhC9MZF5h+oZlMu+vC8w=";
  };

  installPhase = ''
    mkdir -p $out/share/j/addons/graphics/bmp/
    cp -r . $out/share/j/addons/graphics/bmp/
  '';

  meta = {
    description = "J addon for bitmap utilities";
    homepage = "https://github.com/jsoftware/graphics_bmp";
    license = lib.licenses.mit;
  };
}
