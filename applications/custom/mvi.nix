{ stdenvNoCC, fetchgit, mpv-unwrapped, lib }:

stdenvNoCC.mkDerivation {
  pname = "mpv-image-viewer";
  version = mpv-unwrapped.version;

  src = fetchgit {
    url = "https://gist.github.com/DSOverlord/2489fc4095ea5bee16be0c102a7bda9d";
    rev = "823b2477fed09b97e4d8bb5d48af4dc710606c78";
    sha256 = "sha256-vVr38Ei1r1M3mXDVaIEv4u6Zy0nHeNEtpeVNLDUauNI=";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/mpv/scripts
    cp mvi.lua $out/share/mpv/scripts
  '';
  passthru.scriptName = "mvi.lua";

  meta = {
    description = "";
    homepage = "";
    maintainers = [ ];
    license = lib.licenses.unlicense;
  };
}
