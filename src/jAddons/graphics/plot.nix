{ lib
, fetchFromGitHub
, jAddons
, buildJAddon
}:
buildJAddon rec {
  repo = "graphics_plot";
  version = "1.0.209";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = repo;
    rev = "b761889eac7e66ff9d65405298bc1e809dbcfb41";
    hash = "sha256-bMBvs+FkYGK+76dKpn+DU1fnaj8CTcKSG5FqEnVqCys=";
  };

  dependencies = with jAddons; [
    arc.zlib
    graphics.afm
    graphics.bmp
    graphics.color
    graphics.png
    math.misc
    general.misc
  ];

  meta = {
    description = "J addon for plotting";
    homepage = "https://github.com/jsoftware/graphics_plot";
    license = lib.licenses.mit;
  };
}
