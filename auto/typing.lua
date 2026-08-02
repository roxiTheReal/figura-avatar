local tweens = require("lib.tween")

local LABEL_WORLD = models:newPart("LabelWorld", "WORLD")
:setMatrix(matrices.mat4()*0.1)

local COLOR = vectors.hexToRGB("FF884800")
local OUTLINE_COUNT = 4
local OUTLINE_SIZE = 0.4

local fixes = client.getTextWidth(".")
local function getWidth(text)
	return client.getTextWidth("." .. text .. ".") - fixes * 2
end


local Label = {}
Label.__index = Label

local DOWN = vec(0, -10, 0)
local UP = vec(0, 1, 0)

local c = 0
function Label.new(text, pos, rot, scale, shake, drippy)
	scale = scale or 1
	pos = pos * 16
	local self = setmetatable({}, Label)
	self.text = text
	self.tasks = {}
	self.char = {}
	local offset = -getWidth(text) / 2 * scale
	for i = 1, #text, 1 do
		c = c + 1
		local letter = text:sub(i, i)
		local width = getWidth(letter)

		local part = LABEL_WORLD:newPart("Letter" .. c)
		part
			 :setPos(vectors.rotateAroundAxis(rot, vec(offset + (width * 0.5) * scale, 0, 0), UP) + pos)
			 :light(15, 15)
			 :rot(0, rot + 180, 0):setVisible(false)
		local j = toJson(letter)
		for i = 0, OUTLINE_COUNT, 1 do
			local t = part:newText("letter" .. c .. i)
			if i == 0 then
				t:setText('{"text":' .. j .. ',"color":"#' .. vectors.rgbToHex(COLOR) .. '"}')
				t:setPos(width * 0.5, 4, -0.07):rot(-1, 0, 0)
			elseif i == 1 then
				t:setText('{"text":' .. j .. ',"color":"#' .. vectors.rgbToHex(COLOR * 0.85) ..
				'"}')
				t:setPos(width * 0.5, 4, 0)
			else
				t:setText('{"text":' .. j .. ',"color":"#' .. vectors.rgbToHex(1, 1, 1) .. '"}')
				local c = i / OUTLINE_COUNT
				local o = vec(math.sin(c * math.pi * 2), math.cos(c * math.pi * 2), 0) * OUTLINE_SIZE
				t:setPos(width * 0.5 + o.x, 4 + o.y, 0.01)
			end
		end
		offset = offset + width * scale
		self.tasks[i] = part
		self.char[i] = letter
	end

	local c = 1
	local cooldown = 0
	local lastTime = client:getSystemTime()
	local speed = #text > 15 and 0.05 or 0.06
	
	local duration = speed * #text + 1
	
	events.WORLD_RENDER:register(function()
		local time = client:getSystemTime()
		local delta = (time - lastTime) / 1000
		lastTime = time
		cooldown = cooldown + delta
		
		local finalSpeed = speed
		
		local char = self.char[c]
		if char == "." then
			finalSpeed = 1
		elseif char == " " then
			finalSpeed = finalSpeed * 1.5
		elseif char == "," then
			finalSpeed = 0.5
		end
		if cooldown > finalSpeed then
			cooldown = 0
			local task = self.tasks[c]
			local pos = task:getPos()
			local _, floorPos = raycast:block(pos / 16, pos / 16 + DOWN)
			local r = math.random() - 0.5
	
			tweens.new {
				from = 1,
				to = -3,
				duration = duration,
				easing = "outQuad",
				tick = function(v, t)
					if v > 0 then
						local e = (1 + math.max(v, 0) * 0.5) * scale
						task
						:setVisible(true)
						:scale(e, e, e)
					end
					local shift = vec(math.random()-0.5,math.random()-0.5,math.random()-0.5)*0.5 * shake
					local droop = drippy and (r-1) * (1-t) or 0
					task:pos(pos+shift + vec(0,droop * -2,0))
				end,
				onFinish = function()
					tweens.new {
						from = pos,
						to = floorPos * 16,
						duration = math.random() * 0.2 + 0.2,
						easing = "inQuad",
						tick = function(v, t)
							
							task
								 :setPos(v)
								 :setRot(25 * t, r * 90 * t + rot + 180, 0)
						end,
						onFinish = function()
							local pos = task:getPos()
							tweens.new {
								from = 0,
								to = math.pi,
								duration = 0.30,
								easing = "linear",
								tick = function(v, t)
									task
										 :setPos(pos.x, pos.y + math.sin(v) * 4, pos.z)
										 :setRot(t * 45 + 45, r * 90 * t + rot + 180, 0)
								end,
							}
	
							tweens.new {
								from = scale,
								to = 0,
								duration = 0.6,
								easing = "linear",
								tick = function(v, t)
									task
										 :scale(v, v, v)
								end,
								onFinish = function()
									task:remove()
								end
							}
						end,
					}
				end,
			}
	
			c = c + 1
			if c > #self.tasks then
				events.WORLD_RENDER:remove("AAA")
			end
		end
	end, "AAA")
end


function pings.mitext(text,scale,shake,drippy)
	if player:isLoaded() then
		local diff = (player:getPos()-client:getCameraPos()).x_z:normalize()
		Label.new(text,
			player:getPos():add(0, player:getEyeHeight() / 1.2, 0) - diff*0.5,
			math.deg(math.atan2(diff.x, diff.z))+180, scale or 0.75 ,
			shake,drippy)
	end
end



function mitext(text,scale,shake,drippy)
	pings.mitext(text,scale,shake or 0,drippy or false)
end

events.CHAT_SEND_MESSAGE:register(function (message)
	
	local screamCount = 0
	message:gsub("%?!", function() screamCount = screamCount + 1 end)
	message:gsub("!%?", function() screamCount = screamCount + 1 end)
	message:gsub("!!", function() screamCount = screamCount + 1 end)
	
	pings.mitext(message,
	#message > 20 and 0.3 or 0.5,
	screamCount,
	(message:find("%.%.$") 
	or message:find(":%(") 
	or message:find(":c")))
	return message
end,"milatch")