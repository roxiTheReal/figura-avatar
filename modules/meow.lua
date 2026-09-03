-- Meow script
local skins = require("./skins")
local np    = require("./nameplate/builder")
local HTR   = require("modules.libs.HSVtoRGB")

function pings.meow(arg, pitch, color)
	if player:isLoaded() then
		if arg then
			animations.model.msgsend:play()
		end
		local name = np.getName()
		local meow_subtitle
		meow_subtitle = '[[{color: "white", text: "", font: "figura:emoji_portrait"}], [{color:"gold",text:" ' .. name .. ' meows :3",font:"minecraft:default"}]]'
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
		local purr_subtitle
		purr_subtitle = '[{"text":"","font":"figura:emoji_portrait","color":"white"},{"text":" ' .. np.getName() .. ' was patted :3","font":"minecraft:default","color":"#ff9f2f"}]'
		sounds["minecraft:block.wool.place"]
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

function pings.fish()
	if player:isLoaded() then
		sounds["fish"]:pos(player:getPos()):subtitle("you know what dat means"):play()
	end
end