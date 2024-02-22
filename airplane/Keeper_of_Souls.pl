sub EVENT_SPAWN {
	#:: Create a timer 'keeper_depop' that triggers every 600 seconds (10 min)
	quest::settimer("keeper_depop", 600);
}

sub EVENT_COMBAT {
	#:: Match combat state 1 - entered combat
	if ($combat_state == 1) {
		#:: Create a timer 'dt' that triggers every 45 seconds
		quest::settimer("dt", 45);
	}
	else {
		#:: Stop the timer 'dt' from triggering
		quest::stoptimer("dt");
	}
}

sub EVENT_TIMER {
	#:: Match a timer 'keeper_depop'
	if ($timer eq "keeper_depop") {
		quest::stoptimer("keeper_depop");
		quest::depop();
	}
	#:: Match timer 'dt'
	elsif ($timer eq "dt") {
		$target = $npc->GetHateTop();
		if ($target->IsPet()) {
			$owner = $target->GetOwnerID();
			$npc->CastSpell(982, $owner);
		}
		else {
			$npc->CastSpell(982, $target);
		}
	}
}

sub EVENT_DEATH_COMPLETE {
	#:: Key a data bucket
	$key = sirran_status;
	#:: Set a value of '4' for 900 seconds (15 min)
	quest::set_data($key, "4", 900);
	#:: Spawn one and only one The Plane of Sky >> Sirran_the_Lunatic (71058), without grid or guild war, at the current location
	quest::unique_spawn(71058, 0, 0, $x, $y, $z);
}
