{ pkgs, lib, ... }:

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

  home.activation.generateGitHubSSHKey =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      KEY="$HOME/.ssh/id_ed25519_github"
      if [ ! -f "$KEY" ]; then
        mkdir -p "$HOME/.ssh"
        ${pkgs.openssh}/bin/ssh-keygen -t ed25519 \
          -C "amauribsjunior@proton.me" \
          -f "$KEY" -N ""
        cat "$KEY.pub" > "$HOME/github-ssh-key.txt"
        echo ""
        echo "  New SSH key generated:"
        echo "  Public key saved to ~/github-ssh-key.txt"
        echo "  Copy it to: https://github.com/settings/ssh/new"
        cat "$KEY.pub"
      fi
    '';
}
