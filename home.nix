{ config, ... }:

{
  imports = [ <home-manager/nixos>  ];

  config = {
    home-manager.users.archie = {
      # home-manager settings
      programs.git = {
        enable = true;
        userName = "Archie";
        userEmail = "25hickmar@gmail.com";
      };
    };
  };
}