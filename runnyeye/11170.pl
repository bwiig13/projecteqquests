#:: The Liberated Citadel of Runnyeye >> (11170) (Warrior-class goblins)

sub EVENT_COMBAT {
	#:: Match combat state 1 - entered combat
	if ($combat_state == 1) {
		quest::say("Who is this creature in my view? I do not care, I will just run it through!");
	}
}

sub EVENT_ITEM {
	#:: Return unused items
	plugin::returnUnusedItems();
}

sub EVENT_DEATH_COMPLETE {
	quest::say("Flarglegnump ak murgledoo! That is Goblin for I hate you!");
}
