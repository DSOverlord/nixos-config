{
  home-manager.sharedModules = [{
    programs.chromium = {
      extensions = [
        # { id = "kioklelcojgbjoljlilalgdcppkiioge"; } # Theme
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock Origin
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
        { id = "npgcnondjocldhldegnakemclmfkngch"; } # VPN
        { id = "gebbhagfogifgggkldgodflihgfeippi"; } # Return Youtube Dislike
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
      ];
      commandLineArgs = [
        "--disable-smooth-scrolling"
        "--disable-sync-preferences"
      ];
    };
  }];
}
