{ pkgs, ... }:
{
    isNormalUser = true;
    description = "Archie Hickmott";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
}