{ pkgs, homeDirectory, ... }: {
  home-manager.enable = true;

  zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
    };

    history = {
      size = 10000;
      path = "${homeDirectory}/var/lib/zsh/history";
    };
  };

  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
