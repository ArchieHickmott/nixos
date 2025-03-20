{ config, pkgs, ... }:

let
  systemPackages = with pkgs; [
      vim 
      wget
      python3
      gcc
      libgcc
      vscode
      ffmpeg
      stdenv
      nmap
      freerdp
      git
      cmake
      rustup
  ];

  pythonPackages = with pkgs.python3Packages; [
      pip
  ];
in
{

  imports =
    [  
        ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dragonPc"; 

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
  time.timeZone = "Australia/Brisbane";

  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

 # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = systemPackages ++ pythonPackages;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = false;
    pubkeyAuthentication = true;
    AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  };
};

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [22];
  # networking.firewall.allowedUDPPorts = [21116];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = true;
  hardware.graphics.enable = true;
  environment.variables = {
    "GM_BACKEND" = "nvidia-drm";
    "LIBVA_DRIVER_NAME" = "nvidia";
    "XDG_SESSION_TYPE" = "X11";
    "WLR_NO_HARDWARE_CURSORS" = "1";
  };

}
