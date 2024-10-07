{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./hacker.nix
    ./games.nix
    ./gnome.nix
    #./nstall.nix
  ];

  # -----------
  # Bootloader.
  # Goodbye systemd-boot
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Grub
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.devices = ["nodev"]; 
  boot.loader.grub.useOSProber = true;

  # Enable networking (and wifi!)
  networking.networkmanager.enable = true;

  # -----------

  networking.hostName = "richardnixxon";
  time.timeZone = "Europe/Dublin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # NOTE: doesn't seem to be needed when GNOME

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.matt = {
    isNormalUser = true;
    description = "matt";
    extraGroups = [ "networkmanager" "wheel" "scanner" "docker"];
    shell = pkgs.zsh;
    # packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # Required for obsidian
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     android-studio
     wget
     unzip
     zsh
     curl
     git
     neofetch
     firefox
     thunderbird
     usbutils
     signal-desktop
     gnome-extension-manager
     obsidian
     pkgs.vscode-fhs
     slack
     obs-studio
     mullvad-vpn
     sshs
     chromium
     python3Full
     gimp
     pkgs.lexend
     pipx
     cura
     openssl
     /nix/store/hmrd05cdl05qc5nxs1n7wf9w202k01bd-nstall-0.2.2
     pkgs.jetbrains.idea-community-bin
     jdk22
     pkgs.libglvnd
     alsa-lib
     micro
     discord
     rustup
     gcc49
     pkg-config
     cmake
     vesktop
  ];

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;
  programs.git.enable = true;
  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.mullvad-vpn.enable = true;
  services.tailscale.enable = true;
  services.fwupd.enable = true;  
  services.fprintd.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  environment.variables.EDITOR = "micro";
  environment.variables.OPENSSL_DEV=pkgs.openssl.dev;
  environment.variables.PKG_CONFIG_PATH = "${pkgs.alsa-lib.dev}/lib/pkgconfig:" + "${pkgs.openssl.dev}/lib/pkgconfig:" + (builtins.getEnv "PKG_CONFIG_PATH");
  environment.variables.LD_LIBRARY_PATH = lib.makeLibraryPath [pkgs.libglvnd];
  
  
  hardware.opengl.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
