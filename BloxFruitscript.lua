local dropdownButton = script.Parent:WaitForChild("TextButton")  -- "Select Fruit" button
local dropdownFrame = script.Parent:WaitForChild("Frame")  -- Dropdown frame
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- List of Blox Fruits
local fruitList = {
    "Yeti", "Kitsune", "Shadow", "Portal", "String", "Control", "Gravity", -- First Group
    "T-Rex", "Flame", "Magma", "Dark", "Love", "Sand", "Quake", "Rumble", "Rubber", -- Second Group
    "Falcon", "Barrier", "Spin", "Diamond", -- Third Group
    "Smoke", "Spike", "Spring" -- Fourth Group
}

-- Set the Asset ID for the monkey icon (pointing middle finger)
local monkeyIconID = "rbxassetid://10729455663"  -- The Asset ID for the monkey icon

-- Function to spawn the selected fruit
local function spawnFruit(fruitName)
    local fruitModel = game.ServerStorage:WaitForChild(fruitName)
    local fruitClone = fruitModel:Clone()
    local position = character.HumanoidRootPart.Position + (character.HumanoidRootPart.CFrame.LookVector * 5)
    fruitClone:SetPrimaryPartCFrame(CFrame.new(position))
    fruitClone.Parent = workspace
end

-- Toggle dropdown visibility when the button is clicked (both mobile and desktop)
dropdownButton.MouseButton1Click:Connect(function()
    dropdownFrame.Visible = not dropdownFrame.Visible
end)

-- Create a button for each fruit in the dropdown dynamically
for _, fruitName in ipairs(fruitList) do
    local fruitButton = Instance.new("TextButton")
    fruitButton.Size = UDim2.new(1, 0, 0, 60)  -- Larger size for touch devices
    fruitButton.Text = fruitName
    fruitButton.Parent = dropdownFrame
    fruitButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- White background for buttons

    -- Add the Monkey Icon Image
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 50, 0, 50)  -- Set the size of the icon
    imageLabel.Position = UDim2.new(0, 5, 0, 5)  -- Position the icon within the button
    imageLabel.Image = monkeyIconID  -- Set the image from the Asset ID
    imageLabel.Parent = fruitButton

    -- Set up button interaction (works for both desktop and mobile)
    fruitButton.MouseButton1Click:Connect(function()
        spawnFruit(fruitName)
        dropdownFrame.Visible = false  -- Close dropdown after selection
    end)
end

-- Set up responsiveness on different screen sizes (relative scaling)
dropdownButton.Size = UDim2.new(0.3, 0, 0.1, 0)  -- Adjust size for mobile scaling
dropdownButton.Position = UDim2.new(0.5, -100, 0.1, 0)  -- Adjust position

dropdownFrame.Size = UDim2.new(0.3, 0, 0.4, 0)  -- Dropdown size adjusts for mobile screens
dropdownFrame.Position = UDim2.new(0.5, -100, 0.2, 0)  -- Position dropdown below button
dropdownFrame.Visible = false  -- Start hidden, toggle visibility when needed

-- Close the dropdown if the player clicks anywhere outside the dropdown (for mobile compatibility)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- Detect if the click is outside the dropdown (for mobile or mouse)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mousePosition = input.Position
        if not dropdownFrame.AbsoluteRegion:Contains(mousePosition) and not dropdownButton.AbsoluteRegion:Contains(mousePosition) then
            dropdownFrame.Visible = false  -- Close dropdown if clicked outside
        end
    end
end)