{pkgs, ... }:

{
  home.username = "archie";
  home.homeDirectory = "/home/archie";
  nixpkgs.config.allowUnfree = true;

  imports = [ ../../modules/doom/default.nix ];

  doom.enable = true;

  home.packages = with pkgs; [
    htop
    wget
    kdePackages.kate
    prismlauncher
    rpi-imager
    steam
    maturin
    git
    wine
    remmina
    wireshark
    qpwgraph
    ardour
    spotify
    hydrogen
    caps
    surge-XT
    ghidra
    obsidian
    trunk
    reaper
    vital
  ];


  programs.home-manager.enable = true;
}
