sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::emote("jumps at your voice, he's obviously very focused on a set of beakers on the table. They seem to be holding samples of rotted flesh. Gapeers says, 'Oh my heart! You could have stopped it! Please be careful when entering these chambers. It would be unfortunate if I had dropped and broken these [specimens].");
	}
	if ($text=~/specimens/i) {
		quest::emote("turns to explain the specimens when he accidentally knocks over the beakers. He sucks in a short breath as the beakers crash to the ground, ruining the samples. As Gapeers's skin loses color, he says 'OH NO!! No, not my specimens!! Now what am I to do?! I needed those badly! You did this! You [owe] me now!'");
	}
	if ($text=~/owe/i) {
		quest::say("You bet you do! You big clumsy $race! These were the remains of unfortunates who were drowned. Not only were they drowned but their bodies clung to life and refused to settle. Products of the horrendous curse of unlife. I'll need you to find three [special samples] of drowned and cursed flesh.");
	}
	if ($text=~/special samples/i) {
		quest::emote("'s eyes widen as he realizes you actually might intend to help him. His voice becomes raspy with desperation as he says, 'Oh! Wonderful....uuhhmmm.... well ....You'll need to find undead creatures found in the waters of three different climates. One from a tropical ocean. One from the muddy and slow moving river of a jungle. And one from the stagnate and polluted water of a city's sewer, Freeport would be ideal. Will you really [do this] for me?");
	}
	if ($text=~/do this/i) {
		#:: Do animation "Plea"
		quest::doanim(50);
		quest::say("Oh thank goodness! Thank you so much, $name! Those old specimens were much to ancient anyway, fresh ones will help in my mission to heal those who were unfortunate enough to drown and become cursed. If you bring back the three samples I have a little something you might like. Although it will only fit and be of use to one who heals as a profession and is small of stature like myself. Good luck!");
	}
}


sub EVENT_ITEM {
	#:: Match a 1736 - Algae Covered Flesh, a 1737 - Swollen Flesh, and a 1735 - Waterlogged Flesh
	if (plugin::takeItems(1736 => 1, 1737 => 1, 1735 => 1)) {
		quest::emote("cheers as you hand him the samples of zombie flesh. He says, 'You have them! Excellent! Thank you very much, $name! Now I have much work to do so shoo before you break something else. Oh and here is your reward. It's an anklet that all our acolytes wear. Not only is it functional, but we can show off our beautiful foot hairs at the same time. Us halflings are pretty smart really.");
		#:: Give a 1731 - Acolyte's Anklet
		quest::summonitem(11731);
		#:: Ding!
		quest::ding();
		#:: Grand a small amount of experience
		quest::exp(100);
		#:: Create a hash for storing cash - 600 to 650cp
		my %cash = plugin::RandomCash(600,650);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
		#:: Set factions
		quest::faction(300,20);		#:: + Priests of Mischief
		quest::faction(286,20);		#:: + Mayor Gubbin
		quest::faction(263,20);		#:: + Guardians of the Vale
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
