{ lib
, fetchFromGitHub
, buildJAddon
}:
buildJAddon rec {
  repo = "general_unittest";
  version = "1.0.12";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = repo;
    rev = "c0916768bba3832fbb9bf2305d34575a5adc0ad0";
    hash = "sha256-kmc835Bcb7+Lb0FSlWV4p2NGyp4hgb/TwWGFKg+A6Eg=";
  };

  meta = {
    description = "J addon for unit testing";
    homepage = "https://github.com/jsoftware/general_unittest";
    license = lib.licenses.mit;
  };
}
