sub EVENT_SPAWN {
    # Create a proximity area 400 units across
    quest::set_proximity($x - 200, $x + 200, $y - 200, $y + 200, $z - 200, $z + 200, 0);
    # Create an HP event at 96 percent health
    quest::setnexthpevent(96);
}

sub EVENT_AGGRO {
    # Create a timer 'leash' that triggers every second
    quest::settimer("leash", 1);
}

sub EVENT_HP {
    # Stop the timer 'leash' from triggering
    quest::stoptimer("leash");
    # Trigger EVENT_AGGRO subroutine to make sure the timer is running
    EVENT_AGGRO();
    # Set another HP event to catch any HP loss
    quest::setnexthpevent(int($npc->GetHPRatio()) - 9);
}

#sub EVENT_ENTER {
#    if (($ulevel >= 65) && ($status < 80)) {
#        quest::echo(0, "I will not fight you, but I will banish you!");
#        $client->MovePC(27, -64, 262, -93.96, 0);
#    }
#}

sub EVENT_TIMER {
    # Match timer 'leash'
    if ($timer eq "leash") {
        if ($x < -1000 || $x > -650 || $y < -1500 || $y > -1290) {
            # Trigger WIPE_AGGRO subroutine
            WIPE_AGGRO();
        }
        my @hate_list = $npc->GetHateList();
        my $hate_count = @hate_list;
        if ($hate_count > 0) {
            foreach $ent (@hate_list) {
                my $h_ent = $ent->GetEnt();
                if ($h_ent->IsClient() && $h_ent->GetLevel() > 80) {
                    quest::ze(0, "I will not fight you, but I will banish you!");
                    # Move player to Lavastorm
                    $h_ent->CastToClient()->MovePC(27, -64, 262, -93.96, 0);
                }
            }
        } else {
            # Trigger WIPE_AGGRO subroutine
            WIPE_AGGRO();
        }
    }
}

sub WIPE_AGGRO {
    $npc->BuffFadeAll();
    $npc->WipeHateList();
    $npc->SetHP($npc->GetMaxHP());
    $npc->GMMove($npc->GetSpawnPointX(), $npc->GetSpawnPointY(), $npc->GetSpawnPointZ(), $npc->GetSpawnPointH());
    # Stop the timer 'leash' from triggering
    quest::stoptimer("leash");
    # Create an HP event at 96 percent health
    quest::setnexthpevent(96);
}

sub EVENT_DEATH_COMPLETE {
    if (plugin::subflag_exists($npc->GetCleanName())) {
        my $flag_mob = quest::spawn2(26000, 0, 0, $x, $y, ($z + 10), 0); # Spawn a flag mob

        my $new_npc = $entity_list->GetNPCByID($flag_mob);

        $new_npc->SetBucket("Flag-Name", $npc->GetCleanName(), "1200s");
        $new_npc->SetBucket("Stage-Name", plugin::get_subflag_stage($npc->GetCleanName()), "1200s");
    }
}

sub EVENT_KILLED_MERIT {
    if (plugin::subflag_exists($npc->GetCleanName())) {
        plugin::set_subflag($client, plugin::get_subflag_stage($npc->GetCleanName()), $npc->GetCleanName());
    }
}