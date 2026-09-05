local plates = require("./builder")

--=========================================================--

-- Variables that need pings + the pings that set the value of them
local isTyping = false
function pings.setTyping(bool) isTyping = bool end

local isUnfocused = false
local afkStartTime = 0
function pings.setUnfocused(bool)
	isUnfocused = bool
	afkStartTime = client.getSystemTime()
end

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
			pings.afk(isUnfocused)
		end
	end
end


-- Afk nameplate logic --

local function displayAfkNameplate()
	local afkTime = (client:getSystemTime() - afkStartTime) / 1000
	local s = math.floor(afkTime % 60)
	local m = math.floor(afkTime / 60 % 60)
	local h = math.floor(afkTime / 3600 % 24)
	local timerString = (
		h > 0 and string.format("%d:%02d:%02d",h,m,s) or string.format("%d:%02d",m,s)
	)
	nameplate.ENTITY:setText(plates.builtNames[2]:gsub("${afk_timer}", timerString))
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
		displayAfkNameplate()
	elseif isTyping then
		nameplate.ENTITY:setText(plates.builtNames[3])
	else
		nameplate.ENTITY:setText(plates.builtNames[1])
	end

	nameplate.CHAT:setText(plates.builtNames[1])
	nameplate.LIST:setText(plates.builtNames[1])
end
