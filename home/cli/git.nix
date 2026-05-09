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
      core.editor = "zeditor --wait";
      core.excludesFile = "~/.config/git/ignore";
    };
  };

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
