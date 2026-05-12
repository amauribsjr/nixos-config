{ pkgs, ... }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "13.0";
    platformToolsVersion = "35.0.2";
    buildToolsVersions = [ "35.0.0" ];
    platformVersions = [ "35" ];
    includeEmulator = false;
    includeSystemImages = false;
    includeSources = false;
    includeNDK = false;
  };

  androidSdk = androidComposition.androidsdk;
in
{
  environment.systemPackages = with pkgs; [
    flutter
    jdk17
    androidSdk
    android-tools
  ];

  environment.variables = {
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    JAVA_HOME = pkgs.jdk17.home;
  };

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };
}
