{ lib, config, pkgs, ... }:


let
  pkgs_category = {
    terminal = [
      pkgs.zsh # TODO: Set default set for user
      pkgs.antibody
      pkgs.spaceship-prompt
      pkgs.bat
    ];
    container_tools = [
      pkgs.dive
      pkgs.podman
      pkgs.buildah
      pkgs.skopeo
      pkgs.slirp4netns
    ];
    programming_languages = [
      pkgs.julia-stable-bin
    ];
    fun_tools = [
      pkgs.bettercap
      pkgs.hey
    ];
    dev_tools = [
      # GO;
      pkgs.golangci-lint # TODO: set your custom .golangci-lint rules file
      # EDITOR
      pkgs.neovim-nightly
      pkgs.neovim-remote
      pkgs.neovim-qt
    ];
    # NOTICE: try not to add much of desktop files since we still use arch dependencies most of the time
    desktop = [
      #pkgs.neovide
      #pkgs.j4-dmenu-desktop
      #pkgs.zathura
      #pkgs.alacritty
      #pkgs.kitty
    ];
  };
in
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pwyll";
  home.homeDirectory = "/home/pwyll";

  imports = [
    ../nixpkgs/overlays/neovim-nightly.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  home.packages = pkgs_category.terminal ++
  pkgs_category.programming_languages ++
  pkgs_category.dev_tools ++
  pkgs_category.desktop ++
  pkgs_category.container_tools ++
  pkgs_category.fun_tools ++
  [
    #pkgs.albert
  ];

  programs.git = {
    enable = false; # TODO: Make sure you move all your home .gitconfig first
    userEmail = "rafedramzi@gmail.com";
    userName = "Rafed Ramzi";
    signing  = {
      signByDefault = true;
      key = "rafedramzi@gmail.com";
    };

    delta = {
      enable = true;
    };
  };

  programs.vscode = {
    # TODO wait for list exnteison and config, many tings todo here! :)
    enable = false;
    package = pkgs.vscode-insiders;
    extensions = [

    ];

  };
}
