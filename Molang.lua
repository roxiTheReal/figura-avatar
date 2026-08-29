--implementing math.mod for molang compatibility
function math.mod(x,y)
	return x % y
end

--give support for 
Math = {}

--custom Sin and Cosin Functions to convert the numbers to the right type

	
Math.sin = function(a)
	return math.sin(math.rad(a))
end
	
Math.cos = function(a)
	return math.cos(math.rad(a))
end

Math.floor = function(a)
   return math.floor(a)
end

-- Allow q.anim_time to be interpreted as anim:getTime(), code by Auria

local animlist = {}
for _, v in pairs(animations:getAnimations()) do
   animlist[v:getName()] = v
end
local function err() error('', 4) end 
q = setmetatable({}, {
   __index = function(_, i)
      if i == 'anim_time' then
         local _, traceback = pcall(err)
         local name = traceback:match('^(.-) keyframe')
         return animlist[name] and animlist[name]:getTime()
      end
   end
})
query = q

local current
function prepare(t)
    current = t
    return 0
end
query = {}
setmetatable(query, {
    __index=function(...)
        if ({...})[2] == "anim_time" then
            return current[2]:getTime()
        end
    end
})