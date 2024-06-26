#ddm Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./python/python.nix
    ];

  # Hyprland stuff
  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      command = "Hyprland";
    };
  };
  programs.regreet.enable = true;

  # Pipewire stuff
  security.rtkit.enable = true;
  services.pipewire = {
     enable = true;
     alsa.enable=true;
     pulse.enable=true;
  };

  # Bootloader.
  # depricated systemdboot
  boot.loader.systemd-boot.enable = false;
  #boot.loader.efi.canTouchEfiVariables = true;
  # GRUB
  boot.loader = {
    efi = {
      # canTouchEfiVariables=true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiInstallAsRemovable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bruhng = {
    isNormalUser = true;
    description = "Gustav Bruhn";
    packages = with pkgs; [];
    extraGroups = [ "docker" "networkmanager" "wheel" "scanner" "lp" "uucp"];
  };

  services.udev.packages = with pkgs; [
    bazecor
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    firefox
    kitty
    wofi
    libsForQt5.polkit-kde-agent
    neofetch
    mako
    xfce.thunar
    zig
    gnumake
    discord
    spotify
    vscode
    go
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })
    )
    qpwgraph
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
      ];
    }) 
  ];

	
  fonts.packages = with pkgs; [
    nerdfonts
  ];
  
  programs.ssh.startAgent = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
