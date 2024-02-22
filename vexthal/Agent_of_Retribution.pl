my $expedition_name = "Vex Thal";
my $min_players     = 1;
my $max_players     = 72;
my $dz_zone         = "vexthal";
my $dz_version      = 0;
my $dz_duration     = 172800; # 48 hours

sub EVENT_SAY {
  if ($text =~ /hail/i) {
    my $dz = $client->GetExpedition();
    if ($dz && $dz->GetName() eq $expedition_name) {
      quest::say("Tell me when you're [" . quest::saylink("ready") . "] to enter");
    }
    else {
      quest::say("Would you like to [" . quest::saylink("request") . "] the expedition?");
    }
  }
  elsif ($text =~ /request/i) {
    my $dz = $client->CreateExpedition($dz_zone, $dz_version, $dz_duration, $expedition_name, $min_players, $max_players);
    if ($dz) {
      $dz->SetCompass("vexthal", -350, -350, 0); # pointing to guard pineshade
      $dz->SetSafeReturn("vexthal", -50, 50, 0, 150);
      $dz->SetZoneInLocation(-1655, 257, -39.75, 0);
      $dz->AddReplayLockout(79200); # immediately add a 22 hour replay lockout on creation
      quest::say("Tell me when you're [" . quest::saylink("ready") . "] to enter");
    }
  }
  elsif ($text =~ /ready/i) {
    $client->MovePCDynamicZone("vexthal");
  }
}