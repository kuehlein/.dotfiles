{ config, pkgs, ... }: let
  chromeExtensionClientURL = "https://clients2.google.com/service/update2/crx";

  darkReaderID = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
  jsonViewerID = "ondecobpcidaehknoegeapmclapnkgcl";
  laceWalletID = "gafhhkghbfjjkeiendhlofajokpaflmk";
  protonPassID = "ghmbeldphafepmbegfdlkpapadhbakde";
in {
  environment = {
    etc."brave/policies/managed/policies.json".text = builtins.toJSON {
      BraveRewardsDisabled = true;
      BraveTalkDisabled = true;
      ExtensionInstallForcelist = [
        "${darkReaderID};${chromeExtensionClientURL}"
        "${jsonViewerID};${chromeExtensionClientURL}"
        "${laceWalletID};${chromeExtensionClientURL}"
        "${protonPassID};${chromeExtensionClientURL}"
      ];
      ExtensionSettings = {
        "${darkReaderID}" = { toolbar_pin = "force_pinned"; };
        "${laceWalletID}" = { toolbar_pin = "force_pinned"; };
        "${protonPassID}" = { toolbar_pin = "force_pinned"; };
      };
    };
  };
}
