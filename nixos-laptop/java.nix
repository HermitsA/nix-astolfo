{ config, pkgs, ... }:

let
  jdkEnv = pkgs.runCommand "jdk-env" {
    buildInputs = with pkgs; [
      pkgs.openjdk17
      pkgs.openjdk21
      pkgs.temurin-bin-17
      pkgs.temurin-bin-21
    ];
 } ''
    mkdir -p $out/jdks
    ln -s ${pkgs.openjdk17}/lib/openjdk   $out/jdks/openjdk17
    ln -s ${pkgs.openjdk21}/lib/openjdk   $out/jdks/openjdk21
    ln -s ${pkgs.temurin-bin-17}          $out/jdks/temurin17
    ln -s ${pkgs.temurin-bin-21}          $out/jdks/temurin21
  '';
in {
  environment.pathsToLink = [ "/jdks" ];

  environment.systemPackages = [
    # to get /run/current-system/sw/jdks/ populated
    jdkEnv

    # to default java binaries to highest version (instead of 8 or something)
    pkgs.temurin-bin
  ];

  system.activationScripts.jdkSymlinks.text = ''
    mkdir -p /opt
    chmod 755 /opt

    ln -sfT /run/current-system/sw/jdks /opt/java
  '';
}
