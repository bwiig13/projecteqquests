my %suffix_to_pretty_name = (
    'A' => 'Antonica',
    'G' => 'Gunthak',
    'O' => 'Odus',
    'F' => 'Faydwer',
    'K' => 'Kunark',
    'V' => 'Velious',
    'L' => 'Luclin',
    'P' => 'Planes',
    'T' => 'Taelosia',
    'D' => 'Discord',
);

sub get_suffixes {
    return ('A', 'G', 'O', 'F', 'K', 'V', 'L', 'P', 'T', 'D'); 
}

sub get_portal_destinations {
    return {
        10092   => ['The Plane of Hate', 666, 186, -393, 656, 3],
        10094   => ['The Plane of Sky', 674, 71, 539, 1384, -664],
        876000  => ['The Northern Plains of Karana', 2708, 13, 1209, -3685, -5],
        876001  => ['East Commonlands', 4176, 22, -140, -1520, 3],
        876002  => ['The Lavastorm Mountains', 534, 27, 460, 460, -86],
        876003  => ['Toxxulia Forest', 2707, 38, -916, -1510, -33],
        876004  => ['The Greater Faydark', 2706, 54, -441, -2023, 4],
        876005  => ['The Dreadlands', 2709, 86, 9658, 3047, 1052],
        876006  => ['The Iceclad Ocean', 2284, 110, 385, 5321, -17],
        876007  => ['Cobalt Scar', 2031, 117, -1634, -1065, 299],
        876009  => ['The Twilight Sea', 3615, 170, -1028, 1338, 39],
        876010  => ['Stonebrunt Mountains', 3794, 100, 673, -4531, 0],
        876011  => ['Wall of Slaughter', 6180, 300, -943, 13, 130],
        976016  => ['Barindu, Hanging Gardens', 5733, 283, 590, -1457, -123],
        88739   => ['The Plane of Time', 20543, 219, 0, 110, 8],
        976015  => ['Field of Bone', 11178, 78, 2802, 1194, -7],
        976014  => ['Western Wastes', 111120, 120, 2307, 889, -21],
        976013  => ['Scarlet Desert', 111175, 175, -1777, -956, -99],
        976010  => ['Everfrost', 11130, 30, 590, -791, -54],
    };
}

sub set_default_attunement {
    my ($accountID, $raceID) = @_;     
    
    my %default_attunements = (
        1 => [
            ["North Qeynos", ['qeynos2', 392.0, 165.0, 2.75, 310], 'A'],
            ["West Freeport", ['freportw', -396, -283, -23, 500], 'A'],
        ],
        2 => [
            ["Halas", ['halas', 0, 26, 3.75, 256], 'A'],
            ["North Qeynos", ['qeynos2', 392.0, 165.0, 2.75, 310], 'A'],
        ],
        3 => [
            ["Erudin", ['erudnext', -240.0, -1216.0, 52.0, 510.0], 'O'],
            ["Paineel", ['paineel', 553, 746, -118.20, 0], 'O'],
        ],
        4 => [
            ["The Greater Faydark (Kelethin)", ['gfaydark', -175, -50, 77.72, 87], 'F'],
        ],
        5 => [
            ["Northern Felwithe", ['felwithea', -626, 240, -10.25, 330], 'F'],
        ],
        6 => [
            ["Neriak - Commons", ['neriakb', -498, -3, -10, 128], 'A'],
            ["West Freeport", ['freportw', -396, -283, -23, 500], 'A'],
        ],
        7 => [
            ["The Greater Faydark (Kelethin)", ['gfaydark', -175, -50, 77.72, 87], 'F'],
            ["North Qeynos", ['qeynos2', 392.0, 165.0, 2.75, 310], 'A'],
            ["West Freeport", ['freportw', -396, -283, -23, 500], 'A'],
        ],
        8 => [
            ["South Kaladim", ['kaladima', 197, 90, 3.75, 492], 'F'],
            ["The Greater Faydark (Kelethin)", ['gfaydark', -175, -50, 77.72, 87], 'F'],
        ],
        9 => [
            ["Grobb", ['grobb', -200, 223, 3.75, 414], 'A'],
            ["Neriak - Commons", ['neriakb', -498, -3, -10, 128], 'A'],
        ],
        10 => [
            ["Oggok", ['oggok', 513, 465, 3.75, 205], 'A'],
            ["Neriak - Commons", ['neriakb', -498, -3, -10, 128], 'A'],
        ],
        11 => [
            ["Rivervale", ['rivervale', -140, -10, 3.75, 220], 'A'],
        ],
        12 => [
            ["Ak'Anon", ['akanon', -761, 1279, -24.25, 182.25], 'F'],
            ["South Kaladim", ['kaladima', 197, 90, 3.75, 492], 'F'],
        ],
        128 => [
            ["Cabilis East", ['cabeast', -136, 969, 4.68, 271], 'K'], 
        ],
        330 => [
            ["North Qeynos", ['qeynos2', 392.0, 165.0, 2.75, 310], 'A'],
            ["The Greater Faydark (Kelethin)", ['gfaydark', -175, -50, 77.72, 87], 'F'],
            ["Halas", ['halas', 0, 26, 3.75, 256], 'A'],
        ],   
    );

   
    if (exists $default_attunements{$raceID}) {        
        foreach my $attunement (@{$default_attunements{$raceID}}) {            
            my ($zoneDesc, $locData, $suffix) = @$attunement;            
            plugin::add_zone_entry($accountID, $zoneDesc, $locData, $suffix);
        }
    }
}


sub get_continent_by_suffix {
    my ($suffix) = @_;  

    return $suffix_to_pretty_name{$suffix} || $suffix;
}

sub get_suffix_by_continent {
    my ($continent) = @_;
    
    my %suffix_by_continent;
    foreach my $suffix (keys %suffix_to_pretty_name) {
        my $pretty_name = $suffix_to_pretty_name{$suffix};
        $suffix_by_continent{$pretty_name} = $suffix;
    }

    return $suffix_by_continent{$continent} || $continent;
}

# Get a map of zone data for each suffix
sub get_zone_data {
    my ($accountID) = @_;
    my %zone_data_by_suffix;

    foreach my $suffix (get_suffixes()) {
        my $teleport_zones = get_zone_data_for_account($accountID, $suffix);
        $zone_data_by_suffix{$suffix} = $teleport_zones;
    }

    return \%zone_data_by_suffix;
}

sub get_flat_data {
    my ($accountID) = @_;
    my %all_elements;

    # Get the nested hashes from get_zone_data
    my $zone_data = get_zone_data($accountID);

    foreach my $suffix (keys %{$zone_data}) {
        my $teleport_zones = $zone_data->{$suffix};

        foreach my $key (keys %{$teleport_zones}) {
            $all_elements{$key} = $teleport_zones->{$key};            
        }
    }

    return \%all_elements;
}

# Check if a particular piece of data (by zone description) is present
sub has_zone_entry {
    my ($accountID, $zone_desc, $suffix) = @_;
    my $teleport_zones = get_zone_data_for_account($accountID, $suffix);

    return exists($teleport_zones->{$zone_desc});
}

# Get character's saved zone data
sub get_zone_data_for_account {
    my ($accountID, $suffix) = @_;
    my $charKey = $accountID . "-TL-Account-" . $suffix;

    my $charDataString = quest::get_data($charKey);

    my %teleport_zones;
    my @zone_entries = split /:/, $charDataString;

    foreach my $entry (@zone_entries) {
        my @tokens = split /\+/, $entry;
        $teleport_zones{$tokens[0]} = [@tokens[1..$#tokens]];
    }

    return \%teleport_zones;
}

# Add (or overwrite) data to teleport_zones
# Usage:
#    add_zone_entry(12345, "Zone4", ['data7', 'data8'], '-K');
sub add_zone_entry {
    my ($accountID, $zone_name, $zone_data, $suffix) = @_;
    my $teleport_zones = get_zone_data_for_account($accountID, $suffix);
    $teleport_zones->{$zone_name} = $zone_data;
    set_zone_data_for_account($accountID, $teleport_zones, $suffix);
}

sub set_zone_data_for_account {
    my ($accountID, $zone_data_hash_ref, $suffix) = @_;
    my $charKey = $accountID . "-TL-Account-" . $suffix;

    my @data_entries;

    while (my ($desc, $zone_data) = each %{$zone_data_hash_ref}) {
        my $entry = join("+", $desc, @{$zone_data});
        push @data_entries, $entry;
    }

    my $charDataString = join(":", @data_entries);

    quest::set_data($charKey, $charDataString);
}