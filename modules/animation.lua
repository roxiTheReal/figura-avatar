local skins = require("modules.skins")
local np    = require("modules.nameplate.builder")

local runLater = require('modules.runLater')

function pings.deathPlay()
	animations.model.man_am_dead:setSpeed(1):setLoop("HOLD"):play()
end

function pings.deathUnplay()
  animations.model.man_am_dead:stop()
  animations.model.man_am_dead:setLoop("ONCE"):setSpeed(-1):play()
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
local _sitting = false
function events.render()
  local sqek_cc
  local unsqek_cc
  local sit_cc
  local unsit_cc
  if not player:isLoaded() then return end
		sqek_cc = '[{"text":"","font":"figura:emoji_portrait","color":"white"},{"text":" ' .. np.getName() .. ' crouches","font":"minecraft:default","color":"#ff9f2f"}]'
		unsqek_cc = '[{"text":"","font":"figura:emoji_portrait","color":"white"},{"text":" ' .. np.getName() .. ' uncrouches","font":"minecraft:default","color":"#ff9f2f"}]'
		sit_cc = '[{"text":"","font":"figura:emoji_portrait","color":"white"},{"text":" ' .. np.getName() .. ' sits","font":"minecraft:default","color":"#ff9f2f"}]'
		unsit_cc = '[{"text":"","font":"figura:emoji_portrait","color":"white"},{"text":" ' .. np.getName() .. ' unsits","font":"minecraft:default","color":"#ff9f2f"}]'
  local crouching=player:isCrouching()
  if crouching~=_crouching then
	if crouching == true then 
		animations.model.crouching:setLoop("HOLD"):play()
		animations.model.uncrouching:stop()
		sounds["sqek"]:pos(player:getPos()):subtitle("Crouching"):subtitle(sqek_cc):play()
	end
	if crouching == false then 
		animations.model.uncrouching:setLoop("HOLD"):play()
		animations.model.crouching:stop()
		sounds["sqek"]:pos(player:getPos()):subtitle("Uncrouching"):subtitle(unsqek_cc):pitch(0.9):play()
	end
  end
  local sitting = player:getVehicle() ~= nil

  if sitting ~= _sitting then
	if sitting == true then
		pings.sit(true, "command")
		sounds["sqek"]:pos(player:getPos()):subtitle("Crouching"):subtitle(sit_cc):play()
	else
		pings.sit(false, "command")
		sounds["sqek"]:pos(player:getPos()):subtitle("Crouching"):subtitle(unsit_cc):pitch(0.9):play()
	end
  end

  _crouching=crouching
  _sitting = sitting
end

function pings.afk(context)
	if context == true then
		animations.model.afk:stop()
		animations.model.afk:speed(1):play()
		skins.mainGaze:setEnabled(false):zero()
	else
		animations.model.afk:stop()
		animations.model.afk:speed(-1):play()
		skins.mainGaze:setEnabled(true)
	end
end

function pings.cantaloupe(context)
	if not player:isLoaded() then return end
	if context == true then
		sounds["cantaloupe"]:pos(player:getPos()):play()
	else
		sounds["cantaloupe"]:stop()
	end
	models.model.root:setVisible(not context)
	models.model.Cantaloupe:setPrimaryTexture("CUSTOM", textures["cantaloupe"]):setVisible(context)
end