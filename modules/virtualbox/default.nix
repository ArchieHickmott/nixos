{ pkgs, lib, config, ...}:
{
    options = {
        virtualbox.enable =
            lib.mkEnableOption "enables KDE Plasma";
    };

    config = {
        virtualisation.virtualbox.host.enable = true;
        environment.systemPackages = with pkgs; [
            virtualbox
        ];
    };
}