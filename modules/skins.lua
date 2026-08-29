-- Script file just for switching skins
local skins = {
	skinName = "cat"
}

local gaze = require("Gaze")

local mainGaze = gaze:newGaze()                                                  -- Create a new gaze. We don't provide any arguments as the head is in-line with our camera
mainGaze:newAnim(animations.model.LookHorizontal, animations.model.LookVertical) -- We will create a newAnim here in this example, providing the animations we just created
mainGaze:newBlink(animations.model.Blink)                                        -- We also created a blink animation, so we will put it here

function pings.setSkin(skinName)
	skins.skinName = skinName
	if skinName == "human" then
		models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Human"])
		mainGaze:disable()
	else
		models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Mystle"])
		mainGaze:enable()
	end
end

-- Set skin to cat on first load
models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Mystle"])
return skins