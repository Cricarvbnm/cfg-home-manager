{ ... }: {
  programs = {
    git = {
      enable = true;
      includes = [{ path = ./gitconfig; }];
    };

    # For better git diff
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
