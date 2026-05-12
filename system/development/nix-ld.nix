{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      curl
      glib
      libxml2
      libxslt
      libGL
      fuse
      icu
      nspr
      nss
      libnotify
      cups
    ];
  };
}