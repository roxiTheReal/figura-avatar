-- Script file just for switching skins
local skins = {
	skinName = "cat"
}

function pings.setSkin(skinName)
	skins.skinName = skinName
	if skinName == "human" then
		models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Human"])
	else
		models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Mystle"])
	end
end

-- Set skin to cat on first load
models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Mystle"])

return skins