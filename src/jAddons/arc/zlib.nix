{ lib
, fetchFromGitHub
, buildJAddon
}:
buildJAddon rec {
  repo = "arc_zlib";
  version = "1.0.11";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = repo;
    rev = "23a7460900c09909eda35533bdbe9b816ceefc81";
    hash = "sha256-uH1IbjHEtjtmTBMZInprn4w6TWdtfSGpiyepJ/yIGFU=";
  };

  meta = {
    description = "J addon for zlib utilities";
    homepage = "https://github.com/jsoftware/arc_zlib";
    license = lib.licenses.mit;
  };
}
