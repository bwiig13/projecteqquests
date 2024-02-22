function event_say(e)
    if (e.message:findi("hail")) then
        e.self:Say("Greetings, " .. e.other:GetName() .. ". I can provide travel to other magi in [" .. eq.say_link("Butcherblock",false,"Butcherblock") .. "], [" .. eq.say_link("Commonlands",false,"Commonlands") .. "], [" .. eq.say_link("Everfrost",false,"Everfrost") .. "], [" .. eq.say_link("North Ro",false,"North Ro") .. "], and [" .. eq.say_link("South Ro",false,"South Ro") .. "]. I can also send you to [" .. eq.say_link("Natimbi",false,"Natimbi") .. "], the shores of Taelosia, or to the Queen of Thorns in [" .. eq.say_link("Abysmal Sea",false,"Abysmal Sea") .. "]. Just tell me where you'd like to go.");
    elseif (e.message:findi("butcherblock")) then
        e.self:CastSpell(4179,e.other:GetID(),0,1); -- Spell: Teleport: Butcherblock
    elseif (e.message:findi("everfrost")) then
        e.self:CastSpell(4180,e.other:GetID(),0,1); -- Spell: Teleport: Everfrost
    elseif (e.message:findi("natimbi") and eq.get_data("god-open")) then
        local saryrn_flag = eq.get_data(e.other:AccountID() .. "-saryrn-flag")
        local kunark_flag = eq.get_data(e.other:AccountID() .. "-kunark-flag")
    
        if (tonumber(saryrn_flag or "0") > 0 or tonumber(kunark_flag or "0") >= 20) then
            e.other:MovePC(280, -1557, -853, 241, 180); -- Zone: natimbi
        end
    elseif (e.message:findi("north ro")) then
        e.other:MovePC(34, 914, 2679, -25, 20); -- Zone: nro
    elseif (e.message:findi("south ro")) then
        e.other:MovePC(35, 1033, -1447, -23, 166); -- Zone: sro
    elseif (e.message:findi("commonlands")) then
        e.other:MovePC(22,-140,-1520,3,280); -- needs_heading_validation
    elseif (e.message:findi("abysmal sea")) then
        e.other:MovePC(279,39,-150,141,180); -- Zone: abysmal
    end
end

function event_trade(e)
    local item_lib = require("items");
    item_lib.return_items(e.self, e.other, e.trade);
end
