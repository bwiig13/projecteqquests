-- a_clay_monolith #296002 - First set on stairs

function event_signal(e)
	e.self:SetSpecialAbility(35, 0); --turn off immunity
	e.self:SetSpecialAbility(19, 0); --turn off melee immune
	e.self:SetSpecialAbility(20, 0); --turn off magic immune
	e.self:SetSpecialAbility(24, 0); --turn off anti aggro
end
