{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "Bombay_Desk";
          outputs = [
            {
              criteria = "DP-3";
              mode = "2560x1600@75Hz";
              scale = 1.15;
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        };
      }
      {
        profile = {
          name = "Undocked";
          outputs = [
            {
              criteria = "eDP-1";
              adaptiveSync = true;
              status = "enable";
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
              status = "disable";
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
