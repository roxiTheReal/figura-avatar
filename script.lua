-- Script made with <3 by Roxi (also Kit/Romi)

local ping = require("modules.pings")

vanilla_model.PLAYER:setVisible(false)

pings.cat = ping.Cat
pings.human = ping.Human

function events.ENTITY_INIT()
  pings.cat()
end

pings.meow = ping.Meow

local actionsPage1 = action_wheel:newPage()
local actionsPage2 = action_wheel:newPage()
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