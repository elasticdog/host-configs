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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDzBGmg7fI+H7WfJWhSdRUo3nRcEpv3qvqmoMvucGkwxfIlEFN5swH1bodmIq0m2OznoNPV4b2A/++x8R4VqgPPK5VZabH6eRiJWM3IC3Cb2vmgaOsss8NgNxKQ2I3hUWmTHh6P+vkMP13VrS8ZI8TaZSpqiTOg2KTLllHp7hHwkhhhYF98iWT+pu89A22sYP0dXBX/h9KnAfGEn1uyOuHgi4rnU9OG9rN62LWA1sUkQv3KDW7muS+asHp45w9h8sB+gdR4Q3aPPcjEajQXQGqDvtuh9D/QbE+0zGI/VSTLjPradO8gHfi9sHNIY7x9GW/bdNHuQvn5QpiayHviVRuRp8xaRT/XXCeToLY2wbHPzFoxVKLd4um5Ytlxl2TS0R2hudMYoNthfzfNe99ch4TIj1MGXirIpOIddRPS70TvSgCph9CAdPAPRUG5xbR+zECxl+f41aj0CzkeJxJetyHP2/yZXUvw3ddPIaQcNpW5Fuy2jeSz0Tr5ptU3/iH5XvXhA6ucBAqUJJSJoIcxoFkSQ8XDiwLUSty7G6e6PBJKOBJVZS78pBKlxJuhtkssyhG+w1Sjx42QnEM6dgsjZgv3R9f3kTUQ7YKxQZop9++ct8NOVPdX42mA1WV9YOTEWfM84FiQLayJKnBxR8MHmSSFGJSG5K+OwOUIWfPDkv64+Q== aaron@holystone"
    ];
  };
}
