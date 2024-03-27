let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINgelIkiWmwGTm8XYOslBpciD2pChg8KaDowf3vYFAtI";
  user2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPzVkdCiR9wr1g7HYVNDf0hfZ/p4vzo8GZL3G/nnRBT9";
  users = [ user1 user2 ];

  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGBZHfcK1z1qNFNkOfQnZSyP4Ar7GN7Q+AR7PJMif6Os";
  system2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlV1hv6IB+TjSXHWo6eHqstk/tyuQZMS+AwcTEr4KEK";
  systems = [ system1 system2 ];
in
{
  "password.age".publicKeys = users ++ systems;
  "git-credentials.age".publicKeys = users ++ systems;
  "nix-access-tokens.age".publicKeys = users ++ systems;
}
