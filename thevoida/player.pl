sub EVENT_CONNECT {
    if (!$instanceid) {
        quest::debug("Not in an instance!");
        $instance = quest::CreateInstance('thevoida', 0, 360000);
        $client->AssignToInstance($instance);

        $client->MovePCInstance($zoneid, $instance, $client->GetX(), $client()->GetY(), $client->GetZ(), $client->GetHeading());
    }
}