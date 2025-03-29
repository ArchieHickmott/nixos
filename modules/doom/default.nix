{ config, pkgs, lib, ... }:

{
  options.doom.enable = lib.mkEnableOption "Doom Emacs configuration";

  config = lib.mkIf config.doom.enable {

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      emacs                         # Emacs itself
      git                           # Required for updates (only one instance)
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
      nixfmt-classic                # Nix formatting

      nerd-fonts.symbols-only
    ];


    # Ensure Doom Emacs is installed or updated,
    # adding git's bin directory to PATH explicitly.
    home.activation.doom-emacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH=${pkgs.emacs}/bin:${pkgs.git}/bin:$PATH
      if [ ! -d "$HOME/.emacs.d" ]; then
        echo "Cloning Doom Emacs..."
        git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
        ~/.emacs.d/bin/doom install
      else
        echo "Updating Doom Emacs..."
        ~/.emacs.d/bin/doom sync
      fi
    '';
  };
}
