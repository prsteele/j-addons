{ lib
, fetchFromGitHub
, buildJAddon
}:
buildJAddon rec {
  repo = "general_misc";
  version = "2.6.0";
  src = fetchFromGitHub {
    owner = "jsoftware";
    repo = repo;
    rev = "3133b02e50ce8110df1959ca72ec4933c661a504";
    hash = "sha256-D0fHU/oBwryVhuzGDN4qd7AswC10x7y00lVnwO7WaTA=";
  };

  meta = {
    description = "J addon for miscellaneous general scripts";
    homepage = "https://github.com/jsoftware/general_misc";
    license = lib.licenses.mit;
  };
}
