{ config, pkgs, ... }:

{
  home.username = "CobbSalad";
  home.homeDirectory = "/home/CobbSalad";

  # Packages to install for the user
  home.packages = with pkgs; [
    firefox
    discord
    xfce.thunar # File manager
  ];

  # Kitty Terminal
  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width = 10;
      background_opacity = "0.9";
    };
  };

  # Waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "network" "pulseaudio" "clock" "tray" ];
      };
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
