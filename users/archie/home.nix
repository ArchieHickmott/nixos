{ config, pkgs, lib, ... }:

{
  # Make sure this matches your system user:
  home.username = "archie";
  home.homeDirectory = "/home/archie";
  nixpkgs.config.allowUnfree = true;

  imports = [ ../../modules/doom.nix ];

  doom.enable = True;

  home.packages = with pkgs; [
    htop
    wget
    kdePackages.kate
    prismlauncher
    rpi-imager
    steam
    maturin
  ];

  programs.home-manager.enable = true;
}
