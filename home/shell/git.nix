{ ... }:

{
  programs.git = {
    enable = true;
    signing.format = null;

    settings = {
      user.name  = "amauribsjr";
      user.email = "amauribsjunior@proton.me";

      init.defaultBranch   = "main";
      pull.rebase          = true;
      push.autoSetupRemote = true;
      push.default         = "current";
      fetch.prune          = true;
      rerere.enabled       = true;
      diff.colorMoved      = "default";
      merge.conflictStyle  = "zdiff3";
      core.editor          = "zeditor --wait";
      feature.manyFiles    = true;

      "url \"git@github.com:amauribsjr/\"".insteadOf = "https://github.com/amauribsjr/";

      alias = {
        st       = "status -sb";
        co       = "checkout";
        br       = "branch";
        ci       = "commit";
        lg       = "log --graph --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)(%cr)%C(reset) %C(blue)<%an>%C(reset)%C(green)%d%C(reset)' --abbrev-commit";
        undo     = "reset --soft HEAD~1";
        amend    = "commit --amend --no-edit";
        uncommit = "reset HEAD~";
        diffc    = "diff --cached";
        wip      = "commit -am 'wip'";
      };
    };

    ignores = [
      "result"
      "result-*"
      ".direnv"
      ".envrc.local"
      "*.swp"
      ".DS_Store"
      "target/"
      "node_modules/"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate     = true;
      line-numbers = true;
      side-by-side = false;
      syntax-theme = "gruvbox-dark";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showFileTree     = true;
        showCommandLog   = false;
        nerdFontsVersion = "3";
        theme = {
          activeBorderColor   = [ "#d9bb6a" "bold" ];
          inactiveBorderColor = [ "#7c6f64" ];
          selectedLineBgColor = [ "#3c3836" ];
        };
      };
      git.paging = {
        colorArg = "always";
        pager    = "delta --paging=never";
      };
    };
  };
}