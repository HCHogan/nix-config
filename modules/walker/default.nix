{hostname, ...}: {
  programs.walker = {
    enable = (hostname == "b660");
    runAsService = true;

    # All options from the config.json can be used here.
    config = {
      # search.placeholder = "Example";
      ui.fullscreen = false;
      list = {
        height = 200;
      };
      websearch.prefix = "?";
      switcher.prefix = "/";
    };
  };
}
