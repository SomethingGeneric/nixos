{ config, pkgs, ... }:

{

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
  	enable = true;
   	# nightmare for fractional scaling
   	extraGSettingsOverrides = ''
   	  [org.gnome.mutter]
   	  experimental-features=['scale-monitor-framebuffer']
   	'';
  	extraGSettingsOverridePackages = [ pkgs.mutter ];
  };

  #nixpkgs.config.firefox.enableGnomeExtensions = true;
  #services.gnome.gnome-browser-connector.enable = true;
  
  # TODO: this is to mitigate a dep warning by the firefox extensions line above
  # but clearly i misunderstand the syntax because it doesn't work lol
  # nativeMessagingHosts.packages = [ pkgs.gnome-browser-connector ];

  environment.systemPackages = with pkgs; [
    pkgs.gnome-tweaks # why tf is this in pkgs.gnome but below isn't ??
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.gsconnect
    pkgs.gnome-builder
  ];
}
