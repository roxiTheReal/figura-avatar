local Plates = {}

Plates.CatNameplate = function ()
  local nameplateJson = toJson({
    { text = "Roxi ", color = '#ff9f2f' },
    { text = "", font = 'figura:emoji_animal', color = 'white' }
  })
  for k, v in ipairs(client.getActiveResourcePacks()) do
    if v:match("^Cosmics_Custom_Emojis_v.*%.zip") then
      nameplateJson = toJson({
        { text = 'Roxi ', color = '#ff9f2f' },
        { text = ':@roxi:', font = "figura:emoji_custom", color = 'white' }
      })
      break
    end
  end
  return nameplateJson
end

Plates.HumanNameplate = toJson({
  { text = 'Roxi ', color = '#ff9f2f' },
  { text = '(human)', color = 'gray', italics = true }
})

Plates.AfkNameplate = toJson({
  { text = '\nafk ', color = 'dark_gray', italics = true },
  { text = ':zzz:', font = 'figura:emoji_symbol', italics = true }
})

Plates.TypingNameplate = toJson({
  { text = '\nin chat ', color = 'dark_gray', italics = true },
  { text = ':typing_animated:', font = 'figura:emoji_symbol', italics = true }
})

return Plates