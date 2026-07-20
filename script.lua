-- Script made with <3 by Roxi (also Kit/Romi)
-- The main script: usually just for one-off function calls, so it's now very empty
-- most of the other code should just have their own file dedicated to that one feature
local patpat = require('patpat')
local skins  = require('./modules/skins')

table.insert(patpat.onPat, function ()
   pings.purr()
end)

vanilla_model.PLAYER:setVisible(false)

if host:isHost() then
   silly:setFly(true)
end

local MovementLock = require("modules/lockmovement")

MovementLock.bindKeys({
   keybinds:fromVanilla("key.forward"),
   keybinds:fromVanilla("key.back"),
   keybinds:fromVanilla("key.left"),
   keybinds:fromVanilla("key.right"),
   keybinds:fromVanilla("key.jump"),
   keybinds:fromVanilla("key.attack"),
   keybinds:fromVanilla("key.use"),
   keybinds:fromVanilla("key.sneak"),
})

function events.tick()
   MovementLock.set(
   animations.model.man_am_dead:isPlaying()
)
end

function events.mouse_move()
   return MovementLock.mouseMove()
end

function events.chat_send_message(msg)
   if string.find(msg, "mrrrp") then
      pings.purr()
      return msg
   elseif string.sub(msg, 1, 1) == '/' or string.sub(msg, 1, 1) == '@' then
      return msg
   else
      pings.meow()
      return msg
   end
end