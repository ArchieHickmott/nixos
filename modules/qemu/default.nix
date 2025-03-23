{ pkgs, lib, config, ...}:
{
    options = {
        qemu.enable =
            lib.mkEnableOption "enables qemu";
    };

    config = {
        environment.systemPackages = with pkgs; [
            qemu  
            qemu-utils
        ];

        # Enable binfmt support for running different architectures
        boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
    };
}