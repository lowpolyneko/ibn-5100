{ inputs, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    basedpyright
    direnv
    (discord.override {
      withVencord = true;
    })
    firefox-bin
    keepassxc
    keka
    lf
    neovim
    obsidian
    podman
    podman-compose
    ripgrep
    ruff
    spotify
    syncthing-macos
    tmux
    uv
    wezterm
  ];

  # Homebrew packages.
  homebrew = {
    enable = true;
    taps = [
      "deskflow/tap"
    ];
    casks = [
      "deskflow"
      "displaylink"
      "proton-mail-bridge"
      "slack"
      "zoom"
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
