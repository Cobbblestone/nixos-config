{ config, pkgs, ... }:

{
  home.username = "CobbSalad";
  home.homeDirectory = "/home/CobbSalad";

  # Packages to install for the user
  home.packages = with pkgs; [
    firefox
    discord
    xfce.thunar # File manager
    rofi # ML4W uses Rofi instead of Wofi
    swaynotificationcenter # ML4W Notification Center
    linux-wallpaperengine # Wallpaper Engine for Linux
    networkmanagerapplet
    font-awesome # For icons in waybar
  ];

  # Kitty Terminal (ML4W style)
  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width = 15;
      background_opacity = "0.8";
      font_family = "monospace";
      font_size = "12.0";
    };
  };

  # Waybar (ML4W Pill Style)
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 10;
        margin-left = 20;
        margin-right = 20;
        height = 36;
        spacing = 10;
        modules-left = [ "hyprland/workspaces" "custom/media" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "battery" "tray" ];
        
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "1"; "2" = "2"; "3" = "3"; "4" = "4"; "5" = "5";
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
        };
        "clock" = {
          format = "{:%I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            "headphone" = "";
            "default" = ["" "" ""];
          };
        };
        "network" = {
          format-wifi = "";
          format-ethernet = "";
          format-disconnected = "⚠";
        };
      };
    };
    style = ''
      * {
        font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        font-size: 14px;
        border-radius: 18px;
      }
      window#waybar {
        background-color: rgba(30, 30, 46, 0.8);
        color: #cdd6f4;
      }
      #workspaces button {
        padding: 0 10px;
        color: #cdd6f4;
      }
      #workspaces button.active {
        color: #89b4fa;
        background-color: rgba(137, 180, 250, 0.2);
      }
      #clock, #battery, #cpu, #memory, #disk, #temperature, #backlight, #network, #pulseaudio, #wireplumber, #custom-media, #tray, #mode, #idle_inhibitor, #scratchpad, #mpd {
        padding: 0 15px;
        margin: 0 5px;
        color: #cdd6f4;
      }
    '';
  };

  # Network Applet Service
  services.network-manager-applet.enable = true;

  # Hyprland Config (Pure Nix ML4W Aesthetic)
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";
      exec-once = [
        "waybar"
        "nm-applet --indicator"
        "swaync"
        # Find your monitor name with `hyprctl monitors` and replace DP-1 if needed
        "linux-wallpaperengine --screen-root all 3244040553" 
      ];
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(89b4faee) rgba(cba6f7ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 15;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, kitty"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, E, exec, thunar"
        "$mod, V, togglefloating"
        "$mod, R, exec, rofi -show drun -show-icons"
        # "$mod, P, pseudo"
        # "$mod, J, togglesplit" # Now valid because layout=dwindle is set
        "$mod, F, exec, firefox"
      ] ++ (
        # workspaces
        builtins.concatLists (builtins.genList (
            x: let
              ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${builtins.toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${builtins.toString (x + 1)}"
            ]
          )
          10)
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
