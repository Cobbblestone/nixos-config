{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Make sure to replace this file during install!
  ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  # Tailscale
  services.tailscale.enable = true;

  # Hyprland (System level)
  programs.hyprland.enable = true;

  # Enable SSH
  services.openssh.enable = true;

  # User Configuration
  users.users.CobbSalad = {
    isNormalUser = true;
    description = "CobbSalad";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Graphics (Works for both AMD and Intel implicitly via mesa)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Do not change this value
  system.stateVersion = "24.05";
}
