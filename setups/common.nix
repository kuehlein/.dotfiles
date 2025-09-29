{ config, pkgs, ... }: let
  chromeExtensionClientURL = "https://clients2.google.com/service/update2/crx";
in {
  environment = {
    # Install chrome extensions in Brave
    etc."brave/policies/managed/policies.json".text = builtins.toJSON {
      ExtensionInstallForceList = {
        "eimadpbcbfnmbkopoojfekhnkhdbieeh;${chromeExtensionClientURL}" # Dark Reader
        "gafhhkghbfjjkeiendhlofajokpaflmk;${chromeExtensionClientURL}" # Lace Wallet
        "ondecobpcidaehknoegeapmclapnkgcl;${chromeExtensionClientURL}" # JSON Viewer
        "ghmbeldphafepmbegfdlkpapadhbakde;${chromeExtensionClientURL}" # Proton Pass
      };
    };

    systemPackages = with pkgs; [ waybar ];
  };
}
