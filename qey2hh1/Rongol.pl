sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Great!! I have fifty acres to seed and now I have visitors stopping by to waste my time!!");
	}
	elsif ($text=~/follower of karana/i) {
		quest::say("Yes. I am a follower of Karana, the Rainkeeper. It is He who keeps the plains fertile.");
	}
	elsif ($text=~/blanket/i) {
		$classplural = "${class}s";
		quest::say("With the frequent rains, I find my only need is a blanket to keep me warm during the long cold nights. Thank Karana the temple has begun to send young $classplural to deliver extra blankets.");
	}
	elsif ($text=~/karana bandits/i) {
		quest::say("The Karana bandits are rogues who operate in the plains. I have heard there are bounties for the bandits. Within the Temple of Thunder in Qeynos, Cleric Gehna offers one for bandit spectacles and Paladin Chesgard offers one for bandit sashes.");
	}
}

sub EVENT_ITEM {
	#:: Match a 12102 - Temple Blankets
	if (plugin::takeItems(12102 => 1)) {
		quest::say("Thank you, protector of Karana. This will be handy when the cold rushes into the valley. Allow me to offer you some provisions for your journey. And, might I add, the [Karana bandits] have begun to operate much closer to Qeynos.");
		#:: Ding
		quest::ding();
		#:: Set factions
		quest::faction(345, 5);			#:: + Karana Residents
		quest::faction(262, 1);			#:: + Guards of Qeynos
		quest::faction(341, 1);			#:: + Priests of Life
		quest::faction(280, 1);			#:: + Knights of Thunder
		#:: Grant a small amount of experience
		quest::exp(100);
		#:: Create a hash for storing cash - 10 to 20cp
		my %cash = plugin::RandomCash(10,20);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
