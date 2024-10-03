{ config, pkgs, ... }:

{

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [

	# probably don't need this?
  
  ];
}
