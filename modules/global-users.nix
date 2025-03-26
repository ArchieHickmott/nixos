{ pkgs, lib, config, ... }:

let
  # Import all user files from the users/ directory
  userFiles = builtins.readDir ../users;
  users = lib.mapAttrs (name: _: import (../users + "/${name}/default.nix") { inherit pkgs lib; }) userFiles;
in {
  options.globalUsers = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        description = lib.mkOption {
          type = lib.types.str;
          description = "User description";
        };
        isNormalUser = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether this is a normal user";
        };
        extraGroups = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
          description = "Extra groups for the user";
        };
        packages = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = [];
          description = "Packages for the user";
        };
      };
    });
    default = users;
    description = "Global user configurations";
  };

  config.users.users = lib.mapAttrs (name: user: {
    inherit (user) description isNormalUser extraGroups;
    packages = user.packages;
  }) config.globalUsers;
}