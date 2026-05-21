local H = {}

function H.Meow()
  local meow_subtitle ='[[{color: "white", text: "", font: "figura:emoji_animal"}], [{color:"gold",text:" Roxi meows :3",font:"minecraft:default"}]]'
  local meow_sound = sounds["wawa"]:subtitle(meow_subtitle):pitch(math.random()+0.5)
  return meow_sound:pos(player:getPos())
end

return H