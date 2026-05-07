local event = script.Parent:WaitForChild("TeleportEvent")
local button = script.Parent:WaitForChild("TPButton") -- Adjust name to match your button
local frame = script.Parent

button.MouseButton1Click:Connect(function()
	local p1Name = frame.Player1Input.Text
	local p2Name = frame.Player2Input.Text
	
	-- Send names to the server script in the same folder
	event:FireServer(p1Name, p2Name)
end)
