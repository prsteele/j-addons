{ lib
, fetchFromGitHub
, stdenvNoCC
}:
stdenvNoCC.mkDerivation {
  name = "j-arc-zlib";
  version = "1.0.11";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = "arc_zlib";
    rev = "23a7460900c09909eda35533bdbe9b816ceefc81";
    hash = "sha256-uH1IbjHEtjtmTBMZInprn4w6TWdtfSGpiyepJ/yIGFU=";
  };

  installPhase = ''
    mkdir -p $out/share/j/addons/arc/zlib/
    cp -r . $out/share/j/addons/arc/zlib/
  '';

  meta = {
    description = "J addon for zlib utilities";
    homepage = "https://github.com/jsoftware/arc_zlib";
    license = lib.licenses.mit;
  };
}
