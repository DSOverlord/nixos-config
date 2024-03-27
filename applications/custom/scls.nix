{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage {
  pname = "simple-completion-language-server";
  version = "unstable-2024-03-26";

  src = fetchFromGitHub {
    owner = "estin";
    repo = "simple-completion-language-server";
    rev = "b2aebff5935bd5b848b847d2e35b3a0b61cc9b86";
    hash = "sha256-s6aBioqP/zwmPBHeNmNm7Q7cb7dMpHyC6UqwJ3eVm98=";
  };

  cargoHash = "sha256-JGoy5LGmbNYw4rCQZmmrczIpImRA9jhFWBaZ0Dk00sg=";

  meta = with lib; {
    description = "Language server to enable word completion and snippets for Helix editor";
    homepage = "https://github.com/estin/simple-completion-language-server";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "simple-completion-language-server";
  };
}
