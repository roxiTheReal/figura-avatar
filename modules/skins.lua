-- Script file just for switching skins
local skins = {
	skinName = "cat"
}

local gaze = require("Gaze")

skins.mainGaze = gaze:newGaze()                                                  -- Create a new gaze. We don't provide any arguments as the head is in-line with our camera
skins.mainGaze:newAnim(animations.model.LookHorizontal, animations.model.LookVertical) -- We will create a newAnim here in this example, providing the animations we just created
skins.mainGaze:newBlink(animations.model.Blink)                                        -- We also created a blink animation, so we will put it here

function pings.setSkin(skinName)
	local dir = math.random() * math.pi * 2
	if not player:isLoaded() then return end
	sounds["minecraft:block.beehive.enter"]:pos(player:getPos()):play()
	sounds["minecraft:block.fire.extinguish"]:pos(player:getPos()):play()
	for i = 1, 20 do
		particles["minecraft:poof"]
		:scale(math.random(1,5))
		:pos(vec(player:getPos().x + math.random(-2, 2), player:getPos().y + math.random(-2, 2), player:getPos().z + math.random(0, 2)))
		:color(1, 1, 1)
		:velocity(vec(math.cos(dir), math.random(10,150)/100, math.sin(dir)) * 0.05)
		:spawn()
	end

	skins.skinName = skinName
	if skinName == "human" then
		models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Human"])
		skins.mainGaze:setEnabled(false):zero()
	else
		models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Mystle"])
		skins.mainGaze:setEnabled(true)
	end
end

-- Set skin to cat on first load
models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Mystle"])
return skins