{pkgs, ... }:

{
  # Make sure this matches your system user:
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
  ];

  programs.home-manager.enable = true;
}
