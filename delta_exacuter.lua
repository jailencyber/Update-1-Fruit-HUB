-- Attempt to load the Main.lua script from the specified URL
print("Fetching Main.lua script...")
local success, result = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/jailencyber/Update-1-Fruit-HUB/main/Main.lua")
end)

if success then
    print("Main.lua script fetched successfully")
    local loadSuccess, loadResult = pcall(function()
        return loadstring(result)()
    end)

    if loadSuccess then
        print("Main.lua script loaded successfully")
    else
        warn("Error loading Main.lua script: " .. loadResult)
    end
else
    warn("Error fetching Main.lua script: " .. result)
end
