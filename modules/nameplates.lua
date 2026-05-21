local Plates = {}

local names = {
  { text = "Roxi ", color = '#ff9f2f' },
  { text = "Kit ", color = '#ff9f2f' },
  { text = "Romi ", color = '#ff9f2f' },
}

local selectedIndex = 1

pings.default = function ()
  local ping = require('modules.pings')
  return ping.Default()
end

local function selectName()
  return names[selectedIndex]
end

Plates.CatNameplate = function ()
  local nameplateJson = toJson({
    selectName(),
    { text = 'ᚸᚳ ', font = "figura:badges", color = 'white' },
    { text = "", font = 'figura:emoji_animal', color = 'white' }
  })
  for k, v in ipairs(client.getActiveResourcePacks()) do
    if v:match("^Cosmics_Custom_Emojis_v.*%.zip") then
      nameplateJson = toJson({
        selectName(),
        { text = 'ᚸᚳ ', font = "figura:badges", color = 'white' },
        { text = ':@roxi:', font = "figura:emoji_custom", color = 'white' }
      })
      break
    end
  end
  return nameplateJson
end

Plates.HumanNameplate = function() 
  return toJson({
    selectName(),
    { text = 'ᚸᚳ ', font = "figura:badges", color = 'white' },
    { text = '(human)', color = 'gray', italics = true }
  })
end

Plates.AfkNameplate = toJson({
  { text = '\nafk ', color = 'dark_gray', italics = true },
  { text = ':zzz:', font = 'figura:emoji_symbol', italics = true }
})

Plates.TypingNameplate = toJson({
  { text = '\nin chat ', color = 'dark_gray', italics = true },
  { text = ':typing_animated:', font = 'figura:emoji_symbol', italics = true }
})

Plates.ActionsPage2 = action_wheel:newPage()

local name1 = Plates.ActionsPage2:newAction()
  :title("Change nameplate to Roxi")
  :item("minecraft:name_tag")
  :onLeftClick(function ()
    selectedIndex = 1
    pings.default()
  end)

local name2 = Plates.ActionsPage2:newAction()
  :title("Change nameplate to Kit")
  :item("minecraft:name_tag")
  :onLeftClick(function ()
    selectedIndex = 2
    pings.default()
  end)

local name3 = Plates.ActionsPage2:newAction()
  :title("Change nameplate to Romi")
  :item("minecraft:name_tag")
  :onLeftClick(function ()
    selectedIndex = 3
    pings.default()
  end)

return Plates