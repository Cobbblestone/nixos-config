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

  # SDDM Display Manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # System packages (basics)
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
  ];
}
