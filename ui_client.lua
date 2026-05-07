local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

-- Create the UI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)

local Input1 = Instance.new("TextBox", Frame) -- Target ("Me")
Input1.PlaceholderText = "Target (e.g. me)"
Input1.Size = UDim2.new(1, 0, 0, 30)

local Input2 = Instance.new("TextBox", Frame) -- Destination
Input2.PlaceholderText = "To Player..."
Input2.Position = UDim2.new(0, 0, 0, 40)
Input2.Size = UDim2.new(1, 0, 0, 30)

local Button = Instance.new("TextButton", Frame)
Button.Text = "CONFIRM"
Button.Position = UDim2.new(0, 0, 0, 80)
Button.Size = UDim2.new(1, 0, 0, 40)

Button.MouseButton1Click:Connect(function()
    local p1 = Input1.Text == "me" and LP.Name or Input1.Text
    local p2 = Input2.Text
    game.ReplicatedStorage:WaitForChild("TP_Event"):FireServer(p1, p2)
end)
