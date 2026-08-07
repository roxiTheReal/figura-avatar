-- Script file for sit (i dunno how else to add it to your avatar lmao :3 - Avery)

function pings.sit(state)
	if player:isLoaded() then
		animations.model.sit:setPlaying(state)
	end
end