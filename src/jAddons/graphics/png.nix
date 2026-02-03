{ lib
, fetchFromGitHub
, jAddons
, buildJAddon
}:
buildJAddon rec {
  repo = "graphics_png";
  version = "1.0.30";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = repo;
    rev = "2f3c1012bfbf0594d107ba510d6b973a2ec50314";
    hash = "sha256-buS7LdQuUAO1Nq//czsWkEmfPjBQB8gCtFEc8XiluRk=";
  };

  dependencies = with jAddons; [
    arc.zlib
  ];

  meta = {
    description = "J addon for PNG utilities";
    homepage = "https://github.com/jsoftware/graphics_png";
    license = lib.licenses.mit;
  };
}
