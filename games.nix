{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vitetris
    moon-buggy
    steam     
  ];

}
