{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };
  i18n.inputMethod.fcitx5 = {
    waylandFrontend = true;
    addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-mozc
      fcitx5-gtk #  Fcitx5 gtk im module and glib based dbus client library
      fcitx5-material-color
    ];
    settings = {
      addons = {
        classicui.globalSection.Theme = "Material-Color-deepPurple";
        classicui.globalSection.DarkTheme = "Material-Color-deepPurple";
        # pinyin.globalSection = {
        #   PageSize = 9;
        #   CloudPinyinEnabled = "True";
        #   CloudPinyinIndex = 2;
        # };
        # cloudpinyin.globalSection = {
        #   Backend = "Baidu";
        # };
      };
      #globalOptions = { "Hotkey/TriggerKeys" = { "0" = "Alt+space"; }; };
      inputMethod = {
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "keyboard-us";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "shuangpin";
        GroupOrder."0" = "Default";
      };
    };
  };
}
