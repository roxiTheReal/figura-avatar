-- Script file dedicated entirely to set up action wheel
-- Require all the scripts you need at the top of the file
local skins		= require("./skins")
local nplates	= require('./nameplate/builder')
local runLater = require('modules.runLater')


-- Array to store all the pages in order
local pages = {}

-- Page 1
pages[1] = action_wheel:newPage()
action_wheel:setPage(pages[1])

local switchSkinHuman = pages[1]:newAction()
	:title("Human Roxi")
	:item("stick")
	:hoverColor(1, 0 ,1)
	:onLeftClick(function()
		pings.setSkin("human")
		pings.setNameplateFormIndex(2)
	end)

local switchSkinCat = pages[1]:newAction()
	:title("kibby roxi :3")
	:item("cat_spawn_egg")
	:hoverColor(1, 0, 1)
	:onLeftClick(function()
		pings.setSkin("cat")
		pings.setNameplateFormIndex(1)
	end)

-- Page 2
pages[2] = action_wheel:newPage()

local name1 = pages[2]:newAction()
	:title("Change nameplate to Roxi")
	:item("minecraft:name_tag")
	:onLeftClick(function()
		pings.setNameplateNameIndex(1)
	end)

local name2 = pages[2]:newAction()
	:title("Change nameplate to Kit")
	:item("minecraft:name_tag")
	:onLeftClick(function()
		pings.setNameplateNameIndex(2)
	end)

local name3 = pages[2]:newAction()
	:title("Change nameplate to Romi")
	:item("minecraft:name_tag")
	:onLeftClick(function()
		pings.setNameplateNameIndex(3)
    end)
    
local name4 = pages[2]:newAction()
	:title("Change nameplate to Junix")
	:item("minecraft:name_tag")
	:onLeftClick(function()
		pings.setNameplateNameIndex(4)
	end)

local name5 = pages[2]:newAction()
	:title("Change nameplate to Delca")
	:item("minecraft:name_tag")
	:onLeftClick(function()
		pings.setNameplateNameIndex(5)
	end)

-- Page 3
pages[3] = action_wheel:newPage()

local transArmband = pages[3]:newAction()
	:title("Toggle trans armband (on any arm)")
	:item("minecraft:paper")
	:onLeftClick(function() 
		pings.toggleArmBand("left", "trans")
	end)
	:onRightClick(function()
		pings.toggleArmBand("right", "trans")
	end)

local enbyArmband = pages[3]:newAction()
	:title("Toggle enby armband (on any arm)")
	:item("minecraft:paper")
	:onLeftClick(function()
		pings.toggleArmBand("left", "enby")
	end)
	:onRightClick(function()
		pings.toggleArmBand("right", "enby")
	end)

pages[4] = action_wheel:newPage()

local manImDead = pages[4]:newAction()
	:title("haha, man im dead")
	:item("minecraft:skeleton_skull")
	:onLeftClick(function() pings.deathPlay() end)
	:onRightClick(function() pings.deathUnplay() end)
local sitting = pages[4]:newAction()
	:title("sit down")
	:item("minecraft:dark_oak_stairs")
	:onLeftClick(function() pings.sitPlay() end)
	:onRightClick(function() pings.sitStop() end)


pages[5] = action_wheel:newPage()

local boobToggle = pages[5]:newAction()
	:title("toggle boob")
	:item("minecraft:paper")
	:onLeftClick(function() pings.boobOn() end)
	:onRightClick(function() pings.boobOff() end)

local shirtToggle = pages[5]:newAction()
	:title("dress like tim :devious:")
	:item("minecraft:leather_chestplate")
	:onLeftClick(function() pings.toggleTimShirtOn() end)
	:onRightClick(function() pings.toggleTimShirtOff() end)

local gogglesOnOff = pages[5]:newAction()
	:title("put goggles on/off")
	:item("minecraft:stick")
	:onLeftClick(function() pings.gogglesOn() end)
	:onRightClick(function() pings.gogglesOff() end)

-- This deals with scrolling
-- it supports scrolling any number of pages
local selectedPage = 1
function action_wheel.scroll(delta)
	selectedPage = ((selectedPage - 1 + delta) % #pages) + 1
	action_wheel:setPage(pages[selectedPage])
end