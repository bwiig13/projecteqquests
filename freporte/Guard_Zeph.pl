sub EVENT_ITEM {
	#:: Return unused items
	plugin::returnUnusedItems();
}

sub EVENT_DEATH_COMPLETE {
	quest::say("Your name shall be added to the most wanted list of the Freeport Militia!");
}
