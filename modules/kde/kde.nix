{ pkgs, lib, config, ...}:
{
  options = {
        plasma.enable =
            lib.mkEnableOption "enables KDE Plasma";
    };
      # Enable the X11 windowing system.
    config = {
      services.xserver.enable = true;

      # Enable the KDE Plasma Desktop Environment.
      services.displayManager.sddm.enable = true;
      services.desktopManager.plasma6.enable = true;
      services.displayManager.defaultSession = "plasmax11"; #forces x11 instead of wayland
      
      services.displayManager.sddm.settings = { General = { DisplayServer = "x11"; DefaultSession = "plasmax11"; }; };
      services.xserver.xkb = {
        layout = "au";
        variant = "";
      };

      environment.systemPackages = with pkgs; [
        kdePackages.kirigami
        kdePackages.kirigami-addons  
        xrdp

        xfce.xfce4-session  # XFCE session manager
        xfce.xfce4-panel    # XFCE panel
        xfce.xfce4-settings # XFCE settings manager
        xfce.xfce4-appfinder # Application finder
        xfce.xfce4-terminal # XFCE terminal
        xfce.xfce4-notifyd  # Notification daemon
        xfce.xfce4-power-manager # Power management
        xfce.thunar        # File manager
        xfce.xfce4-screenshooter # Screenshot tool
        xfce.xfce4-taskmanager # Task manager
        xfce.xfce4-whiskermenu-plugin # Alternative application launcher
        xfce.xfce4-pulseaudio-plugin # Audio control
      ];

      networking.firewall.allowedTCPPorts = [3389];

      services.xrdp = {
        enable = true;
        desktopManager.xfce.enable = true;
        displayManager.defaultSession = "xfce";
      };
  };
}