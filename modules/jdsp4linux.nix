{ config, lib, pkgs, ... }:

let
  jdsp4linux = pkgs.stdenv.mkDerivation rec {
    pname = "jdsp4linux";
    version = "2.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "Audio4Linux";
      repo = "JDSP4Linux";
      rev = version;
      sha256 = "03alrnfr5qalwlwbyypzkp2nqpwik09q9w2cv4y6ys84afijx6h1";
    };

    nativeBuildInputs = [ 
      pkgs.cmake 
      pkgs.pkg-config
      pkgs.qt6.wrapQtAppsHook
    ];

    buildInputs = [
      pkgs.qt6.qtbase
      pkgs.qt6.qttools
      pkgs.fftw
      pkgs.fftwFloat
    ];
    buildPhase = ''
      cmake -B build -S . \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=$out
      cmake --build build --parallel $NIX_BUILD_CORES
    '';

    installPhase = ''
      cmake --install build
      # Ensure binaries are executable
      chmod +x $out/bin/jamesdsp
      chmod +x $out/bin/jamesdsp-qt
    '';

    qtWrapperArgs = [
      "--prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ pkgs.fftw pkgs.fftwFloat ]}"
    ];
  };
in {
  options.jdsp4linux.enable = lib.mkEnableOption "Enable JDSP4Linux";

  config = lib.mkIf config.jdsp4linux.enable {
    environment.systemPackages = [ jdsp4linux ];
    environment.pathsToLink = [ "/bin" ];
    systemd.user.services.jamesdsp = {
      description = "JamesDSP Service";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${jdsp4linux}/bin/jamesdsp";
        Restart = "always";
      };
    };
  };
}