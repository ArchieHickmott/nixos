{ pkgs, lib, config, ...}:
{
    options = {
        plasma.enable =
            lib.mkEnableOption "enables KDE Plasma";
    };

    config = {
        virtualisation.virtualbox.host.enable = true;
        environment.systemPackages = with pkgs; [
            virtualbox
        ]
    };
}