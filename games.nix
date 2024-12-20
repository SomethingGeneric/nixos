{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vitetris
    moon-buggy
    steam     
    ckan
    libretro.thepowdertoy
    lutris
  ];


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  hardware.opengl = {
    driSupport32Bit = true;
  
    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

}
