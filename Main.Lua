-- main.lua script for spawning a fruit in front of the player in Blox Fruits

-- Print a message to indicate that the script has loaded successfully
print("main.lua has been loaded successfully.")

-- Define the function to spawn a fruit
function spawn_fruit(fruit_name)
    -- Get the local player and character
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    -- Get the fruit model from ServerStorage
    local fruit_model = game.ServerStorage:FindFirstChild(fruit_name)

    -- Check if the fruit exists
    if fruit_model then
        -- Clone the fruit model and set its position
        local fruit_clone = fruit_model:Clone()
        fruit_clone:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5))

        -- Parent the fruit to the workspace
        fruit_clone.Parent = workspace

        print(fruit_name .. " has been spawned in front of the player.")
    else
        print("Error: The fruit " .. fruit_name .. " does not exist in ServerStorage.")
    end
end