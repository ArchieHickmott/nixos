{ pkgs, ... }:
{
  users.users.archie = {
    isNormalUser = true;
    description = "Archie Hickmott";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}