{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "amauribsjr";
    userEmail = "amauribsjunior@proton.me";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core.editor = "vim";
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519_github";
      identitiesOnly = true;
    };
  };

  home.activation.generateGitHubSSHKey =
    let
      inherit (pkgs) lib;
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      KEY="$HOME/.ssh/id_ed25519_github"
      if [ ! -f "$KEY" ]; then
        mkdir -p "$HOME/.ssh"
        ${pkgs.openssh}/bin/ssh-keygen -t ed25519 \
          -C "amauribsjunior@proton.me" \
          -f "$KEY" -N ""
        echo ""
        echo "═══════════════════════════════════════════════════"
        echo "  NEW SSH KEY GENERATED!"
        echo "  Copy the public key below to GitHub:"
        echo "  https://github.com/settings/ssh/new"
        echo "═══════════════════════════════════════════════════"
        echo ""
        cat "$KEY.pub"
        echo ""
        echo "═══════════════════════════════════════════════════"
      fi
    '';
}