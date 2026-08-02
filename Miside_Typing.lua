
--[ [ <- separate to enable

local core = listFiles("core")
table.sort(core)
local stop = false
local addScript = addScript
for _, path in ipairs(core) do
	if require(path) then stop = true break end
end

if stop then addScript("main","") return end

for _, path in ipairs(listFiles("class")) do
	require(path)
end


for _, path in ipairs(listFiles("auto")) do
	require(path)
end

--]]