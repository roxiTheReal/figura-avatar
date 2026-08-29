local plates = require("./builder")

--=========================================================--

-- Variables that need pings + the pings that set the value of them
local isTyping = false
local isUnfocused = false

function pings.setTyping(bool) isTyping = bool end
function pings.setUnfocused(bool) isUnfocused = bool end

-- Syncing variables for others; this should only runs on your pc, so the host:isHost() is used
-- pings.setTyping and pings.setUnfocused are used to send the boolean value to others
if host:isHost() then
	local wasTyping = false
	local wasUnfocused = false

	function events.tick()
		wasTyping,    isTyping    = isTyping,    host:isChatOpen()
		wasUnfocused, isUnfocused = isUnfocused, (not client.isWindowFocused())

		if wasTyping ~= isTyping then pings.setTyping(isTyping) end
		if wasUnfocused ~= isUnfocused then 
			pings.setUnfocused(isUnfocused)
		end
	end
end

-- Logic for displaying correct nameplate variant

nameplate.ENTITY:setOutline(true) -- Always have outline

function events.tick()
	-- Since this is a bunch of elseifs, the first true condition is the only condition that's run
	-- So the nameplate display have a priority according to this order
	-- i.e. if you're afk, but someone's looking at you, your pronouns are shown instead of the afk indicator
	
	if (client.getCameraEntity():getTargetedEntity(5) == player) then
		nameplate.ENTITY:setText(plates.builtNames[4])
	elseif isUnfocused then
		nameplate.ENTITY:setText(plates.builtNames[2])
	elseif isTyping then
		nameplate.ENTITY:setText(plates.builtNames[3])
	else
		nameplate.ENTITY:setText(plates.builtNames[1])
	end

	nameplate.CHAT:setText(plates.builtNames[1])
	nameplate.LIST:setText(plates.builtNames[1])
end
