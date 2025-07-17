{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "Undocked";
          outputs = [
            {
              criteria = "eDP-1";
              adaptiveSync = true;
            }
          ];
        };
      }
      {
        profile = {
          name = "Docked_ultrawide";
          outputs = [
            {
              criteria = "eDP-1";
              position = "700,1440";
              adaptiveSync = true;
            }
            {
              criteria = "Samsung Electric Company S34C65xU HNBWA01568";
              position = "0,0";
            }
          ];

        };
      }
      {
        profile = {
          name = "Docked_small";
          outputs = [
            {
              criteria = "eDP-1";
              position = "400,1440";
              adaptiveSync = true;
            }
            {
              criteria = "Lenovo Group Limited LEN P27h-10 0x30585944";
              position = "0,0";
            }
          ];

        };
      }
    ];
  };
}
