{ ... }:

{
  programs.git = {
    enable = true;
    signing.format = null;
    settings = {
      user.name = "amauribsjr";
      user.email = "amauribsjunior@proton.me";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core.editor = "vim";
      core.excludesFile = "~/.config/git/ignore";
    };
  };

  home.file.".config/git/ignore".text = ''
    .envrc
    .direnv/
  '';

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519_github";
      identitiesOnly = true;
    };
  };
}
