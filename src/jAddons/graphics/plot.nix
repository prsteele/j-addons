{ lib
, fetchFromGitHub
, stdenvNoCC
  # J addons
, jAddons
}:
stdenvNoCC.mkDerivation {
  name = "j-graphics-plot";
  version = "1.0.209";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = "graphics_plot";
    rev = "b761889eac7e66ff9d65405298bc1e809dbcfb41";
    hash = "sha256-bMBvs+FkYGK+76dKpn+DU1fnaj8CTcKSG5FqEnVqCys=";
  };

  passthru.addons = with jAddons;
    [
      arc.zlib
      graphics.afm
      graphics.bmp
      graphics.color
      graphics.png
      math.misc
      general.misc
    ];

  installPhase = ''
    mkdir -p $out/share/j/addons/graphics/plot/
    cp -r . $out/share/j/addons/graphics/plot/
  '';

  meta = {
    description = "J addon for plotting";
    homepage = "https://github.com/jsoftware/graphics_plot";
    license = lib.licenses.mit;
  };
}
