{ pkgs, lib, config, ...}:
{
    config = {
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        environment.systemPackages = with pkgs; [
            nixd
        ];
        nix.nixPath = [ "nixpkgs=${pkgs.path}" ]; 
    };
}