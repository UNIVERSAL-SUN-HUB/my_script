-- Naitik Hub | loader.lua (Rayfield Edition)
-- Place in StarterPlayerScripts

local Players         = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService      = game:GetService("RunService")

local player = Players.LocalPlayer

-- ──────────────────────────────────────────────
-- Settings  (saved to file, loaded on startup)
-- ──────────────────────────────────────────────
local SETTINGS_FILE = "naitik_hub_settings.txt"

local settings = {
    menuKey            = "LeftControl",
    ijEnabled          = false,
    speedEnabled       = false,
    speedVal           = 16,
    spinEnabled        = false,
    spinSpeedVal       = 20,
    noclipEnabled      = false,
    flyEnabled         = false,
    flySpeedVal        = 50,
    espEnabled         = false,
    hitboxEnabled      = false,
    hitboxSizeVal      = 5,
    flingEnabled       = false,
    fullBrightEnabled  = false,
}

local function saveSettings()
    local lines = {
        "menuKey="       .. settings.menuKey,
        "ijEnabled="     .. tostring(settings.ijEnabled),
        "speedEnabled="  .. tostring(settings.speedEnabled),
        "speedVal="      .. tostring(settings.speedVal),
        "spinEnabled="   .. tostring(settings.spinEnabled),
        "spinSpeedVal="  .. tostring(settings.spinSpeedVal),
        "noclipEnabled=" .. tostring(settings.noclipEnabled),
        "flyEnabled="    .. tostring(settings.flyEnabled),
        "flySpeedVal="   .. tostring(settings.flySpeedVal),
        "espEnabled="    .. tostring(settings.espEnabled),
        "hitboxEnabled=" .. tostring(settings.hitboxEnabled),
        "hitboxSizeVal=" .. tostring(settings.hitboxSizeVal),
        "flingEnabled="       .. tostring(settings.flingEnabled),
        "fullBrightEnabled="  .. tostring(settings.fullBrightEnabled),
    }
    pcall(function() writefile(SETTINGS_FILE, table.concat(lines, "\n")) end)
end

pcall(function()
    if isfile(SETTINGS_FILE) then
        for key, val in readfile(SETTINGS_FILE):gmatch("([%w]+)=([^\n]+)") do
            if     key == "menuKey"       then settings.menuKey       = val
            elseif key == "ijEnabled"     then settings.ijEnabled     = (val == "true")
            elseif key == "speedEnabled"  then settings.speedEnabled  = (val == "true")
            elseif key == "speedVal"      then settings.speedVal      = tonumber(val) or 16
            elseif key == "spinEnabled"   then settings.spinEnabled   = (val == "true")
            elseif key == "spinSpeedVal"  then settings.spinSpeedVal  = tonumber(val) or 20
            elseif key == "noclipEnabled" then settings.noclipEnabled = (val == "true")
            elseif key == "flyEnabled"    then settings.flyEnabled    = (val == "true")
            elseif key == "flySpeedVal"   then settings.flySpeedVal   = tonumber(val) or 50
            elseif key == "espEnabled"    then settings.espEnabled    = (val == "true")
            elseif key == "hitboxEnabled" then settings.hitboxEnabled = (val == "true")
            elseif key == "hitboxSizeVal" then settings.hitboxSizeVal = tonumber(val) or 5
            elseif key == "flingEnabled"      then settings.flingEnabled      = (val == "true")
            elseif key == "fullBrightEnabled" then settings.fullBrightEnabled = (val == "true")
            end
        end
    end
end)

local menuKey = Enum.KeyCode[settings.menuKey] or Enum.KeyCode.LeftControl

local function getKeyName(kc)
    local pretty = {
        LeftControl = "LControl", RightControl = "RControl",
        LeftShift   = "LShift",   RightShift   = "RShift",
        LeftAlt     = "LAlt",     RightAlt      = "RAlt",
    }
    return pretty[kc.Name] or kc.Name
end

-- ──────────────────────────────────────────────
-- Embedded Scripts  (20 unique, no duplicates)
-- ──────────────────────────────────────────────
local SCRIPTS = {
    [1]  = { display = "(Blox Fruits - Gravity Hub) VapeVoidware Loader",            code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua\", true))()" },
    [2]  = { display = "(Blox Fruits - Auto Farm + Raid) Blue X Hub",                code = "_G.AutoTranslate=true\n_G.SaveConfig=true\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua\"))()" },
    [3]  = { display = "(Blox Fruits - Auto V4 + Level + Raid) Xeno Gravity Hub",   code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/GRAVITY-Blox-Fruits-BEST-SCRIPT-SOLARA-AND-XENO-AUTO-V4-AUTO-LEVEL-AUTO-RAID-37566\"))()" },
    [4]  = { display = "(Universal - Admin Panel) Admin Panel Keyless",              code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Universal-Script-Admin-Panel-Universal-KEYLESS-171955\"))()" },
    [5]  = { display = "(Bite By Night - Auto Win + Farm + Aimbot) Bite By Night Hub", code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Bite-By-Night-Auto-win-Money-Farm-Kill-All-Aimbot-and-70-features-202018\"))()" },
    [6]  = { display = "(Universal - Multi Hub) Molyn Hub Keyless",                  code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Universal-Script-MOLYN-DEVELOPMENT-201480\"))()" },
    [7]  = { display = "(Universal - Multi Hub) Real Cryptic Free",                  code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/OnlyCryptic/Cryptic/hm/main.lua\"))()" },
    [8]  = { display = "(DOORS - Godmode + Speed Bypass) ZeScript",                 code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/DOORS-ZeScript-67246\"))()" },
    [9]  = { display = "(Blox Fruits - Gravity Hub V2) Gravity Hub",                code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua\"))()" },
    [10] = { display = "(Blox Fruits - Server Hop) Master Hop",                     code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/HopScript.luau\"))()" },
    [11] = { display = "(Break In 2 - Hub Script) Break In 2 Hub",                  code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/RScriptz/RobloxScripts/main/BreakIn2.lua\"))()" },
    [12] = { display = "(Forsaken - Hub Script) Forsaken Hub",                      code = "loadstring(game:HttpGet(\"https://pastebin.com/raw/zH9Extzk\"))()" },
    [13] = { display = "(Blox Fruits - Fruit Finder) Fruit Find",                   code = "getgenv().Team=\"Marines\"\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/FindFruit.lua\"))()" },
    [14] = { display = "(Blox Fruits - Bounty Hunt + Auto Hop) Bounty Hunt Hop",    code = "getgenv().Config={Team=\"Pirates\",HideUI=true,HuntConfig={[\"Earned Notification Enabled\"]=false,[\"Reset Farm (New)\"]=true,[\"Chat\"]=false,[\"Farm Delay\"]=0.22,[\"Webhook\"]={Enabled=false,Url=\"\"}}}\nloadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/2ffcdb62773f587bfb9eb0d52bb35b0c.lua\"))()" },
    [15] = { display = "(Ink - Needs Key) AX Scripts Ink",                          code = "script_key=\"KEY_HERE\";\nloadstring(game:HttpGet(\"https://officialaxscripts.vercel.app/scripts/AX-Loader.lua\"))()" },
    [16] = { display = "(Ink - Bypass) Ink Game Bypass",                            code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/eikikrkr-ux/bypasok/refs/heads/main/ok\"))()" },
    [17] = { display = "(DOORS - NullFire Hub) NullFire Doors",                     code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/TeamNullFire/NullFire/main/loader.lua\"))()" },
    [18] = { display = "(Universal - Multi Hub) Orange Hub",                         code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/HieuDepTrai-Z/Dev_Orange/refs/heads/main/OrangeHub.lua\"))()" },
    [19] = { display = "(Blox Fruits - WhiteX Beta) WhiteX BF-Beta",               code = "script_key=\"false\"\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua\"))()" },
    [20] = { display = "(Blox Fruits - Auto Bounty) SeraHub AutoBounty",            code = "getgenv().config={[\"Team\"]=\"Pirates\",[\"Use Race\"]={[\"V3\"]=true,[\"V4\"]=true},[\"Info Screen\"]=true,[\"White Screen\"]=false,[\"BypassTp\"]=true,[\"SkipFruit\"]={\"Portal-Portal\"},[\"Skip Race V4 User\"]=true,[\"MinBountyHunt\"]=0,[\"MaxBountyHunt\"]=30000000,[\"SafeHealth\"]=4000}\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/LumosSera/SeraHub/main/AutoBounty.lua\"))()" },
}

-- ──────────────────────────────────────────────
-- Feature Logic  (pure Lua, no UI references)
-- ──────────────────────────────────────────────

-- ── Infinite Jump ─────────────────────────────
local ijEnabled    = false
local ijConnection = nil

local function setIJToggle(state)
    ijEnabled         = state
    settings.ijEnabled = state
    saveSettings()
    if state then
        ijConnection = UserInputService.JumpRequest:Connect(function()
            local char = Players.LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if ijConnection then ijConnection:Disconnect() ijConnection = nil end
    end
end

-- ── Walk Speed ────────────────────────────────
local currentWalkSpeed = settings.speedVal
local speedEnabled     = settings.speedEnabled

local function applyWalkSpeed()
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speedEnabled and currentWalkSpeed or 16
    end
end

local function setSpeedToggle(state)
    speedEnabled          = state
    settings.speedEnabled = state
    saveSettings()
    applyWalkSpeed()
end

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    task.wait(0.2)
    hum.WalkSpeed = speedEnabled and currentWalkSpeed or 16
end)

-- ── Spin ──────────────────────────────────────
local spinEnabled = false
local spinSpeed   = settings.spinSpeedVal

local function applySpin()
    local char = Players.LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _, v in pairs(root:GetChildren()) do
        if v.Name == "NaitikSpin" then v:Destroy() end
    end
    if spinEnabled then
        local bav = Instance.new("BodyAngularVelocity")
        bav.Name           = "NaitikSpin"
        bav.MaxTorque      = Vector3.new(0, math.huge, 0)
        bav.AngularVelocity = Vector3.new(0, spinSpeed, 0)
        bav.Parent         = root
    end
end

local function setSpinToggle(state)
    spinEnabled         = state
    settings.spinEnabled = state
    saveSettings()
    applySpin()
end

Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.3)
    if spinEnabled then applySpin() end
end)

-- ── Noclip ────────────────────────────────────
local noclipEnabled = false
local noclipConn    = nil
local noclipClip    = true

local function startNoclip()
    noclipClip = false
    task.wait(0.1)
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipClip and Players.LocalPlayer.Character then
            for _, child in pairs(Players.LocalPlayer.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide then
                    child.CanCollide = false
                end
            end
        end
    end)
end

local function stopNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    noclipClip = true
end

local function setNoclipToggle(state)
    noclipEnabled         = state
    settings.noclipEnabled = state
    saveSettings()
    if state then startNoclip() else stopNoclip() end
end

Players.LocalPlayer.CharacterAdded:Connect(function()
    if noclipEnabled then startNoclip() end
end)

-- ── Fly ───────────────────────────────────────
local FLYING      = false
local FLY_CONTROL = { F=0, B=0, L=0, R=0, Q=0, E=0 }
local FLY_LCONTROL = { F=0, B=0, L=0, R=0, Q=0, E=0 }
local FLY_SPEED   = 0
local flySpeed    = settings.flySpeedVal
local flyHumanoid, flyRoot
local flyEnabled  = false

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.W then FLY_CONTROL.F =  1 end
    if input.KeyCode == Enum.KeyCode.S then FLY_CONTROL.B = -1 end
    if input.KeyCode == Enum.KeyCode.A then FLY_CONTROL.L = -1 end
    if input.KeyCode == Enum.KeyCode.D then FLY_CONTROL.R =  1 end
    if input.KeyCode == Enum.KeyCode.E then FLY_CONTROL.Q =  1 end
    if input.KeyCode == Enum.KeyCode.Q then FLY_CONTROL.E = -1 end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then FLY_CONTROL.F = 0 end
    if input.KeyCode == Enum.KeyCode.S then FLY_CONTROL.B = 0 end
    if input.KeyCode == Enum.KeyCode.A then FLY_CONTROL.L = 0 end
    if input.KeyCode == Enum.KeyCode.D then FLY_CONTROL.R = 0 end
    if input.KeyCode == Enum.KeyCode.E then FLY_CONTROL.Q = 0 end
    if input.KeyCode == Enum.KeyCode.Q then FLY_CONTROL.E = 0 end
end)

local function startFly()
    FLYING = true
    local BG = Instance.new("BodyGyro")
    local BV = Instance.new("BodyVelocity")
    BG.P           = 9e4
    BG.MaxTorque   = Vector3.new(9e9, 9e9, 9e9)
    BG.CFrame      = flyRoot.CFrame
    BG.Parent      = flyRoot
    BV.Velocity    = Vector3.new(0, 0, 0)
    BV.MaxForce    = Vector3.new(9e9, 9e9, 9e9)
    BV.Parent      = flyRoot
    task.spawn(function()
        repeat task.wait()
            local cam = workspace.CurrentCamera
            if flyHumanoid then flyHumanoid.PlatformStand = true end
            local moving = (FLY_CONTROL.L+FLY_CONTROL.R) ~= 0
                        or (FLY_CONTROL.F+FLY_CONTROL.B) ~= 0
                        or (FLY_CONTROL.Q+FLY_CONTROL.E) ~= 0
            FLY_SPEED = moving and flySpeed or 0
            if moving then
                BV.Velocity = ((cam.CFrame.LookVector * (FLY_CONTROL.F+FLY_CONTROL.B))
                    + ((cam.CFrame * CFrame.new(FLY_CONTROL.L+FLY_CONTROL.R,
                        (FLY_CONTROL.F+FLY_CONTROL.B+FLY_CONTROL.Q+FLY_CONTROL.E)*0.2, 0)).p
                    - cam.CFrame.p)) * FLY_SPEED
                FLY_LCONTROL = {F=FLY_CONTROL.F, B=FLY_CONTROL.B, L=FLY_CONTROL.L, R=FLY_CONTROL.R}
            elseif FLY_SPEED ~= 0 then
                BV.Velocity = ((cam.CFrame.LookVector * (FLY_LCONTROL.F+FLY_LCONTROL.B))
                    + ((cam.CFrame * CFrame.new(FLY_LCONTROL.L+FLY_LCONTROL.R,
                        (FLY_LCONTROL.F+FLY_LCONTROL.B+FLY_CONTROL.Q+FLY_CONTROL.E)*0.2, 0)).p
                    - cam.CFrame.p)) * FLY_SPEED
            else
                BV.Velocity = Vector3.new(0, 0, 0)
            end
            BG.CFrame = cam.CFrame
        until not FLYING
        FLY_CONTROL  = { F=0, B=0, L=0, R=0, Q=0, E=0 }
        FLY_LCONTROL = { F=0, B=0, L=0, R=0, Q=0, E=0 }
        FLY_SPEED    = 0
        BG:Destroy()
        BV:Destroy()
        if flyHumanoid then flyHumanoid.PlatformStand = false end
    end)
end

local function stopFly()
    FLYING = false
end

local function setFlyToggle(state)
    flyEnabled         = state
    settings.flyEnabled = state
    saveSettings()
    if state then
        local char = Players.LocalPlayer.Character
        if char then
            flyHumanoid = char:FindFirstChildOfClass("Humanoid")
            flyRoot     = char:FindFirstChild("HumanoidRootPart")
            if flyHumanoid and flyRoot then startFly() end
        end
    else
        stopFly()
    end
end

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.3)
    if flyEnabled then
        flyHumanoid = char:FindFirstChildOfClass("Humanoid")
        flyRoot     = char:FindFirstChild("HumanoidRootPart")
        if flyHumanoid and flyRoot then startFly() end
    end
end)

-- ── ESP ───────────────────────────────────────
local espEnabled = false
local espObjects = {}

local function createESP(plr)
    if plr == Players.LocalPlayer then return end
    local function apply(char)
        if not espEnabled then return end
        local head = char:FindFirstChild("Head")
        if not head then return end
        local hl = Instance.new("Highlight")
        hl.Name                = "NaitikESP"
        hl.FillColor           = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor        = Color3.fromRGB(255, 0, 0)
        hl.FillTransparency    = 0.5
        hl.OutlineTransparency = 0
        hl.Parent              = char
        local bill = Instance.new("BillboardGui")
        bill.Name         = "NaitikESPBill"
        bill.Size         = UDim2.new(0, 100, 0, 20)
        bill.StudsOffset  = Vector3.new(0, 2, 0)
        bill.AlwaysOnTop  = true
        bill.Parent       = head
        local lbl = Instance.new("TextLabel")
        lbl.Size                  = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text                  = plr.Name
        lbl.TextColor3            = Color3.fromRGB(255, 0, 0)
        lbl.TextStrokeTransparency = 0
        lbl.Font                  = Enum.Font.GothamBold
        lbl.TextScaled            = true
        lbl.Parent                = bill
        espObjects[plr] = { hl, bill }
    end
    if plr.Character then apply(plr.Character) end
    plr.CharacterAdded:Connect(apply)
end

local function enableESP()
    for _, plr in pairs(Players:GetPlayers()) do createESP(plr) end
end

local function disableESP()
    for _, objs in pairs(espObjects) do
        for _, obj in pairs(objs) do
            if obj and obj.Parent then obj:Destroy() end
        end
    end
    espObjects = {}
end

local function setESPToggle(state)
    espEnabled         = state
    settings.espEnabled = state
    saveSettings()
    if state then enableESP() else disableESP() end
end

Players.PlayerAdded:Connect(function(plr)
    if espEnabled then createESP(plr) end
end)

-- ── Hitbox ────────────────────────────────────
local hitboxEnabled = false
local hitboxSize    = settings.hitboxSizeVal

local function applyHitbox(plr)
    if plr == Players.LocalPlayer or not hitboxEnabled then return end
    local char = plr.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root and root:IsA("BasePart") then
        root.CanCollide  = false
        root.Size        = hitboxSize == 1 and Vector3.new(2,1,1) or Vector3.new(hitboxSize,hitboxSize,hitboxSize)
        root.Transparency = 0.4
    end
end

local function resetHitbox(plr)
    if plr == Players.LocalPlayer then return end
    local char = plr.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        root.Size         = Vector3.new(2, 2, 1)
        root.Transparency = 1
        root.CanCollide   = true
    end
end

local function applyAllHitboxes()
    for _, plr in pairs(Players:GetPlayers()) do applyHitbox(plr) end
end

local function resetAllHitboxes()
    for _, plr in pairs(Players:GetPlayers()) do resetHitbox(plr) end
end

local function setHitboxToggle(state)
    hitboxEnabled         = state
    settings.hitboxEnabled = state
    saveSettings()
    if state then applyAllHitboxes() else resetAllHitboxes() end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.3)
        if hitboxEnabled then applyHitbox(plr) end
    end)
end)

for _, plr in pairs(Players:GetPlayers()) do
    plr.CharacterAdded:Connect(function()
        task.wait(0.3)
        if hitboxEnabled then applyHitbox(plr) end
    end)
end

-- ── WalkFling ─────────────────────────────────
local walkflinging = false
local flingDiedConn = nil

local function getFlingRoot()
    local char = Players.LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function startWalkFling()
    if walkflinging then return end
    walkflinging = true
    local char = Players.LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if hum then
        flingDiedConn = hum.Died:Connect(function()
            walkflinging = false
        end)
    end
    task.spawn(function()
        local movel = 0.1
        while walkflinging do
            RunService.Heartbeat:Wait()
            char = Players.LocalPlayer.Character
            local root = getFlingRoot()
            while not (char and char.Parent and root and root.Parent) do
                RunService.Heartbeat:Wait()
                char = Players.LocalPlayer.Character
                root = getFlingRoot()
                if not walkflinging then return end
            end
            local vel = root.Velocity
            root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            RunService.RenderStepped:Wait()
            if char and char.Parent and root and root.Parent then
                root.Velocity = vel
            end
            RunService.Stepped:Wait()
            if char and char.Parent and root and root.Parent then
                root.Velocity = vel + Vector3.new(0, movel, 0)
                movel = -movel
            end
        end
    end)
end

local function stopWalkFling()
    walkflinging = false
    if flingDiedConn then flingDiedConn:Disconnect() flingDiedConn = nil end
end

local function setFlingToggle(state)
    settings.flingEnabled = state
    saveSettings()
    if state then startWalkFling() else stopWalkFling() end
end

Players.LocalPlayer.CharacterAdded:Connect(function()
    if walkflinging then
        task.wait(1)
        startWalkFling()
    end
end)

-- ── Full Bright ────────────────────────────────
local fullBrightEnabled = false
local Lighting = game:GetService("Lighting")

local origLighting = {
    Brightness       = Lighting.Brightness,
    ClockTime        = Lighting.ClockTime,
    FogEnd           = Lighting.FogEnd,
    FogStart         = Lighting.FogStart,
    Ambient          = Lighting.Ambient,
    OutdoorAmbient   = Lighting.OutdoorAmbient,
    GlobalShadows    = Lighting.GlobalShadows,
}

local function setFullBrightToggle(state)
    fullBrightEnabled              = state
    settings.fullBrightEnabled     = state
    saveSettings()
    if state then
        Lighting.Brightness      = 2
        Lighting.ClockTime       = 14
        Lighting.FogEnd          = 100000
        Lighting.FogStart        = 100000
        Lighting.Ambient         = Color3.fromRGB(178, 178, 178)
        Lighting.OutdoorAmbient  = Color3.fromRGB(178, 178, 178)
        Lighting.GlobalShadows   = false
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BlurEffect")
            or effect:IsA("ColorCorrectionEffect")
            or effect:IsA("SunRaysEffect")
            or effect:IsA("BloomEffect")
            or effect:IsA("DepthOfFieldEffect")
            then
                effect.Enabled = false
            end
        end
    else
        Lighting.Brightness      = origLighting.Brightness
        Lighting.ClockTime       = origLighting.ClockTime
        Lighting.FogEnd          = origLighting.FogEnd
        Lighting.FogStart        = origLighting.FogStart
        Lighting.Ambient         = origLighting.Ambient
        Lighting.OutdoorAmbient  = origLighting.OutdoorAmbient
        Lighting.GlobalShadows   = origLighting.GlobalShadows
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BlurEffect")
            or effect:IsA("ColorCorrectionEffect")
            or effect:IsA("SunRaysEffect")
            or effect:IsA("BloomEffect")
            or effect:IsA("DepthOfFieldEffect")
            then
                effect.Enabled = true
            end
        end
    end
end

-- Apply on startup if saved as enabled
if settings.fullBrightEnabled then
    setFullBrightToggle(true)
end

-- ──────────────────────────────────────────────
-- Kill Script  (forward declaration — assigned after all features)
-- ──────────────────────────────────────────────
local killScript

-- ──────────────────────────────────────────────
-- Load Rayfield UI Library
-- ──────────────────────────────────────────────
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ──────────────────────────────────────────────
-- Main Window
-- ──────────────────────────────────────────────
local Window = Rayfield:CreateWindow({
    Name                   = "⚡  Naitik Hub",
    LoadingTitle           = "Naitik Hub",
    LoadingSubtitle        = "Loading " .. #SCRIPTS .. " scripts & features...",
    Theme                  = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings   = true,
    ConfigurationSaving    = { Enabled = false },
    Discord                = { Enabled = false },
    KeySystem              = false,
})

-- ──────────────────────────────────────────────
-- Home Tab
-- ──────────────────────────────────────────────
local HomeTab = Window:CreateTab("Home", 4483362458)

HomeTab:CreateSection("Welcome")
HomeTab:CreateParagraph({
    Title   = "⚡  Naitik Hub",
    Content = "Welcome to Naitik Hub! "
        .. #SCRIPTS .. " scripts loaded. 7 built-in features available.\n"
        .. "All settings are saved automatically to naitik_hub_settings.txt.",
})
HomeTab:CreateParagraph({
    Title   = "📋  How to Use",
    Content = "• Scripts tab → click any script button to execute it\n"
        .. "• Executor tab → type & run your own Lua code\n"
        .. "• Features tab → toggle cheats and adjust values with sliders\n"
        .. "• Settings auto-save on every change",
})

HomeTab:CreateSection("Danger Zone")
HomeTab:CreateButton({
    Name     = "💀  Kill Script  (removes hub completely)",
    Callback = function()
        if killScript then killScript() end
    end,
})

HomeTab:CreateSection("Server Tools")
HomeTab:CreateButton({
    Name     = "🔄  Rejoin Same Server",
    Callback = function()
        Rayfield:Notify({ Title = "Rejoining...", Content = "Connecting to same server.", Duration = 3 })
        pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(
                game.PlaceId, game.JobId, Players.LocalPlayer
            )
        end)
    end,
})
HomeTab:CreateButton({
    Name     = "🌐  Hop to New Server",
    Callback = function()
        Rayfield:Notify({ Title = "Hopping...", Content = "Finding a new server.", Duration = 3 })
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
        end)
    end,
})

-- ──────────────────────────────────────────────
-- Scripts Tab
-- ──────────────────────────────────────────────
local ScriptsTab = Window:CreateTab("Scripts", 4483362458)
ScriptsTab:CreateSection("Click to Execute")

for _, scriptData in ipairs(SCRIPTS) do
    ScriptsTab:CreateButton({
        Name     = scriptData.display,
        Callback = function()
            local ok, err = pcall(function()
                loadstring(scriptData.code)()
            end)
            Rayfield:Notify({
                Title    = ok and "✅  Executed" or "❌  Error",
                Content  = ok and scriptData.display or tostring(err),
                Duration = ok and 3 or 6,
            })
        end,
    })
end

-- ──────────────────────────────────────────────
-- Executor Tab
-- ──────────────────────────────────────────────
local ExecutorTab = Window:CreateTab("Executor", 4483362458)
ExecutorTab:CreateSection("Custom Lua Executor")

local execCode = ""
ExecutorTab:CreateInput({
    Name            = "Lua Code",
    PlaceholderText = "Enter Lua code here...",
    CharacterLimit  = 5000,
    OnComplete      = false,
    Callback        = function(Value)
        execCode = Value
    end,
})
ExecutorTab:CreateButton({
    Name     = "▶  Execute Code",
    Callback = function()
        if execCode == "" then
            Rayfield:Notify({ Title = "Empty", Content = "Enter some code first.", Duration = 3 })
            return
        end
        local fn, compErr = loadstring(execCode)
        if not fn then
            Rayfield:Notify({ Title = "❌  Compile Error", Content = tostring(compErr), Duration = 6 })
            return
        end
        local ok, runErr = pcall(fn)
        Rayfield:Notify({
            Title    = ok and "✅  Executed" or "❌  Runtime Error",
            Content  = ok and "Code ran successfully!" or tostring(runErr),
            Duration = ok and 3 or 6,
        })
    end,
})
ExecutorTab:CreateButton({
    Name     = "🗑  Clear Code",
    Callback = function()
        execCode = ""
        Rayfield:Notify({ Title = "Cleared", Content = "Code input cleared.", Duration = 2 })
    end,
})

-- ──────────────────────────────────────────────
-- Features Tab
-- ──────────────────────────────────────────────
local FeaturesTab = Window:CreateTab("Features", 4483362458)

FeaturesTab:CreateSection("Movement")

FeaturesTab:CreateToggle({
    Name         = "♾️  Infinite Jump",
    CurrentValue = settings.ijEnabled,
    Flag         = "InfiniteJump",
    Callback     = function(Value) setIJToggle(Value) end,
})

FeaturesTab:CreateToggle({
    Name         = "⚡  Speed Boost  (off = default 16)",
    CurrentValue = settings.speedEnabled,
    Flag         = "SpeedBoost",
    Callback     = function(Value) setSpeedToggle(Value) end,
})

FeaturesTab:CreateSlider({
    Name         = "⚡  Walk Speed",
    Range        = { 0, 500 },
    Increment    = 1,
    Suffix       = " speed",
    CurrentValue = settings.speedVal,
    Flag         = "WalkSpeed",
    Callback     = function(Value)
        currentWalkSpeed  = Value
        settings.speedVal = Value
        saveSettings()
        if speedEnabled then applyWalkSpeed() end
    end,
})

FeaturesTab:CreateToggle({
    Name         = "🌀  Spin",
    CurrentValue = settings.spinEnabled,
    Flag         = "Spin",
    Callback     = function(Value) setSpinToggle(Value) end,
})

FeaturesTab:CreateSlider({
    Name         = "🌀  Spin Speed",
    Range        = { 1, 200 },
    Increment    = 1,
    Suffix       = " speed",
    CurrentValue = settings.spinSpeedVal,
    Flag         = "SpinSpeed",
    Callback     = function(Value)
        spinSpeed              = Value
        settings.spinSpeedVal  = Value
        saveSettings()
        if spinEnabled then applySpin() end
    end,
})

FeaturesTab:CreateToggle({
    Name         = "👻  Noclip",
    CurrentValue = settings.noclipEnabled,
    Flag         = "Noclip",
    Callback     = function(Value) setNoclipToggle(Value) end,
})

FeaturesTab:CreateToggle({
    Name         = "🚀  Fly  (WASD · Q up · E down)",
    CurrentValue = settings.flyEnabled,
    Flag         = "Fly",
    Callback     = function(Value) setFlyToggle(Value) end,
})

FeaturesTab:CreateSlider({
    Name         = "🚀  Fly Speed",
    Range        = { 0, 500 },
    Increment    = 1,
    Suffix       = " speed",
    CurrentValue = settings.flySpeedVal,
    Flag         = "FlySpeed",
    Callback     = function(Value)
        flySpeed              = Value
        settings.flySpeedVal  = Value
        saveSettings()
    end,
})

FeaturesTab:CreateSection("Visual")

FeaturesTab:CreateToggle({
    Name         = "☀️  Full Bright  (see clearly day & night)",
    CurrentValue = settings.fullBrightEnabled,
    Flag         = "FullBright",
    Callback     = function(Value) setFullBrightToggle(Value) end,
})

FeaturesTab:CreateSection("Player")

FeaturesTab:CreateToggle({
    Name         = "👁  ESP  (Player Highlight + Name)",
    CurrentValue = settings.espEnabled,
    Flag         = "ESP",
    Callback     = function(Value) setESPToggle(Value) end,
})

FeaturesTab:CreateToggle({
    Name         = "📦  Hitbox Expander",
    CurrentValue = settings.hitboxEnabled,
    Flag         = "Hitbox",
    Callback     = function(Value) setHitboxToggle(Value) end,
})

FeaturesTab:CreateSlider({
    Name         = "📦  Hitbox Size",
    Range        = { 1, 50 },
    Increment    = 1,
    Suffix       = " size",
    CurrentValue = settings.hitboxSizeVal,
    Flag         = "HitboxSize",
    Callback     = function(Value)
        hitboxSize             = Value
        settings.hitboxSizeVal = Value
        saveSettings()
        if hitboxEnabled then applyAllHitboxes() end
    end,
})

FeaturesTab:CreateToggle({
    Name         = "💥  WalkFling",
    CurrentValue = settings.flingEnabled,
    Flag         = "WalkFling",
    Callback     = function(Value) setFlingToggle(Value) end,
})

FeaturesTab:CreateSection("Settings")

FeaturesTab:CreateButton({
    Name     = "⌨️  Set Menu Key  (click → then press a key)",
    Callback = function()
        Rayfield:Notify({ Title = "Listening...", Content = "Press any keyboard key now.", Duration = 4 })
        local conn
        conn = UserInputService.InputBegan:Connect(function(input, gp)
            if gp or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            menuKey              = input.KeyCode
            settings.menuKey     = input.KeyCode.Name
            saveSettings()
            Rayfield:Notify({
                Title    = "✅  Key Set",
                Content  = "Menu key saved: " .. input.KeyCode.Name,
                Duration = 3,
            })
            conn:Disconnect()
        end)
    end,
})

FeaturesTab:CreateButton({
    Name     = "🗑  Reset All Settings to Default",
    Callback = function()
        settings.menuKey       = "LeftControl"
        settings.ijEnabled     = false
        settings.speedEnabled  = false
        settings.speedVal      = 16
        settings.spinEnabled   = false
        settings.spinSpeedVal  = 20
        settings.noclipEnabled = false
        settings.flyEnabled    = false
        settings.flySpeedVal   = 50
        settings.espEnabled    = false
        settings.hitboxEnabled = false
        settings.hitboxSizeVal = 5
        settings.flingEnabled  = false
        saveSettings()
        setIJToggle(false)
        setSpeedToggle(false)
        setSpinToggle(false)
        setNoclipToggle(false)
        setFlyToggle(false)
        setESPToggle(false)
        setHitboxToggle(false)
        setFlingToggle(false)
        currentWalkSpeed = 16
        Rayfield:Notify({ Title = "Reset", Content = "All settings reset to defaults.", Duration = 3 })
    end,
})

-- ──────────────────────────────────────────────
-- Kill Script  (full cleanup — nothing survives)
-- ──────────────────────────────────────────────
killScript = function()
    -- 1. Stop every feature cleanly
    pcall(function() setIJToggle(false) end)
    pcall(function() setSpeedToggle(false) end)
    pcall(function() setSpinToggle(false) end)
    pcall(function() setNoclipToggle(false) end)
    pcall(function() setFlyToggle(false) end)
    pcall(function() setESPToggle(false) end)
    pcall(function() setHitboxToggle(false) end)
    pcall(function() setFlingToggle(false) end)

    -- 2. Hard-restore the local character to a clean state
    pcall(function()
        local char = Players.LocalPlayer.Character
        if not char then return end
        -- Reset walk speed
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed   = 16
            hum.JumpPower   = 50
            hum.PlatformStand = false
        end
        -- Kill any leftover motor objects (BodyGyro, BodyVelocity, BodyAngularVelocity)
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            for _, obj in pairs(root:GetChildren()) do
                if obj:IsA("BodyMover") or obj.Name == "NaitikSpin" then
                    obj:Destroy()
                end
            end
        end
        -- Restore CanCollide on all parts
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end)

    -- 3. Remove all ESP objects from other characters
    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Players.LocalPlayer and plr.Character then
                for _, obj in pairs(plr.Character:GetDescendants()) do
                    if obj.Name == "NaitikESP" or obj.Name == "NaitikESPBill" then
                        obj:Destroy()
                    end
                end
            end
        end
    end)

    -- 4. Destroy the floating N button
    pcall(function()
        local nb = player:WaitForChild("PlayerGui"):FindFirstChild("NaitikFloatBtn")
        if nb then nb:Destroy() end
    end)

    -- 5. Destroy the Rayfield GUI last (this removes the entire hub window)
    pcall(function()
        local rg = player:WaitForChild("PlayerGui"):FindFirstChild("Rayfield")
        if rg then rg:Destroy() end
    end)
end

-- ──────────────────────────────────────────────
-- Auto re-execute on teleport
-- ──────────────────────────────────────────────
local LOADER_URL = "https://raw.githubusercontent.com/naitikthakur8273-alt/my_script/refs/heads/main/loader.lua"

Players.LocalPlayer.OnTeleport:Connect(function(state)
    if state == Enum.TeleportState.Started then
        task.delay(4, function()
            pcall(function()
                local fn = loadstring(game:HttpGet(LOADER_URL))
                if fn then fn() end
            end)
        end)
    elseif state == Enum.TeleportState.Failed then
        Rayfield:Notify({
            Title    = "⚠️  Teleport Failed",
            Content  = "Retrying in 2 seconds...",
            Duration = 4,
        })
        task.delay(2, function()
            pcall(function()
                game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
            end)
        end)
    end
end)

-- ──────────────────────────────────────────────
-- Network ping monitor — auto-rejoin on disconnect
-- ──────────────────────────────────────────────
task.spawn(function()
    local warned = false
    while true do
        task.wait(8)
        local ok, ping = pcall(function() return Players:GetNetworkPing() end)
        if ok and ping and ping > 5 and not warned then
            warned = true
            Rayfield:Notify({
                Title    = "📡  Connection Lost",
                Content  = "High ping detected — rejoining server...",
                Duration = 5,
            })
            task.delay(3, function()
                pcall(function()
                    game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
                end)
            end)
        end
    end
end)

-- ──────────────────────────────────────────────
-- Floating "N" Toggle Button  (mobile-friendly)
-- Drag to reposition · tap to show/hide the hub
-- ──────────────────────────────────────────────
task.spawn(function()
    -- Give Rayfield a moment to fully build its GUI
    task.wait(2)

    local TweenService = game:GetService("TweenService")
    local playerGui    = player:WaitForChild("PlayerGui")

    local FloatGui = Instance.new("ScreenGui")
    FloatGui.Name            = "NaitikFloatBtn"
    FloatGui.ResetOnSpawn    = false
    FloatGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
    FloatGui.DisplayOrder    = 999
    FloatGui.Parent          = playerGui

    -- Outer glow ring
    local Ring = Instance.new("Frame")
    Ring.Size             = UDim2.new(0, 56, 0, 56)
    Ring.Position         = UDim2.new(0, 16, 0.5, -28)
    Ring.BackgroundColor3 = Color3.fromRGB(80, 100, 255)
    Ring.BorderSizePixel  = 0
    Ring.ZIndex           = 1
    Ring.Parent           = FloatGui
    Instance.new("UICorner", Ring).CornerRadius = UDim.new(1, 0)

    local RingGrad = Instance.new("UIGradient")
    RingGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 130, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 60, 255)),
    })
    RingGrad.Rotation = 135
    RingGrad.Parent   = Ring

    -- Main button (sits 3px inside the ring)
    local Btn = Instance.new("TextButton")
    Btn.Size             = UDim2.new(0, 50, 0, 50)
    Btn.Position         = UDim2.new(0.5, -25, 0.5, -25)
    Btn.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
    Btn.BorderSizePixel  = 0
    Btn.Text             = "N"
    Btn.TextColor3       = Color3.fromRGB(200, 210, 255)
    Btn.TextSize         = 24
    Btn.Font             = Enum.Font.GothamBold
    Btn.ZIndex           = 2
    Btn.Parent           = Ring
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

    -- Pulse animation on the ring
    local function pulseRing()
        TweenService:Create(Ring, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.5,
        }):Play()
    end
    pulseRing()

    -- ── Drag logic (tap = toggle, drag = move) ────
    local dragging  = false
    local isDrag    = false
    local dragStart = nil
    local startPos  = nil
    local DRAG_THRESHOLD = 6  -- pixels before we consider it a drag

    local hubVisible = true

    local function toggleHub()
        local rayfieldGui = playerGui:FindFirstChild("Rayfield")
        if rayfieldGui then
            hubVisible        = not hubVisible
            rayfieldGui.Enabled = hubVisible
            -- Visual feedback: dim the N button when hub is hidden
            TweenService:Create(Btn, TweenInfo.new(0.2), {
                TextColor3       = hubVisible and Color3.fromRGB(200, 210, 255) or Color3.fromRGB(100, 100, 140),
                BackgroundColor3 = hubVisible and Color3.fromRGB(14, 14, 24)    or Color3.fromRGB(8, 8, 16),
            }):Play()
            TweenService:Create(Ring, TweenInfo.new(0.2), {
                BackgroundColor3 = hubVisible and Color3.fromRGB(80, 100, 255) or Color3.fromRGB(40, 40, 80),
            }):Play()
            RingGrad.Color = hubVisible
                and ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 130, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 60, 255)),
                })
                or ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 80)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 40, 80)),
                })
        end
    end

    -- Use UserInputService for smooth global tracking during drag
    Btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            isDrag    = false
            dragStart = input.Position
            startPos  = Ring.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            if delta.Magnitude > DRAG_THRESHOLD then
                isDrag = true
                Ring.Position = UDim2.new(
                    startPos.X.Scale,  startPos.X.Offset  + delta.X,
                    startPos.Y.Scale,  startPos.Y.Offset  + delta.Y
                )
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            if dragging and not isDrag then
                -- Short tap → toggle hub
                toggleHub()
            end
            dragging = false
            isDrag   = false
        end
    end)
end)
