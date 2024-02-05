sub CommonCharacterUpdate
{
    my $client = shift;

    CheckSkillAcquisition($client);
    CheckSpellAcquisition($client);

}

# Check if the player is eligible for the first point of a new skill
sub CheckSkillAcquisition
{
    my $client = shift;

    my $max_skill_id = 77;

    foreach my $skill (1..$max_skill_id) {
        if ($client->MaxSkill($skill) > 0 && $client->GetRawSkill($skill) < 1 && $client->CanHaveSkill($skill)) {
            $client->SetSkill($skill, 1);
        }
    }
}

sub CheckSpellAcquisition
{
    my $client = shift;
    my $level  = $client->GetLevel(); 

    quest::debug("Attempting to learn $level spells");
    $client->ScribeSpells($level - 1, $level);
}