sub EVENT_SPAWN {
    $x = $npc->GetX();
    $y = $npc->GetY();
    $z = $npc->GetZ();

    quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50);
}

sub EVENT_ENTER {    
    quest::debug("Attempting to update attunement point...");

    my @tokens = split /:/, $npc->GetLastName();
    my $suffix = $tokens[0];
    my $accountID   = $client->AccountID();

    my $TLDesc = "";
    if (!$tokens[1] || $tokens[1] eq "") {
        $TLDesc = quest::GetZoneLongNameByID($npc->GetZoneID());
    } else {
        $TLDesc = quest::GetZoneLongNameByID($npc->GetZoneID()) . " " . $tokens[1];
    }

    # Use $TLDesc as key and structure our data with zone short name, coordinates, and heading
    my $locData = [quest::GetZoneShortName($npc->GetZoneID()), $npc->GetX(), $npc->GetY(), $npc->GetZ(), $npc->GetHeading()];

    if (!plugin::has_zone_entry($accountID, $TLDesc, $suffix) && !($suffix eq "")) {
        quest::message(15, "This place seems familiar. You are sure to remember it later.");
        quest::ding();

        # Adding the new attunement location to the character's data
        plugin::add_zone_entry($accountID, $TLDesc, $locData, $suffix);

    } elsif ($suffix eq "") {
        quest::debug("Configuration Error.");
    }    
}