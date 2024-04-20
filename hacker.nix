{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     # ethhack stuff 
     nmap
     dirb
     dirbuster
     metasploit
     hashcat
     john # (unshadow?)
     wireshark
     remmina
     virt-viewer     
  ];

}
