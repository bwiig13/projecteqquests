sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Aye, hello there, friend! How are ye on this fine day? A beautiful day to be alive, I must say! Anyway, I just got into Freeport last month. Wow, is this city big! Way bigger than humble little Rivervale. That's where I'm from. I'm working on setting up my own little business here, Falia's Foot Combs and Footwear, it'll be called. But, I don't have anything to sell yet, so check back in a couple of weeks. Safe travels to ye, friend.");
	}
}

sub EVENT_ITEM {
	#:: Turn in for 18925 - Letter to Falia
	if (plugin::takeItems(18925 => 1)) {
		quest::say("Heh, that good for nothing fool. I've been here for over a month already, and I haven't seen him yet. Bah, anyway, could you take this back to him for me? It was our grandfather's lucky necklace. He passed it down to our father, and now onto my brother. Knowing that little worm, Grenny, he'll probably trade it for a mug of ale. Oh well, thanks for delivering the letter, friend. Good day to you, and safe travels.");
		#:: Give item 13159 - Broken Heirloom Necklace
		quest::summonitem(113159);
		#:: Ding!
		quest::ding();
		#:: Grant a small amount of experience
		quest::exp(500);
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
