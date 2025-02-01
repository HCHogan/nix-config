{inputs, ...}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      theme = "${inputs.grub-catppuccin.outPath}/src/catppuccin-mocha-grub-theme";
    };
    efi = {
      efiSysMountPoint = "/efi";
      canTouchEfiVariables = true;
    };
  };
  boot.supportedFilesystems = ["ntfs"];
}
