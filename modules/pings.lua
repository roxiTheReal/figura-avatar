local P = {}

local nplates = require('modules.nameplates')
local helps = require('modules.helpers')

IsCat = false
IsHuman = false

function P.Cat()
  models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Mystle"])
  nameplate.ALL:setText(nplates.CatNameplate())
  nameplate.ENTITY:setBackgroundColor(0, 0, 0):setOutline(true)
  IsCat = true
  IsHuman = false
end

function P.Human()
  models.model.root:setPrimaryTexture("CUSTOM", textures["Roxi_Human"])
  nameplate.ALL:setText(nplates.HumanNameplate())
  nameplate.ENTITY:setBackgroundColor(0, 0, 0, 0):setOutline(true)
  IsHuman = true
  IsCat = false
end

function P.Typing()
  nameplate.ENTITY:setText(string.sub(nameplate.ENTITY:getText(), 1, -2) .. "," .. string.sub(nplates.TypingNameplate,2, -1))
end

function P.Afk()
  nameplate.ENTITY:setText(string.sub(nameplate.ENTITY:getText(), 1, -2) .. "," .. string.sub(nplates.AfkNameplate,2, -1))
end

function P.Default()
  if IsCat then
    nameplate.ALL:setText(nplates.CatNameplate())
  elseif IsHuman then
    nameplate.ALL:setText(nplates.HumanNameplate())
  end
end

function P.Meow()
  if player:isLoaded() then
    if IsCat then
      helps.Meow():play()
    end
  end
end

return P