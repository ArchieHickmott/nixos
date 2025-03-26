{ config, pkgs, ... }:

{
  # Make sure this matches your system user:
  home.username = "archie";
  home.homeDirectory = "/home/archie";
  nixpkgs.config.allowUnfree = true;

  # Example: console configuration
  # If you want custom fonts or other console-related tweaks:
  # programs.somethingConsole = { ... };

  # Example: plain Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # Example: installing doom-emacs plus your own config
  # There are several ways to handle Doom. One approach:
  #  1. Let Home Manager install doom-emacs.
  #  2. Source your doom config from your dotfiles or a separate flake.
  #
  # If you keep your doom config in ~/.doom.d, you can do:
  # home.file.".doom.d/init.el".source = ./doom/init.el;
  # home.file.".doom.d/config.el".source = ./doom/config.el;
  # home.file.".doom.d/packages.el".source = ./doom/packages.el;
  #
  # Or store them in a separate repo. For example:
  # home.file.".doom.d/init.el".source = "${yourDoomRepo}/init.el";
  #
  # Then override 'programs.emacs.package' to point to doom if you like.

  # Example: packages you want installed at the user level
  home.packages = with pkgs; [
    # Some random goodies
    htop
    wget
    kdePackages.kate
    prismlauncher
    rpi-imager
    steam
    maturin
    musescore
  ];

  # You can do the same pattern for other apps:
  # xdg.configFile."foo/bar.conf".source = ./bar.conf;
}
