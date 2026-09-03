-- Script made with <3 by Roxi (also Kit/Romi/Junix/Delca)
-- The main script: usually just for one-off function calls, so it's now very empty
-- most of the other code should just have their own file dedicated to that one feature
local patpat = require('patpat')
local skins  = require('./modules/skins')
local JustLean3 = require("just-lean-3") --var can be any name
local runLater  = require("modules.runLater")
local HTR = require("modules.libs.HSVtoRGB")

local np = require("modules.nameplate.builder")

local BugSpeak = require("BugSpeak")
local speech = BugSpeak.new()

speech:setVolume(0.5)
   :addSound('beep')
   :addSound('bop')
   :setBasePitch(2.5)
   :setPitchRange(0.8)
   :setSpacesPause(true)


speech:setCallback(function(c) 
   animations.model.speaking:play() 
end)

speech:setSubtitleVerb("yaps")

table.insert(patpat.oncePat, function ()
   if player:isLoaded() then
		animations.model.pat:stop():play()

		local purr_subtitle
		purr_subtitle = '[{"text":"","font":"figura:emoji_portrait","color":"white"},{"text":" ' .. np.getName() .. ' was patted :3","font":"minecraft:default","color":"#ff9f2f"}]'

		sounds["minecraft:block.wool.place"]
			:subtitle(purr_subtitle)
			:pos(player:getPos())
			:play()
	end
end)

vanilla_model.PLAYER:setVisible(false)

if host:isHost() then
   silly:setFly(true)
end

local MovementLock = require("modules/lockmovement")

MovementLock.bindKeys({
   keybinds:fromVanilla("key.forward"),
   keybinds:fromVanilla("key.back"),
   keybinds:fromVanilla("key.left"),
   keybinds:fromVanilla("key.right"),
   keybinds:fromVanilla("key.jump"),
   keybinds:fromVanilla("key.attack"),
   keybinds:fromVanilla("key.use"),
   keybinds:fromVanilla("key.sneak"),
})

function events.tick()
   MovementLock.set(
   animations.model.man_am_dead:isPlaying()
)
   if math.random(0, 10000) == 712 then
      if player:isLoaded () then 

         local pitchRot = player:getRot()
		   local pitch = 2^(-pitchRot.x / 90)

		   local t = (-pitchRot.x + 90) / 180
		   local hue = t * 270

		   local color = HTR.HSVtoRGB(hue, 1, 1)
         pings.meow("arg", 2 ^ (-player:getRot().x / 90), color) 

      end
   end

   if math.random(0, 10000000) == 1 then
      host:sendChatMessage("wawawawawawawawa- :explode:")
      runLater(10,  function() pings.disconnect() end)
      runLater(20, function() silly:disconnect() end)
   end
end

function events.mouse_move()
   return MovementLock.mouseMove()
end

avatar:setColor(vec(1, 103/255, 0/255), "donator")

vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)

local meows = {
   "meow",
   "mrrp",
   "mrrow",
   "myaw",
   "mrrrew"
}

function events.chat_send_message(msg)
   -- Ignore commands immediately
   if string.sub(msg, 1, 1) == '/' or string.sub(msg, 1, 1) == '@' then
      return msg
   end

   -- Handle the pings
   if string.find(msg, "mrrrp") then
      pings.purr()
   elseif string.find(msg, "meow") then
      pings.meow("arg")
   elseif string.find(string.lower(msg), string.lower("FISH")) then
      pings.fish()
   end

   if math.random(1, 1000) == 712 then
      log("triggered")
      return msg .. ", " .. meows[math.random(1, 5)] .. "!"
   end
   
   return msg
end

models.model.root.Torso.Head.Goggles:setPrimaryTexture("CUSTOM", textures["goggles"])

local dcBind = keybinds:newKeybind("disconnect sillily :3", "key.keyboard.right.bracket")
dcBind.press = function ()
   host:sendChatMessage("wawawawawawawawa- :explode:")
   runLater(10,  function() pings.disconnect() end)
   runLater(20, function() silly:disconnect() end)
end


local root = models.model.root
local torsoPart = root.Torso
local leftarm = torsoPart.LeftArm
local rightarm = torsoPart.RightArm
local model_head = torsoPart.Head
local leftleg = root.LeftLeg
local rightleg = root.RightLeg
local torso = JustLean3.lean:new(3, torsoPart, 0.2725, vec(0,12,0), true, {{-90,45},{-90,90}}, vec(0.95,0.2,1), true, true, nil) --Torso
local head = JustLean3.head:new(3, model_head, 0.75, true, {{-90,87},{-45,45}}, vec(0.95, 0.95, 0.95), torso) --Head
local left_arm = JustLean3.arms:new(1, leftarm, 0.25, true, vec(0.5,1,0.2))
local right_arm JustLean3.arms:new(2, rightarm, 0.25, true, vec(0.5,1,0.2))
local left_leg = JustLean3.legs:new(1, leftleg, 0.5, true, vec(1, 0.5, 0.1))
local right_leg = JustLean3.legs:new(2, rightleg, 0.5, true, vec(1, 0.5, 0.1))
