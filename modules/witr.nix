{ pkgs, ... }:
  let
    homepage = "https://github.com/pranshuparmar/witr";
    witr = pkgs.stdenv.mkDerivation rec {
      pname = "witr";
      version = "0.1.0";

      src = pkgs.fetchurl {
        url = "${homepage}/releases/download/v${version}/witr-linux-amd64";
        sha256 = "sha256-SsJ/7LaoVh4X1KZZJrjLA27enZyHbFEl8em5I0DE6JM=";
      };

      dontBuild = true;
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/witr
        chmod +x $out/bin/witr
      '';

      meta = with pkgs.lib; {
        description = "Why is this running? - Process causality explainer";
        homepage = homepage;
        license = licenses.asl20;
        platform = [ "x86_64-linux" ];
      };
    };
  in {
    environment.systemPackages = [ witr ];
  }
