{ lib
, fetchFromGitHub
, stdenvNoCC
}:
stdenvNoCC.mkDerivation {
  name = "j-graphics-color";
  version = "1.0.19";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = "graphics_color";
    rev = "2bb8578c370fd2f25b118ae8cba11153c4687eab";
    hash = "sha256-K+N3q0DmKACLQS4iQKoW3VZEC3eG+fQQk8iIBpwptZQ=";
  };

  installPhase = ''
    mkdir -p $out/share/j/addons/graphics/color/
    cp -r . $out/share/j/addons/graphics/color/
  '';

  meta = {
    description = "J addon for color tables and related scripts";
    homepage = "https://github.com/jsoftware/graphics_color";
    license = lib.licenses.mit;
  };
}
