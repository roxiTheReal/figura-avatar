local np = require("modules.nameplate.builder")
local skins = require("modules.skins")

function pings.gogglesOn()
    models.model.root.Torso.Head.Goggles:setRot(0, 0, 0):setPos(vec(0, -48, 0) / 16)
    if player:isLoaded() then
		local equip_subtitle
		equip_subtitle = '[{"text":"","font":"figura:emoji_portrait","color":"white"},{"text":" ' .. np.getName() .. ' puts on her goggles","font":"minecraft:default","color":"#ff9f2f"}]'
		sounds["minecraft:item.armor.equip_generic"]
               :pos(player:getPos())
               :subtitle(equip_subtitle)
               :play()
	end
end

function pings.gogglesOff()
    models.model.root.Torso.Head.Goggles:setRot(10, -1, 5):setPos(vec(0, -8, 0)/16)
    if player:isLoaded() then
		local equip_subtitle
		equip_subtitle = '[{"text":"","font":"figura:emoji_portrait","color":"white"},{"text":" ' .. np.getName() .. ' takes off her goggles","font":"minecraft:default","color":"#ff9f2f"}]'
		sounds["minecraft:item.armor.equip_generic"]
               :pos(player:getPos())
               :subtitle(equip_subtitle)
               :play()
	end
end