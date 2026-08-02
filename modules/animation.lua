local runLater = require('modules.runLater')

function pings.deathPlay()
	animations.model.man_am_dead:play()
end

function pings.deathStop()
  animations.model.man_am_dead:stop()
end

function pings.typeAnim()
	animations.model.typing:play()
end

local _chatting = false

function events.key_press(key, action, modifier)
	if not host:isChatOpen() then return end
	local chatting = host:isChatOpen()
	if chatting == _chatting and key ~= 256 --[[Escape key]] or key ~= 84 --[[t key]] then
		animations.model.typing:play()
	end
	_chatting = chatting
end

local _crouching=false
function events.render()
  if not player:isLoaded() then return end
  local crouching=player:isCrouching()
  if crouching~=_crouching then
	if crouching == true then animations.model.crouching:setLoop("ONCE"):play() end
	if crouching == false then animations.model.uncrouching:setLoop("ONCE"):play() end
  end
  _crouching=crouching
end