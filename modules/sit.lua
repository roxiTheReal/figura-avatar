-- Script file for sit (i dunno how else to add it to your avatar lmao :3 - Skye)

function pings.sit(state, context)
	if player:isLoaded() then
		if context == "command" then
			animations.model.sitCommand:setPlaying(state)
		else
			animations.model.sit:setPlaying(state)
		end
	end
end