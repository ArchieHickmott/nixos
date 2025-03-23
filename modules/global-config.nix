{ pkgs, lib, config, ...}:
{
    config = {
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
    };
}