{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.device = "/dev/vda";

  boot.initrd.luks.devices = [
    { device = "/dev/vda2"; name = "luksroot"; }
  ];

  networking.hostName = "aurora";

  system = {
    autoUpgrade.enable = true;
    stateVersion = "16.03";
  };

  environment.systemPackages = with pkgs; [
    fish
    htop
    lsof
    neovim
  ];

  services = {
    openssh = {
      enable = true;
      startWhenNeeded = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };

    timesyncd.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  users.extraUsers.abs = {
    uid = 1000;
    description = "Aaron Bull Schaefer";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA3MG0paBPBz54OE7TQOKZptXoXR/fQOsyBsYbgGMF9GSQsjPRzB/xP5xCKq7RlDevVFMv1rhhaCZ4IVn+55R4xeByQqgLAFla7vDZ7ch0PSrY4J/0w0yrJzJTwkgVXMfIoWbZm+nQ+COdi+NEbUbXRpZOWceOgYfEvCuyJII+D4EGVHtOm+5CZbMe4nCnFnggLwDnKrgp0+/wvCuTyqhV2OIraoyW2QnqyybzAqjUmzbDDzfFRBPUAY85RualD6D3PjLlCHe4psmMeY4FKp+7OPdOnCsUvHSIGS1+Jp1XwJYvyD9srOLKsmc7FPAiMC+u0CtrzTyofQOfwEZlNH9HoQ== aaron@holystone"
    ];
  };
}
