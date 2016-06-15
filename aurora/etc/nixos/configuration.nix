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

  nix.useChroot = true;

  environment.systemPackages = with pkgs; [
    fish
    git
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
      extraConfig =
        ''
        AllowGroups ssh
        '';
    };

    timesyncd.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  users.extraGroups.ssh.gid = 2200;

  users.extraUsers.abs = {
    uid = 1000;
    description = "Aaron Bull Schaefer";
    isNormalUser = true;
    extraGroups = [ "ssh" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9OLooFSF7LzE/kBBCNgQwMtpuLZB5vtdYJBbd+GiKyOHdnNkrtFR7TiSQCQE07u03Y21Q3i+WwxgoiNkA6QQuk7HAOrKJdE5L7SGdCQEGJPV+vF+mzbIN/btKC0Wlpv+LyfqVl377XRf2dZo9CHGAMfHBQoyR1R9IZ2BR3rzhVt3qbNZW9JpmXl7hqmoS6xVW4s8B/h4C53wCxayBzARuOBivGEWUG2rfHIwrZaFU8Oyz83UjKkpvI8v2Ih85gPmGtKLBPuNXPcVwKxvfYmFsiEbOZfkEBbH2ri+tBRM3gAvP3xzOoEKnlXa7z8TC9+paN+O+nf3gp9LTow+nHiqw5ejK+TxICI4ugEo+jJ8TrhztHvK5OudDp3vqsXcxPKN5ceLgxS3mVeioWtyiQphDeWskGMdxHtEIHZkrCBPPbhMCcjfPUYVeYjmp6PLHF+sebCKR1dnKa/U3qV4x24oVXLXoLOajYrg6l5TJcsC0cBfadUTqBL4L5mD8fqVtaRkjcSTsTh/dXDVgUN9aCsVySJTcxvKT8FKzkXCymndCt2rOvG9gXUeMbMsPhKaDeECJE3Imu8KKTYyKc+uAnSXwP9ss34H7U/yCgkbEzlCrajvPnyz9gzZWVkWIrBzWNFv4E6DqRao9QH6NOBPS23BxJa9B/SBLNPt6gWTeUyYGuw== aaron@halcyon"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDbnQMg9i3ZgBpiHRC5rtT4ohg8uIp+T67S59MAjnxwU23fTnhhShUA34lxpGi8ylR7QBjIMlRQ3Jzyvd2EwQWzd3t+2Z9GyCzGWdAR9RkHWDywL/6J4h97F5X0Du2yzTIV6aXQP3AghB9YTr+bkSRUZhmiizXql75nbtb1PAToBRG442TDNnIU48SKWZy5dzWv18pMPRAi0rGm0DOx7p+8ednTipzIA9vNUaOdxKIuAyS7qOiVRDB9IzvVWY/pUEvpksqAJwMUs8opwZDCct4dyqMbAwwxSVydGc3Byl+A4NG85pobKIbd6Yj2BXo+YcoeaAolDpfd+POWiPYMHzTcnGNYyg/mB/FdunNIm5J1tLAovp0ejozVxsKjGJfTOWtbNxyQsqDhO9YWlSa3DA4r4LGSrAVEgJvxwQ7mFXyfjolqxIONrA1EBxsTRUNrGJob01dUkhvLkUmRClgLcRJ4zHk9Y9YQOEpBn1bac3+6o2ZcPF5vIUyZ5se/EfMJEr8LcEcwokGm5xSeW9MjDE0yDmYxpYVpzQrBZEjPppRFpgismHhmMT5Vl72iPfi55zxSKE/i8xhNPWWTJrQBSFoWnKeH01z8FyIiCu82zssrpN2kX4V0XmWEAG+c2UFvN2TjoPSxOPs29WRQmwABs9Xpf1UFQwdTc8fMN8EGHkhrVw== aaron@holystone"
    ];
  };
}
