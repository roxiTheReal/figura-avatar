local absRoot = models.model.root.Torso

local chatBubble = absRoot.Body.Billboard
   :newText("chatbubble")
   :setAlignment("CENTER")
   :setScale(0.5, 0.5, 0.5)
   :setOutline(true)
   :setOutlineColor(1, 1, 1)

function pings.typeMsg(message)
    -- Reset variables for the new message
   local targetMsg = message
   local finalMsg = ""
   local charIndex = 0
   local clearDelay = 0 -- New variable to track how long we've waited after typing

   events.tick:register(function ()
      
      if charIndex <= #targetMsg then
         if world.getTime() % 1 == 0 then
            charIndex = charIndex + 1
            
            if charIndex <= #targetMsg then
               local char = string.sub(targetMsg, charIndex, charIndex)
               finalMsg = finalMsg .. char
               if charIndex % 50 == 0 then
                  finalMsg = finalMsg .. "\n"
               end
               chatBubble:setText(toJson({ text = finalMsg, color = "#ff8848"}))
            end
         end
         
      -- Timer to clear
      else
         clearDelay = clearDelay + 1
         
         if clearDelay >= 100 then
            -- Time's up! Clear everything and kill the loop.
            chatBubble:setText("")
            finalMsg = ""
            events.tick:remove("tick_msg")
         end
      end
      
   end, "tick_msg")
end