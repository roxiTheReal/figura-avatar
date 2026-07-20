local runLater = require('modules.runLater')

function pings.deathPlay()
	animations.model.man_am_dead:play()
	local subtitle = '{"text":"damn she dead","font":"minecraft:default","color":"white"}'
	runLater(50, function() if player:isLoaded() then sounds["metal-pipe-clang"]:volume(0.1):subtitle(subtitle):pos(player:getPos()):play() end end)
end

function pings.deathStop()
  animations.model.man_am_dead:stop()
end