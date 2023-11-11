{ pkgs }:

 pkgs.stdenv.mkDerivation {
 name =  "tokyo-night-sddm";
 src = pkgs.fetchFromGitHub {
 owner = "rototrash";
 repo = "tokyo-night-sddm";
 rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
 sha256 = "1gf074ypgc4r8pgljd8lydy0l5fajrl2pi2avn5ivacz4z7ma595";
 
};

 installPhase = ''
 mkdir -p $out
 cp -R ./* $out/
 '';

}
