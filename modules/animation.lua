local runLater = require('modules.runLater')

function pings.deathPlay()
	animations.model.man_am_dead:play()
	runLater(50, function() if player:isLoaded() then sounds["metal-pipe-clang"]:volume(0.1):subtitle(toJson({
		text = "damn she dead"
	})):pos(player:getPos()):play() end end)
end

function pings.deathStop()
  animations.model.man_am_dead:stop()
end