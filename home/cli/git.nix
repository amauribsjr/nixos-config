{ ... }:

{
  programs.git = {
    enable = true;
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
    settings."github.com" = {
      Hostname = "github.com";
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519_github";
      IdentitiesOnly = true;
    };
  };
}