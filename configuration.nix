{ config, pkgs, ... }:

# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hacker.nix
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
  # -----------

  networking.hostName = "richardnixxon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking (and wifi!)
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
  	enable = true;
  	# nightmare for fractional scaling
  	extraGSettingsOverrides = ''
  	  [org.gnome.mutter]
  	  experimental-features=['scale-monitor-framebuffer']
  	'';
  	extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
  };
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  services.gnome.gnome-browser-connector.enable = true;

  # TODO: this is to mitigate a dep warning by the firefox extensions line above
  # but clearly i misunderstand the syntax because it doesn't work lol
  # nativeMessagingHosts.packages = [ pkgs.gnome-browser-connector ];

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matt = {
    isNormalUser = true;
    description = "matt";
    extraGroups = [ "networkmanager" "wheel" "scanner"];
    shell = pkgs.zsh;
    # user packages go buhbye
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
     wget
     micro
     zsh
     curl
     git
     neofetch
     firefox
     chromium
     thunderbird
     discord
     usbutils
     signal-desktop
     gnome-extension-manager
     vitetris
     moon-buggy
     steam
     obsidian
     pkgs.vscode-fhs
     slack
     
     # gnome suffering
     pkgs.gnome.gnome-tweaks # why tf is this in pkgs.gnome but below isn't ??
     pkgs.gnomeExtensions.dash-to-dock
     pkgs.gnomeExtensions.caffeine
     pkgs.gnomeExtensions.gsconnect
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.zsh.enable = true;
  programs.git.enable = true;
  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.fwupd.enable = true;  
  services.fprintd.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
