local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Finds the RemoteEvent located in the SAME folder
local event = script.Parent:WaitForChild("TeleportEvent")

-- Tween Settings: 1 second slide
local info = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

event.OnServerEvent:Connect(function(player, p1Name, p2Name)
	-- Find the two players by name
	local p1 = Players:FindFirstChild(p1Name)
	local p2 = Players:FindFirstChild(p2Name)

	if p1 and p2 then
		local char1 = p1.Character
		local char2 = p2.Character

		if char1 and char2 then
			local root1 = char1:FindFirstChild("HumanoidRootPart")
			local root2 = char2:FindFirstChild("HumanoidRootPart")

			if root1 and root2 then
				-- Calculate destination (3 studs in front of target)
				local destination = root2.CFrame * CFrame.new(0, 0, -3)
				
				-- Create and play the tween
				local tween = TweenService:Create(root1, info, {CFrame = destination})
				tween:Play()
			end
		end
	end
end)
