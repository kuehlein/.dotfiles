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
        "${darkReaderID}" = {
	  installation_mode = "normal_installed";
	  toolbar_pin = "force_pinned";
	  update_url = chromeExtensionClientURL;
	};
        "${laceWalletID}" = {
	  installation_mode = "normal_installed";
	  toolbar_pin = "force_pinned";
	  update_url = chromeExtensionClientURL;
	};
        "${protonPassID}" = {
	  installation_mode = "normal_installed";
	  toolbar_pin = "force_pinned";
	  update_url = chromeExtensionClientURL;
	};
      };
    };
  };
}
