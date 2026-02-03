{ lib
, fetchFromGitHub
, buildJAddon
}:
buildJAddon rec {
  repo = "graphics_afm";
  version = "1.0.15";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = repo;
    rev = "a5dd48482aa0f37a1e917d3651148203312a8107";
    hash = "sha256-fbrlsLdNBYKajvyE8dit3OuUJlR+8/38ipcNYkFA9E8=";
  };

  meta = {
    description = "J addon for Adobe font metrics";
    homepage = "https://github.com/jsoftware/graphics_afm";
    license = lib.licenses.mit;
  };
}
