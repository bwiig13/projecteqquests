-- a_clay_monolith #296051 - Fourth set at bottom of stairs

function event_signal(e)
	e.self:SetSpecialAbility(35, 0); --turn off immunity
	e.self:SetSpecialAbility(19, 0); --turn off melee immune
	e.self:SetSpecialAbility(20, 0); --turn off magic immune
	e.self:SetSpecialAbility(24, 0); --turn off anti aggro
end
