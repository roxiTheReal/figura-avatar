-- chat.lua (by GarmadonPrime)
local activeMessages = {}

-- Config
local CONFIG = {
    charDelayTicks = 1,         -- Ticks between each character appearing
    messageLifetime = 100,      -- Ticks the message stays solid
    transitionTicks = 5,        -- Ticks spent fading in/out
    
    textColor = "#FF813D",                           -- Text color (can be hex like "#FFFFFF" or MC color names like "gold")
    outlineColor = vectors.hexToRGB("#E95500"),  -- RGB values for the outline (Must be hex)
    baseScale = vec(0.6, 0.6, 0.6),                -- Default size of the text
    
    maxWidth = 150,             -- Pixel width before the text wraps to a new line
    yShiftPerLine = 0.4         -- How far up old messages get pushed when a new one spawns
}

-- Pings
function pings.triggerMessageSequence(msgStr, tx, ty, tz)
    local lines = 1
    local currentWidth = 0
    local spaceWidth = client:getTextWidth(" ")
    
    for word in string.gmatch(msgStr, "%S+") do
        local wordWidth = client:getTextWidth(word)
        
        if wordWidth > CONFIG.maxWidth then
            local wordLines = math.ceil(wordWidth / CONFIG.maxWidth)
            lines = lines + wordLines - 1
            currentWidth = (wordWidth % CONFIG.maxWidth) + spaceWidth
        elseif currentWidth + wordWidth > CONFIG.maxWidth then
            lines = lines + 1
            currentWidth = wordWidth + spaceWidth
        else
            currentWidth = currentWidth + wordWidth + spaceWidth
        end
    end
    
    local selfUpwardShift = (lines - 1) * CONFIG.yShiftPerLine
    local totalShift = lines * CONFIG.yShiftPerLine 
    
    for _, msg in ipairs(activeMessages) do
        msg.targetYOffset = (msg.targetYOffset or 0) + totalShift
    end

    local msgGroup = models:newPart("MsgGroup_" .. math.random(), "WORLD")
    local msgBill = msgGroup:newPart("MsgBill", "BILLBOARD")
    local msgText = msgBill:newText("MsgText")
        :setAlignment("CENTER")
        :setScale(CONFIG.baseScale)
        :setOutline(true)
        :setOutlineColor(CONFIG.outlineColor)
        :setLight(15)
        :setOpacity(0)
        :setWidth(CONFIG.maxWidth)
        :setWrap(true)
        
    local tokens = {}
    local i = 1
    while i <= #msgStr do
        local s, e = string.find(msgStr, ":[%w_]+:", i)
        if s == i then
            table.insert(tokens, string.sub(msgStr, s, e))
            i = e + 1
        else
            local char = string.match(string.sub(msgStr, i), "^[%z\1-\127\194-\244][\128-\191]*")
            char = char or string.sub(msgStr, i, i)
            table.insert(tokens, char)
            i = i + #char
        end
    end

    table.insert(activeMessages, {
        group = msgGroup,
        textTask = msgText,
        tokens = tokens,
        displayedTokens = 0,
        lastTypeTick = world.getTime(), 
        pos = vec(tx, ty, tz),
        startTick = world.getTime(),
        yOffset = -1.5,
        targetYOffset = selfUpwardShift
    })
end

-- Events
events.CHAT_SEND_MESSAGE:register(function(message)
    if not player:isLoaded() then return message end
    if message:sub(1, 1) == "/" then return message end
    
    local eyeHeight = player:getEyeHeight() or 1.62
    local headPos = player:getPos() + vec(0, eyeHeight, 0)
    local textTargetPos = headPos + vec(0, 1.5, 0) 
    
    pings.triggerMessageSequence(message, textTargetPos.x, textTargetPos.y, textTargetPos.z)
    
    return message
end)

events.TICK:register(function()
    local time = world.getTime()
    
    for i = #activeMessages, 1, -1 do
        local msg = activeMessages[i]
        
        if msg.displayedTokens < #msg.tokens then
            if time - msg.lastTypeTick >= CONFIG.charDelayTicks then
                msg.displayedTokens = msg.displayedTokens + 1
                msg.lastTypeTick = time
            end
        end
        
        local charTable = {}

        for j = 1, msg.displayedTokens do
            local token = msg.tokens[j]
            local safeToken = token:gsub("\\", "\\\\"):gsub('"', '\\"')
            table.insert(charTable, '{"text":"'..safeToken..'","color":"'..CONFIG.textColor..'"}')
        end
        
        if msg.displayedTokens > 0 then
            msg.textTask:setText('['..table.concat(charTable, ",")..']')
        else
            msg.textTask:setText('[""]')
        end
        
        local age = time - msg.startTick
        local typingDuration = #msg.tokens * CONFIG.charDelayTicks
        local solidDuration = typingDuration + CONFIG.messageLifetime
        local fadeOutEnd = solidDuration + CONFIG.transitionTicks
        
        if age < CONFIG.transitionTicks then
            msg.yOffset = math.lerp(msg.yOffset, msg.targetYOffset, 0.4)
            msg.textTask:setOpacity(age / CONFIG.transitionTicks)
            
        elseif age < solidDuration then
            msg.yOffset = math.lerp(msg.yOffset, msg.targetYOffset, 0.4)
            msg.textTask:setOpacity(1)
            msg.textTask:setScale(CONFIG.baseScale)
            
        elseif age < fadeOutEnd then
            local outroProgress = (age - solidDuration) / CONFIG.transitionTicks
            
            msg.textTask:setOpacity(1 - outroProgress)
            msg.textTask:setScale(math.lerp(CONFIG.baseScale, vec(0,0,0), outroProgress))
            
        else
            msg.group:remove()
            table.remove(activeMessages, i)
        end
        
        if msg.group then
            msg.group:setPos(msg.pos * 16 + vec(0, msg.yOffset * 16, 0))
        end
        
        msg.textTask:setVisible(client:isHudEnabled())
    end
end)
-- :3