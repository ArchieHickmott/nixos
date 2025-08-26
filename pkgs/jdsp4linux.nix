{ stdenv, fetchFromGitHub, cmake, qt6, fftw }:

stdenv.mkDerivation rec {
  pname = "jdsp4linux";
  version = "2.7.0";
  src = fetchFromGitHub {
    owner = "Audio4Linux";
    repo = "JDSP4Linux";
    rev = "${version}";
    sha256 = "03alrnfr5qalwlwbyypzkp2nqpwik09q9w2cv4y6ys84afijx6h1";
  };
  nativeBuildInputs = [ cmake qt6.wrapQtAppsHook ];
  buildInputs = [ qt6.qtbase fftw ];
  installPhase = ''
    mkdir -p $out/bin
    cp jamesdsp $out/bin/
    cp jamesdsp-qt $out/bin/
  '';
}