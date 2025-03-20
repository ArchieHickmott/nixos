# modules/global-users/default.nix
{ pkgs, ... }:
{
    isNormalUser = true;
    description = "Archie Hickmott";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      prismlauncher
      rpi-imager
      steam
      maturin
    ];
    programs.git.config
}