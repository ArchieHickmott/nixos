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
        xrdp
      ];

      networking.firewall.allowedTCPPorts = [3389];

      services.xrdp = {
        enable = true;
      };
  };
}