-- Meow script
local skins = require("./skins")
local np    = require("./nameplate/builder")

local meow_sound = sounds["wawa"]
function pings.meow()
	if player:isLoaded() then
		if skins.skinName == "cat" then
			local name = np.getName()
			local meow_subtitle = '[[{color: "white", text: "", font: "figura:emoji_animal"}], [{color:"gold",text:" ' .. name .. ' meows :3",font:"minecraft:default"}]]'
			meow_sound
				:subtitle(meow_subtitle)
				:pitch(math.random()+0.5)
				:pos(player:getPos())
				:play()
		end
	end
end

local meowbind = keybinds:newKeybind("meow :3", "key.keyboard.m", false)
function meowbind.press()
	pings.meow()
end

local purr_subtitle = '[{"text":"","font":"figura:emoji_animal","color":"white"},{"text":" Roxi was patted :3","font":"minecraft:default","color":"#ff9f2f"}]'

local purr_sound = sounds["minecraft:entity.cat.purreow"]:subtitle(purr_subtitle)

function pings.purr()
	if player:isLoaded() then
		if skins.skinName == "cat" then
			local name = np.getName()
			purr_sound
				:pitch(math.random()+0.5)
				:pos(player:getPos())
				:play()
		end
	end
end