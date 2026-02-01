{ lib
, fetchFromGitHub
, stdenvNoCC
, jAddons
}:
stdenvNoCC.mkDerivation {
  name = "j-graphics-png";
  version = "1.0.30";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = "graphics_png";
    rev = "2f3c1012bfbf0594d107ba510d6b973a2ec50314";
    hash = "sha256-buS7LdQuUAO1Nq//czsWkEmfPjBQB8gCtFEc8XiluRk=";
  };

  passthru.addons = with jAddons;
    [
      arc.zlib
    ];

  installPhase = ''
    mkdir -p $out/share/j/addons/graphics/png/
    cp -r . $out/share/j/addons/graphics/png/
  '';

  meta = {
    description = "J addon for PNG utilities";
    homepage = "https://github.com/jsoftware/graphics_png";
    license = lib.licenses.mit;
  };
}
