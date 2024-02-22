sub EVENT_SPAWN {
	#:: Create a proximity, 100 units across, 100 units tall, without proximity say
	quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50, $z - 50, $z + 50, 0);
}

sub EVENT_ENTER {
	#:: Match a 18762 - Tattered Note
	if (plugin::check_hasitem($client, 18762)) { 
		$client->Message(15,"Dun McDowell turns to address you. 'Welcome, $name. I trust ye are ready for training in the ways of the rogue? Well read the note in your inventory and hand it to me when ye are ready to begin training.'");
	}
}

sub EVENT_SAY {
	if ($text=~/trades/i) {
		quest::say("I thought you might be one who was interested in the various different trades, but which one would suit you? Ahh, alas, it would be better to let you decide for yourself, perhaps you would even like to master them all! That would be quite a feat. Well, lets not get ahead of ourselves, here, take this book. When you have finished reading it, ask me for the [second book], and I shall give it to you. Inside them you will find the most basic recipes for each trade. These recipes are typically used as a base for more advanced crafting, for instance, if you wished to be a smith, one would need to find some ore and smelt it into something usable. Good luck!");
		#:: Give a 51121 - Tradeskill Basics : Volume I
		quest::summonitem(151121);
	}
	elsif ($text=~/second book/i) {
		quest::say("Here is the second volume of the book you requested, may it serve you well!");
		#:: Give a 51122 - Tradeskill Basics : Volume II
		quest::summonitem(151122);
	}
}

sub EVENT_ITEM {
	#:: Match a 18762 - Tattered Note
	if (plugin::takeItems(18762 => 1)) {
		quest::say("Ah.. ye wish to be a member o' the White Rose, then. eh? Well, let's train ye fer a bit. and see if ye've got what it takes. Once you are ready to begin adventuring make sure you see Lysbith first, she might have a few tasks for you.  Return to me for guidance anytime, I have much to teach you, from the secrets of the profession, to the various [trades] you may wish to dabble in.");
		#:: Give a 13513 - Torn White Tunic*
		quest::summonitem(113513);
		#:: Ding!
		quest::ding();
		#:: Set faction
		quest::faction(305, 100);	#:: + Rogues of the White Rose
		#:: Grant a small amount of experience
		quest::exp(100);
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
