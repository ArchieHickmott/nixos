{ pkgs, lib, config, ...}:
{
  options = {
        plasma.enable =
            lib.mkEnableOption "enables KDE Plasma";
    };
      # Enable the X11 windowing system.
    config = {
      services.xserver = {
        enable = true;
        desktopManager.xfce.enable = true;
      };

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

        xfce.xfce4-session
        xfce.xfce4-panel
        xfce.xfce4-settings
        xfce.xfce4-appfinder
        xfce.xfce4-terminal
        xfce.xfce4-notifyd
        xfce.xfce4-power-manager
        xfce.thunar
        xfce.xfce4-screenshooter
        xfce.xfce4-taskmanager
        xfce.xfce4-whiskermenu-plugin
        xfce.xfce4-pulseaudio-plugin
      ];

      networking.firewall.allowedTCPPorts = [3389];

      services.xrdp = {
        enable = true;
        openFirewall = true;
      };
  };
}