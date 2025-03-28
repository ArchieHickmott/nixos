{ config, pkgs, lib, ... }:

{
  options.doom.enable = lib.mkEnableOption "Doom Emacs configuration";

  config = lib.mkIf config.doom.enable {
    home.file = {
      ".doom.d".source = ../users/archie/dotfiles/.doom.d;
    };

    home.packages = with pkgs; [
      emacs                         # Emacs itself
      git                           # Required for updates
      ripgrep                       # Search functionality
      fd                            # Fast file searching
      gnutls                        # TLS support
      zstd                          # Compression
      coreutils                     # Basic utilities
      findutils                     # Find command
      gnugrep                       # Grep support
      gawk                          # Required for Doom scripts
      curl                          # Fetching external resources
      unzip                         # Extracting archives
      xclip                         # Clipboard support (X11)
      wl-clipboard                  # Clipboard support (Wayland)
      fzf                           # Fuzzy finding
      tree-sitter                   # Syntax highlighting
      sqlite                        # Needed for org-roam
      nodejs                        # Language Server Protocol (LSP)
      yarn                          # Required for some LSP servers
      python3                       # Python support
      nixfmt                        # Nix formatting
    ];

    # Ensure Doom Emacs is installed
    home.activation = {
      doom-emacs = ''
        if [ ! -d "$HOME/.emacs.d" ]; then
          git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
          ~/.emacs.d/bin/doom install
        fi
      '';
    };
  };
}
