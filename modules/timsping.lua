function Recieve(txt,Insert)
    if txt:lower():find("lua") then return end
    for word in txt:gmatch("%g+") do
        if word:lower() == Insert then 
            return true end
    end
end

function events.chat_receive_message(raw, text)
    if Recieve(raw,"roxi") or Recieve(raw,"roxi_mystle") or parseJson(text).translate == "commands.message.display.incoming" then
        sounds["block.note_block.chime"]:setPos(player:getPos()):setSubtitle(nil):play()
    return text,vec(1, 129/255, 61/255)
    end
    return text
end