-- Meow script
local skins = require("./skins")
local np    = require("./nameplate/builder")

local meow_sound = sounds["wawa"]
function pings.meow(arg)
	if player:isLoaded() then
		if arg then
			animations.model.msgsend:play()
		end
		if skins.skinName == "cat" then
			local hasCustomEmojis = false
			for k, v in ipairs(client.getActiveResourcePacks()) do
				if v:match("^Cosmics_Custom_Emojis_v1.0.10.zip") then
					hasCustomEmojis = true
					break
				end
			end
			local name = np.getName()

			local meow_subtitle

			if not hasCustomEmojis then
				meow_subtitle = '[[{color: "white", text: "", font: "figura:emoji_animal"}], [{color:"gold",text:" ' .. name .. ' meows :3",font:"minecraft:default"}]]'
			else
				meow_subtitle = '[[{color: "white", text: "", font: "figura:emoji_custom"}], [{color:"gold",text:" ' .. name .. ' meows :3",font:"minecraft:default"}]]'
			end
			meow_sound
				:subtitle(meow_subtitle)
				:pos(player:getPos())
				:play()
		end
	end
end

local meowbind = keybinds:newKeybind("meow :3", "key.keyboard.m", false)
meowbind.press = pings.meow

local purr_sound = sounds["minecraft:entity.cat.purreow"]

function pings.purr()
	if player:isLoaded() then
		animations.model.pat:play()
		if skins.skinName == "cat" then
			local hasCustomEmojis = false
			for k, v in ipairs(client.getActiveResourcePacks()) do
				if v:match("^Cosmics_Custom_Emojis_v1.0.10.zip") then
					hasCustomEmojis = true
					break
				end
			end
			local purr_subtitle
			if not hasCustomEmojis then
				purr_subtitle = '[{"text":"","font":"figura:emoji_animal","color":"white"},{"text":" ' .. np.getName() .. ' was patted :3","font":"minecraft:default","color":"#ff9f2f"}]'			
			else
				purr_subtitle = '[{"text":"","font":"figura:emoji_custom","color":"white"},{"text":" ' .. np.getName() .. ' was patted :3","font":"minecraft:default","color":"#ff9f2f"}]'
			end
			purr_sound	
				:pos(player:getPos())
				:subtitle(purr_subtitle)
				:play()
		end
	end
end