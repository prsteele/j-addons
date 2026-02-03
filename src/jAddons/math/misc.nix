{ lib
, fetchFromGitHub
, buildJAddon
}:
buildJAddon rec {
  repo = "math_misc";
  version = "1.2.9";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = repo;
    rev = "8afab03e45fcc04ad9e39aa8596f7a7df695eb60";
    hash = "sha256-ijVDwjPiNC+w27EZsdZffwNMAiu0CMF4/TbNnH3OsIw=";
  };

  meta = {
    description = "J addon for miscellaneous math functions";
    homepage = "https://github.com/jsoftware/math_misc";
    license = lib.licenses.mit;
  };
}
