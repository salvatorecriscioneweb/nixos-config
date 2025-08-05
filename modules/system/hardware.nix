{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General.Experimental = true; # bluetooth percentage
      };
    };

    gpgSmartcards.enable = true;

    enableRedistributableFirmware = true;
  };
}
