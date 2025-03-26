{ pkgs, ... }:
{
    isNormalUser = true;
    description = "Archie Hickmott";
    extraGroups = [ "networkmanager" "wheel" ];
}