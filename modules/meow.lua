-- Meow script
local skins = require("./skins")
local np    = require("./nameplate/builder")
local HTR   = require("modules.libs.HSVtoRGB")

function pings.meow(arg, pitch, color)
	if player:isLoaded() then
		if arg then
			animations.model.msgsend:play()
		end
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
		sounds["wawa"]
			:subtitle(meow_subtitle)
			:pos(player:getPos())
			:pitch(pitch)
			:play()
		particles["note"]:color(color):pos(player:getPos().x, player:getPos().y + 1.8, player:getPos().z):spawn()
	end
end

local meowbind = keybinds:newKeybind("meow :3", "key.keyboard.m", false)
meowbind.press = function ()
	if player:isLoaded () then

		local pitchRot = player:getRot()
		local pitch = 2^(-pitchRot.x / 90)

		local t = (-pitchRot.x + 90) / 180
		local hue = t * 270

		local color = HTR.HSVtoRGB(hue, 1, 1)

		pings.meow("arg", pitch, color) 
	end 
end

function pings.purr()
	if player:isLoaded() then
		animations.model.pat:stop():play()
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
		sounds["block.wool.place"]
			:subtitle()
			:pos(player:getPos())
		sounds["minecraft:entity.cat.purreow"]
			:subtitle(purr_subtitle)
			:pos(player:getPos())
			:play()
	end
end

function pings.disconnect()
	if player:isLoaded() then
		sounds["kaboom"]:pos(player:getPos()):play()
		particles["explosion_emitter"]:pos(player:getPos()):scale(2):spawn()
	end
end