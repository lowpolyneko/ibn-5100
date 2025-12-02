{ inputs, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    basedpyright
    direnv
    (discord.override {
      withVencord = true;
    })
    keka
    lf
    neovim
    obsidian
    ripgrep
    ruff
    tmux
    uv
    wezterm
  ];

  # Homebrew packages.
  homebrew = {
    enable = true;
    casks = [
      "deskflow"
      "proton-mail-bridge"
      "spotify"
    ];
  };

  # Set primary user.
  system.primaryUser = "ewong";

  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
