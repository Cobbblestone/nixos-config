{ pkgs, ... }:

{
  time.timeZone = "America/New_York"; # Adjust this to your timezone!

  # Audio (Pipewire is standard for Wayland)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # SDDM Display Manager (X11 backend to avoid Wayland experimental bugs)
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = false;
  services.displayManager.defaultSession = "hyprland";

  # System packages (basics)
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
  ];
}
