sub EVENT_AGGRO {
	quest::say("I'll teach you to interfere with me $name!");
}

sub EVENT_ITEM {
	#:: Return unused items
	plugin::returnUnusedItems();
}

sub EVENT_DEATH_COMPLETE {
	quest::say("My comrades will avenge my death.");
}
