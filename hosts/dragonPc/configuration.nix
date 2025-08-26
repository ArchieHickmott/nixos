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
    git
    cmake
    rustup
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    nvidia-vaapi-driver
    libreoffice-qt
    hunspell
    hunspellDicts.en_AU-large
    glxinfo
    pipewire
    pipewire.jack
    gimp
    cifs-utils
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

  systemd.mounts = [
    {
      what = "192.168.0.141:/mnt/storage";  # NFS server:path
      where = "/mnt/bulk";                  # local mount point
      type = "nfs";
      options = "rw,vers=4,hard,intr";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
    }
  ];

  networking.hostName = "dragonPc";
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

  services.xserver = {
    xkb = {
      layout = "au";
      variant = "";
    };
    videoDrivers = [ "nvidia" ];
    enable = true;
  };
  
  services.printing.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = systemPackages ++ pythonPackages;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
      AllowUsers = null;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # safer default
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "24.11";

  system.autoUpgrade.enable  = true;

  environment.variables = {
    GM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "x11";
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    open = false;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vulkan-loader
      vulkan-validation-layers
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      vulkan-loader
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libglvnd
      nvidia-vaapi-driver
      vulkan-loader
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libglvnd
      libva
      vulkan-loader
    ];
  };
}
