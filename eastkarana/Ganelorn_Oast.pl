sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Please be very quiet. I am tracking a notorious poacher.");
	}
	if ($text=~/call of flame/i) {
		quest::say("I suppose you would like to call the flame? I must know you are a dedicated forester before I would even consider teaching such a thing.");
	}
}

sub EVENT_ITEM {
	#:: Match 20876 - Love Letter (Sealed)
	if (plugin::check_handin(\%itemcount, 20876 => 1)) {
		quest::say("Ah, what do we have here? A letter? Hmm? Scented with a familiar fragrance too. You must have gotten this from Lily. I do wish I had more time to sp} with her, for she is a very sweet girl. If she trusts you to deliver such a letter, I must ask you to do me a favor for me. Please take these eggs. They are a very rare species of albino rattlesnakes which were thought to have been extinct due to poachers who eat them as a delicacy and griffins which prey on them. If these eggs hatch there is hope for the species. I need you to deliver them to my master, Kithicor.");
		#:: Give Item 20877 - Albino Rattlesnake Eggs
		quest::summonitem(120877);
		quest::ding();
		quest::exp(1000);
		#:: Set factions
		quest::faction(246,50);	#:: Faydark's Champions
		quest::faction(279,50);	#:: King Tearis Thex
		quest::faction(226,50);	#:: Clerics of Tunare
		quest::faction(310,50);	#:: Soldiers of Tunare
		quest::faction(234,-50);	#:: Crushbone Orcs
	}
	#:: Match 20878 - Symbol of Achievement
	if (plugin::check_handin(\%itemcount, 20878 => 1)) {
		quest::say("This does speak highly of you, my frind, an award from Kithicor does not come easy. But I must see more of your skills before I can consider teaching you. Lily's brother Devin is my current pupil - I need you to gather some equipment for me so I can properly train him. I require the following items of you - a smoldering sash, an adamantine ring and a blade forged of electrum. I also need a favor. Take this credit slip to Aanina Rockfinder. She is a merchant from whom I purchased a gift for Lily; it should be ready by now.");
		#:: Give a 20879 - Note of Credit
		quest::summonitem(120879);
		quest::ding();
		quest::exp(1000);
	}
	#:: Match 20881 - Burnt Sash, 20880 - Gift, 10151 - Adamantite Band, 5408 - Electrum-Bladed Wakizashi
	if (plugin::check_handin(\%itemcount, 20881 => 1, 20880 => 1, 10151 => 1, 5408 => 1)) {
		quest::say("You have done well. I sense the one I have been hunting in the distance. As your final test, you must track him down and destroy him.");
		#:: Spawn Vance_Bearstalker (15183)
		quest::spawn2(15183,0,0,-800,-2712,15.6,138);
		quest::ding();
		quest::exp(1000);
		#:: Set factions
		quest::faction(246,50);	#:: Faydark's Champions
		quest::faction(279,50);	#:: King Tearis Thex
		quest::faction(226,50);	#:: Clerics of Tunare
		quest::faction(310,50);	#:: Soldiers of Tunare
		quest::faction(234,-50);	#:: Crushbone Orcs
	}
	#:: Match 20882 - Poacher's Head
	if (plugin::check_handin(\%itemcount, 20882 => 1)) {
		quest::say("You, $name, are a worthy forester. It brings me great pride to present you this scroll that I have only passed to the finest in all of Norrath. Now you, too, may call the flames.");
		#:: Give a 15691 - Spell: Call of Flame
		quest::summonitem(115691);
		quest::ding();
		quest::exp(1000);
		#:: Set factions
		quest::faction(246,50);	#:: Faydark's Champions
		quest::faction(279,50);	#:: King Tearis Thex
		quest::faction(226,50);	#:: Clerics of Tunare
		quest::faction(310,50);	#:: Soldiers of Tunare
		quest::faction(234,-50);	#:: Crushbone Orcs
	}
	#:: Return unused items
	plugin::return_items(\%itemcount);
}

# Converted to Perl by SS
