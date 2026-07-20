-- == Lock movement while anims are playing == --
local MovementLock = {}

MovementLock.locked = false

function MovementLock.set(state)
   MovementLock.locked = state
end

function MovementLock.isLocked()
   return MovementLock.locked
end

function MovementLock.bindKeys(keys)
   for _, key in ipairs(keys) do
      key.press = function()
         return MovementLock.locked
      end
   end
end

function MovementLock.mouseMove()
   return MovementLock.locked
end

return MovementLock