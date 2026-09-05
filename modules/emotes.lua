local emote = models.model.root.Torso.Body.Billboard:newText("emote")
local runLater = require("modules.runLater")


function pings.hai()
    if player:isLoaded() then
        local hi_subtitle = toJson({ text = "", font = "figura:emoji_gesture" })
        sounds["sounds.hi"]:subtitle(hi_subtitle):pos(player:getPos()):play()
        emote:setText(toJson({ text = ":wave:", font = "figura:emoji_gesture" }))
        animations.model.wave:play()
        runLater(60, function() emote:setText() end)
    end
end

function pings.bai()
    if player:isLoaded() then
        local hi_subtitle = toJson({ text = "", font = "figura:emoji_gesture" })
        sounds["sounds.bye"]:subtitle(hi_subtitle):pos(player:getPos()):play()
        emote:setRot(0, 180, 0)
        emote:setText(toJson({ text = ":wave:", font = "figura:emoji_gesture" }))
        runLater(60, function()
            emote:setRot(0, 0, 0)
            emote:setText() 
        end)
    end
end