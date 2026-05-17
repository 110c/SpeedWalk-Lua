local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

if game:GetService("CoreGui"):FindFirstChild("WalkSpeedGUI") then
    return
end

local originalSpeed = 16
local currentSpeed = 50
local enabled = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WalkSpeedGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 140)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "WalkSpeed"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.85, 0, 0, 35)
TextBox.Position = UDim2.new(0.075, 0, 0.35, 0)
TextBox.PlaceholderText = "Enter speed..."
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.TextSize = 16
TextBox.Font = Enum.Font.Gotham
TextBox.Parent = Frame

Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.85, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.075, 0, 0.65, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Text = "ENABLE"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = Frame

Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 8)

local function applySpeed()
	if not enabled then return end
	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = currentSpeed
	end
end

ToggleButton.MouseButton1Click:Connect(function()
	enabled = not enabled
	
	if enabled then
		currentSpeed = tonumber(TextBox.Text) or 50
		currentSpeed = math.clamp(currentSpeed, 0, 100000)
		
		ToggleButton.Text = "DISABLE"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		applySpeed()
	else
		ToggleButton.Text = "ENABLE"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		
		local char = player.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid.WalkSpeed = originalSpeed
		end
	end
end)

TextBox.FocusLost:Connect(function()
	if enabled then
		currentSpeed = tonumber(TextBox.Text) or 50
		currentSpeed = math.clamp(currentSpeed, 0, 100000)
		applySpeed()
	end
end)

player.CharacterAdded:Connect(function()
	task.wait(0.6)
	if enabled then
		applySpeed()
	end
end)

RunService.Heartbeat:Connect(function()
	if enabled then
		local char = player.Character
		if char and char:FindFirstChild("Humanoid") then
			if char.Humanoid.WalkSpeed ~= currentSpeed then
				char.Humanoid.WalkSpeed = currentSpeed
			end
		end
	end
end)