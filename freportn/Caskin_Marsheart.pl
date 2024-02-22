sub EVENT_SPAWN {
	#:: Create a proximity, 100 units across, 100 units tall, without proximity say
	quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50, $z - 50, $z + 50, 0);
}

sub EVENT_ENTER {
	#:: Check for 18747 - A Tattered Note
	if (plugin::check_hasitem($client, 18747)) {
		$client->Message(15,"As you get your bearings, you can hear a beautiful song. It almost seems to draw you towards it. It's as if you can hear a voice in your head as the music surrounds you. 'Welcome to Marsheart's Chords. young bard. I am Caskin Marsheart. To begin your training as a bard, read the note in your inventory and hand it to me.' The music then fades as quickly as it had begun.'");
	}
}

sub EVENT_SAY {
	if ($text=~/trades/i) {
		quest::say("I thought you might be one who was interested in the various different trades, but which one would suit you? Ahh, alas, it would be better to let you decide for yourself, perhaps you would even like to master them all! That would be quite a feat. Well, lets not get ahead of ourselves, here, take this book. When you have finished reading it, ask me for the  [second book], and I shall give it to you. Inside them you will find the most basic recipes for each trade. These recipes are typically used as a base for more advanced crafting, for instance, if you wished to be a smith, one would need to find some ore and smelt it into something usable. Good luck!");
		#:: Tradeskills Volume I 
		quest::summonitem(151121); 
	}
	elsif ($text=~/second book/i) {
		quest::say("Here is the second volume of the book you requested, may it serve you well!");
		#:: Tradeskills Volume II 
		quest::summonitem(151122); 
	}
} 

sub EVENT_ITEM {
	#:: Turn in for 18770 - Recruitment Summons
	if (plugin::takeItems(18747 => 1 )) {
		quest::say("Welcome to the guild. here's your guild tunic. Once you are ready to begin your training please make sure that you see Sten Harnak, he can assist you in developing your hunting and gathering skills. Return to me when you have become more experienced in our art, I will be able to further instruct you on how to progress through your early ranks, as well as in some of the various [trades] you will have available to you.");
		#:: Give item 13571 - Colorfully Patched Tunic*
		quest::summonitem(113571);
		#:: Ding!
		quest::ding();
		#:: Set factions
		quest::faction(284, 100); 	#:: + League of Antonican Bards
		quest::faction(281, 15); 	#:: + Knights of Truth
		quest::faction(262, 15); 	#:: + Guards of Qeynos
		quest::faction(304, -5); 	#:: - Ring of Scale
		quest::faction(285, -5); 	#:: - Mayong Mistmoore
		#:: Grant a small amount of experience
		quest::exp(100);
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
