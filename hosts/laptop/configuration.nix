{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Make sure to replace this file!
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  # Tailscale
  services.tailscale.enable = true;

  # Hyprland (System level)
  programs.hyprland.enable = true;

  # User Configuration
  users.users.CobbSalad = {
    isNormalUser = true;
    description = "CobbSalad";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Graphics (Intel)
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Do not change this value
  system.stateVersion = "24.05";
}
