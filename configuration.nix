# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
  swayAutoScale = pkgs.writeShellScriptBin "sway-autostart-scale" ''
    set -eu
    OUT="$(wlr-randr | awk '/^eDP/ {print $1; exit}')"
    if [ -z "${OUT:-}" ]; then
      OUT="$(wlr-randr | awk '/ connected$/ {print $1; exit}')"
    fi
    if [ -n "${OUT:-}" ]; then
      wlr-randr --output "$OUT" --scale 1.25
    fi
  '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      (import "${home-manager}/nixos")
      ./hardware-configuration.nix
    ];


  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.igor = {
    isNormalUser = true;
    description = "Igor";
    extraGroups = [ "networkmanager" "wheel" "audio"];
    shell = pkgs.fish;
  };

  home-manager.users.igor = { pkgs, ... }: {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    home.stateVersion = "25.05";
    home.packages = with pkgs; [
      spotify
      anki
      obsidian
      librewolf
      tutanota-desktop
      telegram-desktop
      qbittorrent
      tailscale
      mpv
      imv

      pass
      lazygit
      btop
      foot
      starship

      # zoxide
      # fzf
      # atuin
      # eza
      # mako
      # kanshi
      
      sway
      mesa
      swayidle
      swaylock
      pipewire
      wireplumber
      networkmanager
      pamixer
      seatd
      wlr-randr
      gvfs
      mtpfs
      wl-clipboard
      grim
      slurp
      wofi
      wf-recorder
      i3status-rust
      swww

      python3
      haskell.compiler.ghc98
      cargo
      go
    	helix
    	neofetch
    	fastfetch

    	noto-fonts
    	noto-fonts-cjk-sans
    	noto-fonts-emoji
    ];

    programs.git = {
      enable = true;
      userName = "Igor";
      userEmail = "igor@example.com";
    };

    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          include = "${pkgs.fetchurl {
            url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/solarized-dark";
            hash = "sha256-XRTrr4suyL1F8WwBEVfHR10biDKe6UV2pvtc9QobtQc=";
          }}";
          font = "Noto Sans Mono:size=16";
          bold-text-in-bright = true;
        };
      };
    };

    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "solarized_dark";
      };
    };

    programs.fish = {
      enable = true;
      shellAliases = {
        e = "hx";
      };
      loginShellInit = ''
        if test -z "$WAYLAND_DISPLAY" -a (tty) = "/dev/tty1"
          exec sway
        end
      '';
      interactiveShellInit = ''
        set fish_greeting 
      '';
    };

    programs.i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            { block = "cpu"; }
            { block = "memory"; }
            { block = "net"; device = "wlan0"; }
            { block = "time"; format = "%R"; }
          ];
        };
      };
    };

    # programs.i3status-rust = {
    #   enable = true;

    #   # один профиль бара с именем "top"
    #   bars.top = {
    #     settings = {
    #       theme = "native";   # минималистично
    #       icons = "none";     # без шрифтов-иконок, чтобы не тянуть лишнее
    #     };

    #     blocks = [
    #       { block = "cpu"; }
    #       { block = "memory"; }
    #       { block = "battery"; }     # если батареи нет — блок просто не покажется
    #       { block = "backlight"; }   # autodetect; если нет — пропустится
    #       { block = "sound"; }
    #       { block = "net"; }         # wifi/ethernet
    #       { block = "time"; format = "%Y-%m-%d %H:%M:%S"; }
    #     ];
    #   };
    # };

    wayland.windowManager.sway = {
      enable = true;
      config = let
        mod = "Mod4"; # Super
      in {
        modifier = mod;

        terminal = "foot";
        menu = "wofi -S drun";

        input = {
          "*" = {
            xkb_layout = "us,ru";
            xkb_variant = "intl";
            xkb_options = "grp:super_space_toggle";
            repeat_delay = "300";
            repeat_rate = "50";
          };
        };

        output = { };

        keybindings = {
          "${mod}+Return" = "exec foot";
          "${mod}+d"      = ''exec "wofi -S drun"'';
          "${mod}+q"      = "kill";
          "${mod}+f"      = "fullscreen toggle";
          "${mod}+Shift+f"= "floating toggle";
          "${mod}+e"      = "exit";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";

          "Print"       = ''exec sh -c 'dir=$HOME/Pictures/Screenshots; mkdir -p "$dir"; grim "$dir/$(date +%F_%H-%M-%S).png"' '';
          "Shift+Print" = ''exec sh -c 'dir=$HOME/Pictures/Screenshots; mkdir -p "$dir"; grim -g "$(slurp)" "$dir/$(date +%F_%H-%M-%S)_area.png"' '';

          "XF86AudioRaiseVolume" = "exec pamixer -i 5";
          "XF86AudioLowerVolume" = "exec pamixer -d 5";
          "XF86AudioMute"        = "exec pamixer -t";

          "XF86MonBrightnessUp"   = "exec brightnessctl set +5%";
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        };

        startup = [
          { command = "${swayAutoScale}/bin/sway-autostart-scale"; always = true; }
          { command = "swww init"; always = true; }
        ];

        bars = [{
          command = "swaybar";
          position = "top";
          statusCommand = "i3status-rs ~/.config/i3status-rust/config-default.toml";
          fonts = [ "monospace 10" ];
          trayOutput = "primary";
        }];
      };
    };

    programs.starship = {
      enable = true;

      settings = {
        add_newline = true;
        format = "$username@$hostname $directory $git_branch$git_status $python$line_break$character";
        username = { show_always = true; format = "$user"; };
        hostname = { format = "$hostname"; };
        python = { format = "\\(py:$virtualenv\\)"; };
        directory = { truncation_length = 4; truncate_to_repo = false; format = "$path"; };
        git_branch = { symbol = " "; format = "\\[$symbol$branch\\]"; };
        git_status = { format = "\\[$all_status$ahead_behind\\]"; };
        character = { success_symbol = "~>"; error_symbol = "~x"; };
      };
    };

  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  hardware.pulseaudio.enable = false;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    htop
    doas
    fish
    xwayland
  ];

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = ["igor"];
    # Optional, retains environment variables while running commands 
    # e.g. retains your NIX_PATH when applying your config
    keepEnv = true; 
    persist = false;  # Optional, only require password verification a single time
  }];

  services.xserver.enable = false;
  programs.fish.enable = true;
  services.timesyncd.enable = true;


  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting.enable = true;
    hinting.style = "slight";
    subpixel.rgba = "rgb";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.dbus.enable = true;
  programs.dconf.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
