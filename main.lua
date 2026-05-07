local ReplicatedStorage = game:GetService("ReplicatedStorage")
local event = ReplicatedStorage:WaitForChild("TeleportEvent")

local button = script.Parent
local frame = button.Parent -- Assumes textboxes are in the same frame

button.MouseButton1Click:Connect(function()
	local p1Name = frame.Player1Input.Text
	local p2Name = frame.Player2Input.Text
	
	-- Fire the event to the server
	event:FireServer(p1Name, p2Name)
end)
