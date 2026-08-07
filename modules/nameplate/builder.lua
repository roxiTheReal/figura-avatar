-- Dedicated to functions needed to generate names for all the variants
local plates = {}


-- ============= The helper functions =============--

-- Create a new json base where we can append more components later
local function newNameBase(name, color)
	return {
		{text = name, color = color}
	}
end

-- Append cat or human part of the nameplate
local function appendCatName(json)

	-- Check if the person seeing your avatar has cosmic's emoji resource pack
	local hasCustomEmojis = false
	for k, v in ipairs(client.getActiveResourcePacks()) do
		if v:match("^Cosmics_Custom_Emojis_v1.0.10.zip") then
			hasCustomEmojis = true
			break
		end
	end

	if not hasCustomEmojis then
		table.insert(json, {text = ' ᚸᚳᚡ ', font = "figura:badges", color = 'white'})
		table.insert(json, {text = "", font = 'figura:emoji_animal', color = 'white'})
	else
		table.insert(json, {text = ' ᚸᚳᚡ ', font = "figura:badges", color = 'white'})
		table.insert(json, {text = ':@roxi:', font = "figura:emoji_custom", color = 'white'})
	end

end

local function appendHumanName(json) 
	table.insert(json, {text = ' ᚸᚳᚡ ', font = "figura:badges", color = 'white'})
	table.insert(json, {text = '(human)', color = 'gray', italic = true})
end

-- Append afk/typing/pronouns part of the nameplate
local function appendAfk(json)
	table.insert(json, {text = '\ntabbed out ', color = 'dark_gray', italic = true})
	table.insert(json, {text = ':zzz:', font = 'figura:emoji_symbol', italic = true})
end

local function appendTyping(json)
	table.insert(json, {text = '\ntyping... ', color = 'dark_gray', italic = true})
	table.insert(json, {text = ':typing_animated:', font = 'figura:emoji_symbol', italic = true})
end

local function appendPronouns(json)
	table.insert(json, {text = '\nshe/they', color = 'dark_gray', italic = true})
end

--[[ local function appendDesynced(json)
	table.insert(json, {text = '\nreload me!', color = 'dark_gray', italic = true})
	table.insert(json, {text = })
end
 ]]
-- ================================= --

-- The function that actually build names
-- plates.builtNames will store all the built names using given name, color, and form
-- plates.builtNames is first populated with placeholder names
plates.builtNames = {
	'{"text":"Roxi_Mystle"}',			-- Default name
	'{"text":"Roxi_Mystle \nAFK"}',		-- Name with afk tag
	'{"text":"Roxi_Mystle \nTyping"}',	-- Name with typing indicator
	'{"text":"Roxi_Mystle \nshe/they"}'	-- Name with pronouns shown
}

local function buildNames(name, color, form)
	-- Create 4 bases
	for i = 1, 4 do
		plates.builtNames[i] = newNameBase(name, color)

		-- Append components depending on forms
		-- (applies to all variants of the name, so it goes in this loop)
		if form == "cat" then
			appendCatName(plates.builtNames[i])
		else
			appendHumanName(plates.builtNames[i])
		end
	end

	-- Append afk/typing/pronouns
	appendAfk(plates.builtNames[2])
	appendTyping(plates.builtNames[3])
	appendPronouns(plates.builtNames[4])

	-- Convert all into json string
	for i = 1, 4 do
		plates.builtNames[i] = toJson(plates.builtNames[i])
	end
end

-- ================================= --
-- Automatically rebuild names as soon as nameIndex or formIndex changes
local nameList = {"Roxi", "Kit", "Romi", "Junix", "Delca(tty)"}
local formList = {"cat", "human"}

local nameIndex_old, nameIndex = nil, 1
local formIndex_old, formIndex = nil, 1

function events.tick()
	if (nameIndex_old ~= nameIndex) or (formIndex_old ~= formIndex) then
		buildNames(nameList[nameIndex], "#ff9f2f", formList[formIndex])
		nameIndex_old = nameIndex
		formIndex_old = formIndex
	end
end

-- ================================= --
-- These are the only 2 functions that will be used in other scripts
-- one to set your name, and other to set your form

function pings.setNameplateNameIndex(x) nameIndex = x end
function pings.setNameplateFormIndex(x) formIndex = x end

function plates.getName() return nameList[nameIndex] end

return plates