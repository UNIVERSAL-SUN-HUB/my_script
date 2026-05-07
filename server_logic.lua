 local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Create the event if it doesn't exist
local event = ReplicatedStorage:FindFirstChild("TP_Event") or Instance.new("RemoteEvent", ReplicatedStorage)
event.Name = "TP_Event"

event.OnServerEvent:Connect(function(admin, p1Name, p2Name)
    local p1 = game.Players:FindFirstChild(p1Name)
    local p2 = game.Players:FindFirstChild(p2Name)
    
    if p1 and p2 and p1.Character and p2.Character then
        local root = p1.Character:FindFirstChild("HumanoidRootPart")
        local target = p2.Character:FindFirstChild("HumanoidRootPart")
        
        if root and target then
            local info = TweenInfo.new(1, Enum.EasingStyle.Sine)
            local goal = {CFrame = target.CFrame * CFrame.new(0, 0, -3)}
            TweenService:Create(root, info, goal):Play()
        end
    end
end)
