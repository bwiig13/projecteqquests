-- #Vrex_Stonemaster_Hateq (297089)

local myx
local myy
local myz
local myh

function event_spawn(e)
	myx = e.self:GetX()
	myy = e.self:GetY()
	myz = e.self:GetZ()
	myh = e.self:GetHeading()
end


function event_signal(e)
	if (e.signal == 1) then
		--Active and able to kill, but won't fight back
		e.self:SetSpecialAbility(24, 0);
		e.self:SetSpecialAbility(25, 0);
		e.self:SetSpecialAbility(35, 0);
	end
end

function event_death_complete(e)
	eq.get_entity_list():MessageClose(e.self,false,120,MT.SayEcho,"As the last breath leaves the dying Vrex, the other two Stonemasters raise their voices in an attempt to cover the part of their fallen comrade.")
end
