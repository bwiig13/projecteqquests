#Some Constants
my $BERSERKER = 16;
my $BEASTLORD = 15;
my $IKSAR     = 128;
my $VAH_SHIR  = 130;
my $DRAKKIN   = 522;
my $GUKTAN    = 330;

my %atlas = (
    'cabeast'        => 'RoK',
    'cabwest'        => 'RoK',
    'burningwood'    => 'RoK',
    'dreadlands'     => 'RoK',
    'emeraldjungle'  => 'RoK',
    'fieldofbone'    => 'RoK',
    'firiona'        => 'RoK',
    'lakeofillomen'  => 'RoK',
    'swampofnohope'  => 'RoK',
    'timorous'       => 'RoK',
    'trakanon'       => 'RoK',
    'warslikswood'   => 'RoK',
    'chardok'        => 'RoK',
    'citymist'       => 'RoK',
    'dalnir'         => 'RoK',
    'charasis'       => 'RoK',
    'kaesora'        => 'RoK',
    'kurn'           => 'RoK',
    'nurga'          => 'RoK',
    'droga'          => 'RoK',
    'sebilis'        => 'RoK',

    'cobaltscar'     => 'SoV',
    'crystal'        => 'SoV',
    'necropolis'     => 'SoV',
    'eastwastes'     => 'SoV',
    'greatdivide'    => 'SoV',
    'iceclad'        => 'SoV',
    'kael'           => 'SoV',
    'sleeper'        => 'SoV',
    'growthplane'    => 'SoV',
    'mischiefplane'  => 'SoV',
    'sirens'         => 'SoV',
    'templeveeshan'  => 'SoV',
    'thurgadina'     => 'SoV',
    'thurgadinb'     => 'SoV',
    'frozenshadow'   => 'SoV',
    'wakening'       => 'SoV',
    'westwastes'     => 'SoV',

    'acrylia'        => 'SoL',
    'akheva'         => 'SoL',
    'dawnshroud'     => 'SoL',
    'echo'           => 'SoL',
    'fungusgrove'    => 'SoL',
    'griegsend'      => 'SoL',
    'hollowshade'    => 'SoL',
    'netherbian'     => 'SoL',
    'paludal'        => 'SoL',
    'sseru'          => 'SoL',
    'scarlet'        => 'SoL',
    'shadeweaver'    => 'SoL',
    'shadowhaven'    => 'SoL',
    'sharvahl'       => 'SoL',
    'ssratemple'     => 'SoL',
    'thedeep'        => 'SoL',
    'thegrey'        => 'SoL',
    'tenebrous'      => 'SoL',
    'twilight'       => 'SoL',
    'umbral'         => 'SoL',
    'vexthal'        => 'SoL',
    'nexus'          => 'SoL',

    'poknowledge'    => 'PoP',
    'potranquility'  => 'PoP',
    'ponightmare'    => 'PoP',
    'nightmareb'     => 'PoP',
    'podisease'      => 'PoP',
    'poinnovation'   => 'PoP',
    'pojustice'      => 'PoP',
    'postorms'       => 'PoP',
    'povalor'        => 'PoP',
    'potorment'      => 'PoP',
    'codecay'        => 'PoP',
    'hohonora'       => 'PoP',
    'hohonorb'       => 'PoP',
    'bothunder'      => 'PoP',
    'potactics'      => 'PoP',
    'solrotower'     => 'PoP',
    'pofire'         => 'PoP',
    'poair'          => 'PoP',
    'powater'        => 'PoP',
    'poeartha'       => 'PoP',
    'poearthb'       => 'PoP',
    'potimea'        => 'PoP',
    'potimeb'        => 'PoP',
    'veeshan'        => 'PoP', # Out of Era
);

# Global hash of valid stages
my %VALID_STAGES = map { $_ => 1 } qw(RoK SoV SoL PoP GoD OoW DoN);

# Global hash of stage prerequisites
my %STAGE_PREREQUISITES = (
    'RoK' => ['Lord Nagafen', 'Lady Vox'],  # Objectives with spaces
    'SoV' => ['Trakanon', 'Gorenaire', 'Severilous', 'Talendor'],
    'SoL' => ['Lord Yelinak', 'Tukaarak the Warder', 'Nanzata the Warder', 'Ventani the Warder', 'Hraasha the Warder', 'Wuoshi', 'Klandicar', 'Zlandicar'],
    'PoP' => ['Thought Horror Overfiend', 'The Insanity Crawler', 'Greig Veneficus', 'Xerkizh the Creator', 'Emperor Ssraeshza'],
    'GoD' => ['Quarm'],
    # ... and so on for each stage
);

# Breakpoints for original flagging system:
# Kunark: 2
# Velious: 3
# Luclin: 14
# Planes of Power: 19
# 'Fabled Classic'/Quarm-Kill: 20

# The new data structure will be independent flag variables for each stage, ie AccountID-progress-flag-RoK
# This is stored as a serialized hash using plugin::SerializeHash and plugin::DeserializeHash
# set_subflag does all the heavy lifting of setting flags

sub get_subflag {
    my ($client, $stage, $objective) = @_;

    my %flag = plugin::DeserializeHash(quest::get_data($client->AccountID() . "-progress-flag-$stage"));

    return $flag{$objective};
}

#usage plugin::set_subflag($client, 'Rok', 'Lord Nagafen', 1); flags $client for Lord Nagafen in RoK stage.
sub set_subflag {
    my ($client, $stage, $objective, $value) = @_;
    $value //= 1; # Default value is 1 if not otherwise defined

    # Check if the stage is valid
    return 0 unless exists $VALID_STAGES{$stage};

    # Deserialize the current account progress into a hash
    my %account_progress = plugin::DeserializeHash(quest::get_data($client->AccountID() . "-progress-flag-$stage"));

    # Update the flag
    $account_progress{$objective} = $value;

    # Serialize and save the updated account progress
    quest::set_data($client->AccountID() . "-progress-flag-$stage", plugin::SerializeHash(%account_progress));

    plugin::YellowText("You have gained a progression flag!");
    $client->Message(263, "Your memories become more clear, you see the way forward drawing closer.");

    # Check if the stage is now complete
    if (is_stage_complete($client, $stage)) {
        if ($stage eq 'RoK' && $client->GetBucket("CharMaxLevel") == 51) {
            $client->SetBucket("CharMaxLevel", 60);
        }

        if ($stage eq 'PoP' && $client->GetBucket("CharMaxLevel") == 60) {
            $client->SetBucket("CharMaxLevel", 65);
        }

        if ($stage eq 'GoD' && $client->GetBucket("CharMaxLevel") == 65) {
            $client->SetBucket("CharMaxLevel", 70);
        }

        plugin::YellowText("You have completed a progression stage!");
    }

    return 1;
}

# Returns 1 if the client has completed all objectives needed to unlock the indicated stage
# Optional final parameter is used to inform player if they fail the check
# Example; is_stage_complete($client, 'SoL') == 1 indicates that the player has unlocked access to Luclin.
sub is_stage_complete {
    my ($client, $stage, $inform) = @_;
    $inform //= 0; # Set to 0 if not defined

    quest::debug("Checking if stage is complete: $stage");

    # Return false if the stage is not valid
    unless (exists $VALID_STAGES{$stage}) {
        quest::debug("Invalid stage: $stage");
        return 0;
    }
    quest::debug("Valid Stage: $stage");

    # Check prerequisites
    foreach my $prerequisite (@{$STAGE_PREREQUISITES{$stage}}) {
        my %objective_progress = plugin::DeserializeHash(quest::get_data($client->AccountID() . "-progress-flag-$stage"));

        unless ($objective_progress{$prerequisite}) {
            quest::debug("Prerequisite not met: $prerequisite");
            if ($inform) {
                 $client->Message(263, "You are not yet ready to experience that memory.");
            }
            return 0;
        }
        quest::debug("Prerequisite met: $prerequisite");
    }

    # If all prerequisites are met
    quest::debug("All prerequisites for stage $stage have been met");
    return 1;
}


sub is_eligible_for_race {
    my $client = shift;
    my $race   = shift // $client->GetRace();

    # Iksar
    if ($race == $IKSAR && !is_stage_complete($client, 'RoK')) {
        return 0;
    }

    # Vah Shir
    if ($race == $VAH_SHIR && !is_stage_complete($client, 'SoL')) {
        return 0;
    }

    # Drakkin
    if ($race == $DRAKKIN) {
        return 0;
    }

    # Guktan
    if ($race == $GUKTAN) {
        return 0;
    }

    return 1;
}

sub is_eligible_for_class {
    my $client = shift;
    my $class  = shift // $client->GetClass();

    if ($class == $BEASTLORD && !is_stage_complete($client, 'PoP')) {
        return 0;
    }

    # Vah Shir
    if ($class == $BERSERKER && !is_stage_complete($client, 'SoL')) {
        return 0;
    }

    return 1;
}

sub is_eligible_for_zone {
    my ($client, $zone_name, $inform) = @_;    
    $inform //= 0; # Set to 0 if not defined

    # Check if the zone exists in the atlas
    if (exists $atlas{$zone_name}) {
        # Use is_stage_complete to check if the client has completed the required stage
        return is_stage_complete($client, $atlas{$zone_name}, $inform);
    } else {
        # If the zone is not in the atlas, assume it's accessible or handle as needed
        return 1;
    }
}

sub is_valid_stage {
    my $stage_name = shift;
    if (exists $VALID_STAGES{$stage_name}) {
        return 1;
    } else {
        quest::debug("NON-VALID PROGRESSION STAGE WAS CHECKED!");
        return 0;
    }
}

# Returns the destination zone of a specified door
sub get_target_door_zone {
    my ($zonesn, $doorid, $version) = @_;
    my $return_value = "";

    my $dbh = plugin::LoadMysql();
    my $sth = $dbh->prepare('SELECT * FROM doors WHERE zone = ? AND doorid = ? AND version = ?');

    $sth->execute($zonesn, $doorid, $version);

    if (my $row = $sth->fetchrow_hashref()) {
       $return_value = $row->{dest_zone};
    }

    $sth->finish();
    $dbh->disconnect();

    return $return_value;
}
