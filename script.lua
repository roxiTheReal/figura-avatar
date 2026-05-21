-- Script made with <3 by Roxi (also Kit/Romi)

local ping = require("modules.pings")
local nplates = require('modules.nameplates')

vanilla_model.PLAYER:setVisible(false)

pings.cat = ping.Cat
pings.human = ping.Human

function events.ENTITY_INIT()
  pings.cat()
  silly:setFly(true)
end

pings.meow = ping.Meow

local actionsPage1 = action_wheel:newPage()
action_wheel:setPage(actionsPage1)

local switchSkinHuman = actionsPage1:newAction()
:title("Human Roxi")
:item("stick")
:hoverColor(1, 0 ,1)
:onLeftClick(pings.human)

local switchSkinCat = actionsPage1:newAction()
:title("kibby roxi :3")
:item("cat_spawn_egg")
:hoverColor(1, 0, 1)
:onLeftClick(pings.cat)

local meowbind = keybinds:newKeybind("meow :3", "key.keyboard.m", false)
meowbind.press = pings.meow

function action_wheel.scroll()
  if action_wheel:getCurrentPage() == actionsPage1 then
    action_wheel:setPage(nplates.ActionsPage2)
    elseif action_wheel:getCurrentPage() == nplates.ActionsPage2 then
  action_wheel:setPage(actionsPage1)
  end
end