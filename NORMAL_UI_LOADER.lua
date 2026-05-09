-- NORMAL_UI_LOADER.lua | Universal Sun Hub — Native GUI Edition
-- No external libraries. Best on PC & Mobile.

-- ── Services ──────────────────────────────────────────────────────────
local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local player           = Players.LocalPlayer
local playerGui        = player:WaitForChild("PlayerGui")

-- ── Settings ──────────────────────────────────────────────────────────
local SETTINGS_FILE = "universal_sun_hub_settings.txt"
local settings = {
    menuKey="LeftControl", ijEnabled=false, speedEnabled=false, speedVal=16,
    spinEnabled=false, spinSpeedVal=20, noclipEnabled=false, flyEnabled=false,
    flySpeedVal=50, espEnabled=false, hitboxEnabled=false, hitboxSizeVal=5,
    flingEnabled=false, fullBrightEnabled=false, aimbotEnabled=false,
    aimbotMode="Nearest", aimbotTarget="", flingAllMode="TP",
    tweenTPTarget="", tweenTPSpeed=50,
}
local safeStr = function(v) if type(v)=="table" then return tostring(v[1] or "") end return tostring(v) end
local saveSettings, menuKey, getKeyName

do -- settings save/load
    saveSettings = function()
        local lines={
            "menuKey="..safeStr(settings.menuKey),
            "ijEnabled="..tostring(settings.ijEnabled),
            "speedEnabled="..tostring(settings.speedEnabled),
            "speedVal="..tostring(settings.speedVal),
            "spinEnabled="..tostring(settings.spinEnabled),
            "spinSpeedVal="..tostring(settings.spinSpeedVal),
            "noclipEnabled="..tostring(settings.noclipEnabled),
            "flyEnabled="..tostring(settings.flyEnabled),
            "flySpeedVal="..tostring(settings.flySpeedVal),
            "espEnabled="..tostring(settings.espEnabled),
            "hitboxEnabled="..tostring(settings.hitboxEnabled),
            "hitboxSizeVal="..tostring(settings.hitboxSizeVal),
            "flingEnabled="..tostring(settings.flingEnabled),
            "fullBrightEnabled="..tostring(settings.fullBrightEnabled),
            "aimbotEnabled="..tostring(settings.aimbotEnabled),
            "aimbotMode="..safeStr(settings.aimbotMode),
            "aimbotTarget="..safeStr(settings.aimbotTarget),
            "flingAllMode="..safeStr(settings.flingAllMode),
            "tweenTPTarget="..safeStr(settings.tweenTPTarget),
            "tweenTPSpeed="..tostring(settings.tweenTPSpeed),
        }
        pcall(function() writefile(SETTINGS_FILE,table.concat(lines,"\n")) end)
    end
    pcall(function()
        if not isfile(SETTINGS_FILE) then return end
        for key,val in readfile(SETTINGS_FILE):gmatch("([%w]+)=([^\n]+)") do
            if     key=="menuKey"           then settings.menuKey           = val
            elseif key=="ijEnabled"         then settings.ijEnabled         = val=="true"
            elseif key=="speedEnabled"      then settings.speedEnabled      = val=="true"
            elseif key=="speedVal"          then settings.speedVal          = tonumber(val) or 16
            elseif key=="spinEnabled"       then settings.spinEnabled       = val=="true"
            elseif key=="spinSpeedVal"      then settings.spinSpeedVal      = tonumber(val) or 20
            elseif key=="noclipEnabled"     then settings.noclipEnabled     = val=="true"
            elseif key=="flyEnabled"        then settings.flyEnabled        = val=="true"
            elseif key=="flySpeedVal"       then settings.flySpeedVal       = tonumber(val) or 50
            elseif key=="espEnabled"        then settings.espEnabled        = val=="true"
            elseif key=="hitboxEnabled"     then settings.hitboxEnabled     = val=="true"
            elseif key=="hitboxSizeVal"     then settings.hitboxSizeVal     = tonumber(val) or 5
            elseif key=="flingEnabled"      then settings.flingEnabled      = val=="true"
            elseif key=="fullBrightEnabled" then settings.fullBrightEnabled = val=="true"
            elseif key=="aimbotEnabled"     then settings.aimbotEnabled     = val=="true"
            elseif key=="aimbotMode"        then settings.aimbotMode        = val
            elseif key=="aimbotTarget"      then settings.aimbotTarget      = val
            elseif key=="flingAllMode"      then settings.flingAllMode      = val
            elseif key=="tweenTPTarget"     then settings.tweenTPTarget     = val
            elseif key=="tweenTPSpeed"      then settings.tweenTPSpeed      = tonumber(val) or 50
            end
        end
    end)
    menuKey = Enum.KeyCode[settings.menuKey] or Enum.KeyCode.LeftControl
    getKeyName = function(kc)
        local p={LeftControl="LControl",RightControl="RControl",LeftShift="LShift",
                 RightShift="RShift",LeftAlt="LAlt",RightAlt="RAlt"}
        return p[kc.Name] or kc.Name
    end
end

-- ── Scripts ───────────────────────────────────────────────────────────
local SCRIPTS = {
    { display="(Blox Fruits) VapeVoidware Gravity Hub",        code='loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua",true))()' },
    { display="(Blox Fruits) Blue X Hub - Auto Farm",          code='_G.AutoTranslate=true\n_G.SaveConfig=true\nloadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()' },
    { display="(Blox Fruits) Xeno Gravity Hub - Auto V4",      code='loadstring(game:HttpGet("https://rawscripts.net/raw/GRAVITY-Blox-Fruits-BEST-SCRIPT-SOLARA-AND-XENO-AUTO-V4-AUTO-LEVEL-AUTO-RAID-37566"))()' },
    { display="(Bite By Night) Hub - Aimbot & 70 features",    code='loadstring(game:HttpGet("https://rawscripts.net/raw/Bite-By-Night-Auto-win-Money-Farm-Kill-All-Aimbot-and-70-features-202018"))()' },
    { display="(Universal) Molyn Hub Keyless",                 code='loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-MOLYN-DEVELOPMENT-201480"))()' },
    { display="(Universal) Real Cryptic Free",                 code='loadstring(game:HttpGet("https://raw.githubusercontent.com/OnlyCryptic/Cryptic/hm/main.lua"))()' },
    { display="(DOORS) ZeScript - Godmode",                    code='loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-ZeScript-67246"))()' },
    { display="(Blox Fruits) Gravity Hub V2",                  code='loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"))()' },
    { display="(Blox Fruits) Master Hop - Server Hop",         code='loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/HopScript.luau"))()' },
    { display="(Break In 2) Hub",                              code='loadstring(game:HttpGet("https://raw.githubusercontent.com/RScriptz/RobloxScripts/main/BreakIn2.lua"))()' },
    { display="(Forsaken) Hub",                                code='loadstring(game:HttpGet("https://pastebin.com/raw/zH9Extzk"))()' },
    { display="(Blox Fruits) Fruit Finder",                    code='getgenv().Team="Marines"\nloadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/FindFruit.lua"))()' },
    { display="(Blox Fruits) Bounty Hunt Hop",                 code='getgenv().Config={Team="Pirates",HideUI=true}\nloadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/2ffcdb62773f587bfb9eb0d52bb35b0c.lua"))()' },
    { display="(Ink) Game Bypass",                             code='loadstring(game:HttpGet("https://raw.githubusercontent.com/eikikrkr-ux/bypasok/refs/heads/main/ok"))()' },
    { display="(DOORS) NullFire Hub",                          code='loadstring(game:HttpGet("https://raw.githubusercontent.com/TeamNullFire/NullFire/main/loader.lua"))()' },
    { display="(Universal) Orange Hub",                        code='loadstring(game:HttpGet("https://raw.githubusercontent.com/HieuDepTrai-Z/Dev_Orange/refs/heads/main/OrangeHub.lua"))()' },
    { display="(Blox Fruits) WhiteX BF-Beta",                  code='script_key="false"\nloadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua"))()' },
    { display="(Blox Fruits) SeraHub AutoBounty",              code='getgenv().config={["Team"]="Pirates",["BypassTp"]=true}\nloadstring(game:HttpGet("https://raw.githubusercontent.com/LumosSera/SeraHub/main/AutoBounty.lua"))()' },
    { display="(Blox Fruits) 99 Forest Gravity Hub",           code='loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua",true))()' },
}

-- ── Feature forward declarations ──────────────────────────────────────
-- (private state lives inside do...end blocks; only the functions persist)
local setIJToggle
local applyWalkSpeed, setSpeedToggle
local currentWalkSpeed = settings.speedVal
local speedEnabled     = settings.speedEnabled
local applySpin, setSpinToggle
local spinEnabled = settings.spinEnabled
local spinSpeed   = settings.spinSpeedVal
local startNoclip, stopNoclip, setNoclipToggle
local noclipEnabled = settings.noclipEnabled
local startFly, stopFly, setFlyToggle
local flyEnabled = settings.flyEnabled
local flySpeed   = settings.flySpeedVal
local createESP, enableESP, disableESP, setESPToggle
local espEnabled = settings.espEnabled
local applyHitbox, resetHitbox, setHitboxToggle
local hitboxEnabled = settings.hitboxEnabled
local hitboxSize    = settings.hitboxSizeVal
local getFlingRoot, startWalkFling, stopWalkFling, setFlingToggle
local setFullBrightToggle
local fullBrightEnabled = settings.fullBrightEnabled
local getAimbotPlayer, startAimbot, stopAimbot, setAimbotToggle
local aimbotEnabled = settings.aimbotEnabled
local aimbotMode    = settings.aimbotMode
local aimbotTarget  = settings.aimbotTarget
local setNoFallToggle
local noFallEnabled = false
local setWallWalkToggle
local wallWalkEnabled = false
local setZeroGravToggle
local zeroGravEnabled = false
local setFlingAllToggle
local flingAllEnabled = false
local flingAllMode    = settings.flingAllMode or "TP"
local stopTweenTP, setTweenTPToggle
local tweenTPEnabled = false
local tweenTPTarget  = settings.tweenTPTarget or ""
local tweenTPSpeed   = settings.tweenTPSpeed  or 50
local setNewAntiFlingToggle
local newAntiFlingEnabled = false
local doTargetTP, doTargetFling, doRejoin, doServerHop

-- IY feature forward declarations
local setFloatToggle, setSwimToggle, setAntiVoidToggle
local setNoRotateToggle, setStunToggle
local setBodyFlingToggle
local setReachToggle, startReach
local iyReachEnabled = false
local iyReachSize    = 60
local setAutoClickToggle
local applyXray, setXrayToggle
local stopHoverName, startHoverName, setHoverNameToggle
local setLightToggle
local doNaked, doNoFace, doClearHats
local stopHatSpin, startHatSpin, setHatSpinToggle
local iyLastDeath = nil
local doServerInfo, doDay, doNight
local setAutoRejoinToggle, setNoFogToggle

-- ───────────────────────────────────────────────────────────────
-- Feature Logic
-- ───────────────────────────────────────────────────────────────
do -- Infinite Jump
    local ijEnabled, ijConnection = false, nil
    setIJToggle = function(state)
        ijEnabled=state settings.ijEnabled=state saveSettings()
        if state then
            ijConnection=UserInputService.JumpRequest:Connect(function()
                local c=Players.LocalPlayer.Character
                local h=c and c:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        else if ijConnection then ijConnection:Disconnect() ijConnection=nil end end
    end
end

do -- Walk Speed
    applyWalkSpeed = function()
        local c=Players.LocalPlayer.Character
        if c and c:FindFirstChild("Humanoid") then c.Humanoid.WalkSpeed=speedEnabled and currentWalkSpeed or 16 end
    end
    setSpeedToggle = function(state)
        speedEnabled=state settings.speedEnabled=state saveSettings() applyWalkSpeed()
    end
    Players.LocalPlayer.CharacterAdded:Connect(function(c)
        c:WaitForChild("Humanoid") task.wait(0.2)
        c.Humanoid.WalkSpeed=speedEnabled and currentWalkSpeed or 16
    end)
end

do -- Spin
    applySpin = function()
        local c=Players.LocalPlayer.Character if not c then return end
        local r=c:FindFirstChild("HumanoidRootPart") if not r then return end
        for _,v in pairs(r:GetChildren()) do if v.Name=="USHSpin" then v:Destroy() end end
        if spinEnabled then
            local bav=Instance.new("BodyAngularVelocity")
            bav.Name="USHSpin" bav.MaxTorque=Vector3.new(0,math.huge,0)
            bav.AngularVelocity=Vector3.new(0,spinSpeed,0) bav.Parent=r
        end
    end
    setSpinToggle = function(state) spinEnabled=state settings.spinEnabled=state saveSettings() applySpin() end
    Players.LocalPlayer.CharacterAdded:Connect(function() task.wait(0.3) if spinEnabled then applySpin() end end)
end

do -- Noclip
    local noclipConn, noclipClip = nil, true
    startNoclip = function()
        noclipClip=false task.wait(0.1)
        noclipConn=RunService.Stepped:Connect(function()
            if not noclipClip and Players.LocalPlayer.Character then
                for _,child in pairs(Players.LocalPlayer.Character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide then child.CanCollide=false end
                end
            end
        end)
    end
    stopNoclip = function()
        if noclipConn then noclipConn:Disconnect() noclipConn=nil end noclipClip=true
    end
    setNoclipToggle = function(state)
        noclipEnabled=state settings.noclipEnabled=state saveSettings()
        if state then startNoclip() else stopNoclip() end
    end
    Players.LocalPlayer.CharacterAdded:Connect(function() if noclipEnabled then startNoclip() end end)
end

do -- Fly
    local FLYING=false
    local FLY_CONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}
    local FLY_LCONTROL={F=0,B=0,L=0,R=0,Q=0,E=0}
    local FLY_SPEED=0
    local flyHumanoid, flyRoot
    UserInputService.InputBegan:Connect(function(i,g)
        if g then return end
        if i.KeyCode==Enum.KeyCode.W then FLY_CONTROL.F=1 end
        if i.KeyCode==Enum.KeyCode.S then FLY_CONTROL.B=-1 end
        if i.KeyCode==Enum.KeyCode.A then FLY_CONTROL.L=-1 end
        if i.KeyCode==Enum.KeyCode.D then FLY_CONTROL.R=1 end
        if i.KeyCode==Enum.KeyCode.E then FLY_CONTROL.Q=1 end
        if i.KeyCode==Enum.KeyCode.Q then FLY_CONTROL.E=-1 end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.KeyCode==Enum.KeyCode.W then FLY_CONTROL.F=0 end
        if i.KeyCode==Enum.KeyCode.S then FLY_CONTROL.B=0 end
        if i.KeyCode==Enum.KeyCode.A then FLY_CONTROL.L=0 end
        if i.KeyCode==Enum.KeyCode.D then FLY_CONTROL.R=0 end
        if i.KeyCode==Enum.KeyCode.E then FLY_CONTROL.Q=0 end
        if i.KeyCode==Enum.KeyCode.Q then FLY_CONTROL.E=0 end
    end)
    startFly = function()
        FLYING=true
        local BG=Instance.new("BodyGyro") local BV=Instance.new("BodyVelocity")
        BG.P=9e4 BG.MaxTorque=Vector3.new(9e9,9e9,9e9) BG.CFrame=flyRoot.CFrame BG.Parent=flyRoot
        BV.Velocity=Vector3.new(0,0,0) BV.MaxForce=Vector3.new(9e9,9e9,9e9) BV.Parent=flyRoot
        task.spawn(function()
            repeat task.wait()
                local cam=workspace.CurrentCamera
                if flyHumanoid then flyHumanoid.PlatformStand=true end
                local mov=(FLY_CONTROL.L+FLY_CONTROL.R)~=0 or (FLY_CONTROL.F+FLY_CONTROL.B)~=0 or (FLY_CONTROL.Q+FLY_CONTROL.E)~=0
                FLY_SPEED=mov and flySpeed or 0
                if mov then
                    BV.Velocity=((cam.CFrame.LookVector*(FLY_CONTROL.F+FLY_CONTROL.B))+((cam.CFrame*CFrame.new(FLY_CONTROL.L+FLY_CONTROL.R,(FLY_CONTROL.F+FLY_CONTROL.B+FLY_CONTROL.Q+FLY_CONTROL.E)*0.2,0)).p-cam.CFrame.p))*FLY_SPEED
                    FLY_LCONTROL={F=FLY_CONTROL.F,B=FLY_CONTROL.B,L=FLY_CONTROL.L,R=FLY_CONTROL.R}
                elseif FLY_SPEED~=0 then
                    BV.Velocity=((cam.CFrame.LookVector*(FLY_LCONTROL.F+FLY_LCONTROL.B))+((cam.CFrame*CFrame.new(FLY_LCONTROL.L+FLY_LCONTROL.R,(FLY_LCONTROL.F+FLY_LCONTROL.B+FLY_CONTROL.Q+FLY_CONTROL.E)*0.2,0)).p-cam.CFrame.p))*FLY_SPEED
                else BV.Velocity=Vector3.new(0,0,0) end
                BG.CFrame=cam.CFrame
            until not FLYING
            FLY_CONTROL={F=0,B=0,L=0,R=0,Q=0,E=0} FLY_LCONTROL={F=0,B=0,L=0,R=0,Q=0,E=0} FLY_SPEED=0
            BG:Destroy() BV:Destroy()
            if flyHumanoid then flyHumanoid.PlatformStand=false end
        end)
    end
    stopFly = function() FLYING=false end
    setFlyToggle = function(state)
        flyEnabled=state settings.flyEnabled=state saveSettings()
        if state then
            local c=Players.LocalPlayer.Character
            if c then
                flyHumanoid=c:FindFirstChildOfClass("Humanoid")
                flyRoot=c:FindFirstChild("HumanoidRootPart")
                if flyHumanoid and flyRoot then startFly() end
            end
        else stopFly() end
    end
    Players.LocalPlayer.CharacterAdded:Connect(function(c)
        task.wait(0.3) if not flyEnabled then return end
        flyHumanoid=c:FindFirstChildOfClass("Humanoid")
        flyRoot=c:FindFirstChild("HumanoidRootPart")
        if flyHumanoid and flyRoot then startFly() end
    end)
end

do -- ESP
    local espObjects={}
    createESP = function(plr)
        if plr==Players.LocalPlayer then return end
        local function apply(char)
            if not espEnabled then return end
            local head=char:FindFirstChild("Head") if not head then return end
            local hl=Instance.new("Highlight") hl.Name="USHESP" hl.FillColor=Color3.fromRGB(255,0,0)
            hl.OutlineColor=Color3.fromRGB(255,0,0) hl.FillTransparency=0.5 hl.Parent=char
            local bill=Instance.new("BillboardGui") bill.Name="USHESPBill"
            bill.Size=UDim2.new(0,100,0,20) bill.StudsOffset=Vector3.new(0,2,0) bill.AlwaysOnTop=true bill.Parent=head
            local lbl=Instance.new("TextLabel",bill) lbl.Size=UDim2.new(1,0,1,0) lbl.BackgroundTransparency=1
            lbl.Text=plr.Name lbl.TextColor3=Color3.fromRGB(255,0,0) lbl.TextStrokeTransparency=0
            lbl.Font=Enum.Font.GothamBold lbl.TextScaled=true
            espObjects[plr]={hl,bill}
        end
        if plr.Character then apply(plr.Character) end
        plr.CharacterAdded:Connect(apply)
    end
    enableESP  = function() for _,p in pairs(Players:GetPlayers()) do createESP(p) end end
    disableESP = function()
        for _,objs in pairs(espObjects) do for _,o in pairs(objs) do if o and o.Parent then o:Destroy() end end end
        espObjects={}
    end
    setESPToggle = function(state)
        espEnabled=state settings.espEnabled=state saveSettings()
        if state then enableESP() else disableESP() end
    end
    Players.PlayerAdded:Connect(function(p) if espEnabled then createESP(p) end end)
end

do -- Hitbox
    applyHitbox = function(plr)
        if plr==Players.LocalPlayer or not hitboxEnabled then return end
        local c=plr.Character if not c then return end
        local r=c:FindFirstChild("HumanoidRootPart")
        if r and r:IsA("BasePart") then r.CanCollide=false r.Transparency=0.4
            r.Size=hitboxSize==1 and Vector3.new(2,1,1) or Vector3.new(hitboxSize,hitboxSize,hitboxSize)
        end
    end
    resetHitbox = function(plr)
        if plr==Players.LocalPlayer then return end
        local c=plr.Character if not c then return end
        local r=c:FindFirstChild("HumanoidRootPart")
        if r then r.Size=Vector3.new(2,2,1) r.Transparency=1 r.CanCollide=true end
    end
    setHitboxToggle = function(state)
        hitboxEnabled=state settings.hitboxEnabled=state saveSettings()
        if state then for _,p in pairs(Players:GetPlayers()) do applyHitbox(p) end
        else for _,p in pairs(Players:GetPlayers()) do resetHitbox(p) end end
    end
    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function() task.wait(0.3) if hitboxEnabled then applyHitbox(p) end end)
    end)
end

do -- WalkFling
    local walkflinging, flingDiedConn = false, nil
    getFlingRoot   = function() local c=Players.LocalPlayer.Character return c and c:FindFirstChild("HumanoidRootPart") end
    startWalkFling = function()
        if walkflinging then return end walkflinging=true
        local c=Players.LocalPlayer.Character if not c then return end
        local hum=c:FindFirstChildWhichIsA("Humanoid")
        if hum then flingDiedConn=hum.Died:Connect(function() walkflinging=false end) end
        task.spawn(function()
            local movel=0.1
            while walkflinging do
                RunService.Heartbeat:Wait() c=Players.LocalPlayer.Character local root=getFlingRoot()
                while not(c and c.Parent and root and root.Parent) do
                    RunService.Heartbeat:Wait() c=Players.LocalPlayer.Character root=getFlingRoot()
                    if not walkflinging then return end
                end
                local vel=root.Velocity root.Velocity=vel*10000+Vector3.new(0,10000,0)
                RunService.RenderStepped:Wait()
                if c and c.Parent and root and root.Parent then root.Velocity=vel end
                RunService.Stepped:Wait()
                if c and c.Parent and root and root.Parent then root.Velocity=vel+Vector3.new(0,movel,0) movel=-movel end
            end
        end)
    end
    stopWalkFling = function() walkflinging=false if flingDiedConn then flingDiedConn:Disconnect() flingDiedConn=nil end end
    setFlingToggle = function(state) settings.flingEnabled=state saveSettings() if state then startWalkFling() else stopWalkFling() end end
    Players.LocalPlayer.CharacterAdded:Connect(function() if walkflinging then task.wait(1) startWalkFling() end end)
end

do -- Full Bright
    local origLighting={
        Brightness=Lighting.Brightness, ClockTime=Lighting.ClockTime,
        FogEnd=Lighting.FogEnd, FogStart=Lighting.FogStart,
        Ambient=Lighting.Ambient, OutdoorAmbient=Lighting.OutdoorAmbient,
        GlobalShadows=Lighting.GlobalShadows,
    }
    setFullBrightToggle = function(state)
        fullBrightEnabled=state settings.fullBrightEnabled=state saveSettings()
        if state then
            Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.FogEnd=100000 Lighting.FogStart=100000
            Lighting.Ambient=Color3.fromRGB(178,178,178) Lighting.OutdoorAmbient=Color3.fromRGB(178,178,178) Lighting.GlobalShadows=false
            for _,e in pairs(Lighting:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("SunRaysEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled=false end
            end
        else
            Lighting.Brightness=origLighting.Brightness Lighting.ClockTime=origLighting.ClockTime
            Lighting.FogEnd=origLighting.FogEnd Lighting.FogStart=origLighting.FogStart
            Lighting.Ambient=origLighting.Ambient Lighting.OutdoorAmbient=origLighting.OutdoorAmbient
            Lighting.GlobalShadows=origLighting.GlobalShadows
            for _,e in pairs(Lighting:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("SunRaysEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled=true end
            end
        end
    end
    if settings.fullBrightEnabled then setFullBrightToggle(true) end
end

do -- Aimbot
    local aimbotConn=nil
    getAimbotPlayer = function()
        if aimbotMode=="Nearest" then
            local lc=Players.LocalPlayer.Character if not lc then return nil end
            local lr=lc:FindFirstChild("HumanoidRootPart") if not lr then return nil end
            local best,bestD=nil,math.huge
            for _,p in pairs(Players:GetPlayers()) do
                if p~=Players.LocalPlayer and p.Character then
                    local r=p.Character:FindFirstChild("HumanoidRootPart")
                    if r then local d=(r.Position-lr.Position).Magnitude if d<bestD then bestD=d best=p end end
                end
            end return best
        elseif aimbotMode=="Target" then return Players:FindFirstChild(aimbotTarget) end
    end
    startAimbot = function()
        aimbotConn=RunService.RenderStepped:Connect(function()
            local p=getAimbotPlayer() if not p or not p.Character then return end
            local h=p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart") if not h then return end
            workspace.CurrentCamera.CFrame=CFrame.new(workspace.CurrentCamera.CFrame.Position,h.Position)
        end)
    end
    stopAimbot = function() if aimbotConn then aimbotConn:Disconnect() aimbotConn=nil end end
    setAimbotToggle = function(state)
        aimbotEnabled=state settings.aimbotEnabled=state saveSettings()
        if state then startAimbot() else stopAimbot() end
    end
end

do -- No Fall
    local noFallConn=nil
    setNoFallToggle = function(state)
        noFallEnabled=state
        if state then
            noFallConn=RunService.Heartbeat:Connect(function()
                local c=Players.LocalPlayer.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local r=c.HumanoidRootPart local v=r.AssemblyLinearVelocity
                    if v.Y<-40 then r.AssemblyLinearVelocity=Vector3.new(v.X,-40,v.Z) end
                end
            end)
        else if noFallConn then noFallConn:Disconnect() noFallConn=nil end end
    end
    Players.LocalPlayer.CharacterAdded:Connect(function()
        if noFallEnabled then if noFallConn then noFallConn:Disconnect() noFallConn=nil end setNoFallToggle(true) end
    end)
end

do -- Wall Walk
    local wallWalkConn=nil
    setWallWalkToggle = function(state)
        wallWalkEnabled=state
        if state then
            wallWalkConn=RunService.RenderStepped:Connect(function()
                local c=Players.LocalPlayer.Character
                local hrp=c and c:FindFirstChild("HumanoidRootPart")
                local hum=c and c:FindFirstChildOfClass("Humanoid")
                if not(c and hrp and hum) then return end
                local p=RaycastParams.new() p.FilterDescendantsInstances={c} p.FilterType=Enum.RaycastFilterType.Exclude
                local res=workspace:Raycast(hrp.Position,hrp.CFrame.LookVector*2.5,p)
                if res and hum.MoveDirection.Magnitude>0 then
                    hrp.Velocity=Vector3.new(hrp.Velocity.X,hum.WalkSpeed*1.5,hrp.Velocity.Z)
                    if hum:GetState()~=Enum.HumanoidStateType.Climbing then hum:ChangeState(Enum.HumanoidStateType.Climbing) end
                end
            end)
        else
            if wallWalkConn then wallWalkConn:Disconnect() wallWalkConn=nil end
            local c=Players.LocalPlayer.Character local hum=c and c:FindFirstChildOfClass("Humanoid")
            if hum and hum:GetState()==Enum.HumanoidStateType.Climbing then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
        end
    end
    Players.LocalPlayer.CharacterAdded:Connect(function()
        if wallWalkEnabled then if wallWalkConn then wallWalkConn:Disconnect() wallWalkConn=nil end task.wait(0.3) setWallWalkToggle(true) end
    end)
end

do -- Zero Gravity
    local ZG_MAX=40
    local zeroGravConn,zeroGravForce,zeroGravAttach=nil,nil,nil
    setZeroGravToggle = function(state)
        zeroGravEnabled=state
        local c=Players.LocalPlayer.Character local root=c and c:FindFirstChild("HumanoidRootPart") local hum=c and c:FindFirstChildOfClass("Humanoid")
        if not(root and hum) then return end
        if state then
            hum.PlatformStand=true
            if root:FindFirstChild("USHZeroGravAttach") then root.USHZeroGravAttach:Destroy() end
            zeroGravAttach=Instance.new("Attachment",root) zeroGravAttach.Name="USHZeroGravAttach"
            zeroGravForce=Instance.new("VectorForce",root)
            zeroGravForce.Attachment0=zeroGravAttach zeroGravForce.RelativeTo=Enum.ActuatorRelativeTo.World zeroGravForce.ApplyAtCenterOfMass=true
            local mass=0 for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then mass=mass+p.Mass end end
            zeroGravForce.Force=Vector3.new(0,mass*workspace.Gravity,0)
            root.AssemblyLinearVelocity=workspace.CurrentCamera.CFrame.LookVector*5
            zeroGravConn=RunService.RenderStepped:Connect(function()
                if not zeroGravEnabled or not root or not root.Parent then return end
                local cam=workspace.CurrentCamera local md=hum.MoveDirection
                if md.Magnitude>0 then
                    local lk=cam.CFrame.LookVector local rt=cam.CFrame.RightVector
                    local fl=Vector3.new(lk.X,0,lk.Z) local fr=Vector3.new(rt.X,0,rt.Z)
                    if fl.Magnitude>0 then fl=fl.Unit end if fr.Magnitude>0 then fr=fr.Unit end
                    local fd=(lk*md:Dot(fl))+(rt*md:Dot(fr))
                    if fd.Magnitude>0 then root.AssemblyLinearVelocity=root.AssemblyLinearVelocity+(fd.Unit*1.5) end
                end
                if root.AssemblyLinearVelocity.Magnitude>ZG_MAX then root.AssemblyLinearVelocity=root.AssemblyLinearVelocity.Unit*ZG_MAX end
                root.AssemblyLinearVelocity=root.AssemblyLinearVelocity:Lerp(Vector3.zero,0.02)
            end)
        else
            if zeroGravConn then zeroGravConn:Disconnect() zeroGravConn=nil end
            if zeroGravForce then zeroGravForce:Destroy() zeroGravForce=nil end
            if zeroGravAttach then zeroGravAttach:Destroy() zeroGravAttach=nil end
            hum.PlatformStand=false hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
    Players.LocalPlayer.CharacterAdded:Connect(function() if zeroGravEnabled then task.wait(0.3) setZeroGravToggle(true) end end)
end

do -- Fling All
    setFlingAllToggle = function(state)
        flingAllEnabled=state
        if not state then return end
        task.spawn(function()
            while flingAllEnabled do
                local mc=Players.LocalPlayer.Character local mr=mc and mc:FindFirstChild("HumanoidRootPart")
                if mr then
                    for _,p in pairs(Players:GetPlayers()) do
                        if not flingAllEnabled then break end
                        if p~=Players.LocalPlayer and p.Character then
                            local tr=p.Character:FindFirstChild("HumanoidRootPart")
                            if tr then pcall(function()
                                if flingAllMode=="TP" then mr.CFrame=tr.CFrame+Vector3.new(2,0,0) task.wait(0.05) tr.Velocity=Vector3.new(math.random(-300,300),950,math.random(-300,300)) task.wait(0.15)
                                else local s=mr.CFrame local e=tr.CFrame+Vector3.new(2,0,0)
                                    for i=1,12 do if not flingAllEnabled then break end mr.CFrame=s:Lerp(e,i/12) task.wait(0.03) end
                                    tr.Velocity=Vector3.new(math.random(-300,300),950,math.random(-300,300)) task.wait(0.15) end
                            end) end
                        end
                    end
                end task.wait(0.5)
            end
        end)
    end
end

do -- Tween TP
    local tweenTPConn=nil
    stopTweenTP = function()
        tweenTPEnabled=false if tweenTPConn then tweenTPConn:Disconnect() tweenTPConn=nil end
        local c=Players.LocalPlayer.Character local hum=c and c:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand=false end if noclipEnabled then setNoclipToggle(false) end
    end
    setTweenTPToggle = function(state)
        if not state then stopTweenTP() return end
        local tgt=Players:FindFirstChild(tweenTPTarget) if not tgt or not tgt.Character then return end
        tweenTPEnabled=true setNoclipToggle(true)
        local c=Players.LocalPlayer.Character local hum=c and c:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand=true end
        tweenTPConn=RunService.Heartbeat:Connect(function(dt)
            if not tweenTPEnabled then return end
            local mc=Players.LocalPlayer.Character local mr=mc and mc:FindFirstChild("HumanoidRootPart")
            local tc=tgt.Character local tr=tc and tc:FindFirstChild("HumanoidRootPart")
            if not mr or not tr then stopTweenTP() return end
            local dist=(mr.Position-tr.Position).Magnitude
            if dist<4 then stopTweenTP() return end
            local dir=(tr.Position-mr.Position).Unit mr.CFrame=mr.CFrame+dir*tweenTPSpeed*dt
        end)
    end
    Players.LocalPlayer.CharacterAdded:Connect(function() if tweenTPEnabled then stopTweenTP() end end)
end

do -- AntiFling
    local newAntiFlingConn=nil
    setNewAntiFlingToggle = function(state)
        newAntiFlingEnabled=state
        if state then
            newAntiFlingConn=RunService.Stepped:Connect(function()
                for _,p in pairs(Players:GetPlayers()) do
                    if p~=Players.LocalPlayer and p.Character then
                        for _,part in pairs(p.Character:GetChildren()) do if part:IsA("BasePart") and part.CanCollide then part.CanCollide=false end end
                    end
                end
            end)
        else if newAntiFlingConn then newAntiFlingConn:Disconnect() newAntiFlingConn=nil end end
    end
end

do -- Target TP / Fling / Rejoin / ServerHop
    doTargetTP = function()
        local p=Players:FindFirstChild(aimbotTarget) if not p or not p.Character then return end
        local r=p.Character:FindFirstChild("HumanoidRootPart") if not r then return end
        local mc=Players.LocalPlayer.Character local mr=mc and mc:FindFirstChild("HumanoidRootPart")
        if mr then mr.CFrame=r.CFrame+Vector3.new(2,0,0) end
    end
    doTargetFling = function()
        local p=Players:FindFirstChild(aimbotTarget) if not p or not p.Character then return end
        local r=p.Character:FindFirstChild("HumanoidRootPart") if not r then return end
        pcall(function() r.Velocity=Vector3.new(math.random(-500,500),1000,math.random(-500,500)) end)
    end
    doRejoin = function()
        task.wait(0.5) pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,Players.LocalPlayer) end)
    end
    doServerHop = function()
        task.spawn(function()
            local TS=game:GetService("TeleportService") local HS=game:GetService("HttpService")
            local servers={} pcall(function()
                local url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
                local resp="" local req=(request or http_request or (syn and syn.request))
                if req then local r=req({Url=url,Method="GET"}) if r and r.Body then resp=r.Body end else resp=game:HttpGet(url) end
                if resp~="" then local d=HS:JSONDecode(resp) if d and d.data then
                    for _,s in ipairs(d.data) do if type(s)=="table" and s.id~=game.JobId and tonumber(s.playing) and tonumber(s.maxPlayers) and s.playing<(s.maxPlayers-1) then table.insert(servers,s.id) end end
                end end
            end)
            if #servers>0 then TS:TeleportToPlaceInstance(game.PlaceId,servers[math.random(1,#servers)],Players.LocalPlayer) end
        end)
    end
end

-- ─────────────────────────────────────────────
-- IY Source Features
-- ─────────────────────────────────────────────
do -- Float
    local iyFloatEnabled=false local iyFloatConn=nil local iyFloatPart=nil
    local iyFloatDied=nil local iyFloatVal=-3.1
    local iyFloatQD=nil local iyFloatED=nil
    local function stopFloat()
        iyFloatEnabled=false
        for _,c in pairs({iyFloatConn,iyFloatQD,iyFloatED,iyFloatDied}) do if c then pcall(function() c:Disconnect() end) end end
        iyFloatConn,iyFloatQD,iyFloatED,iyFloatDied=nil,nil,nil,nil
        if iyFloatPart and iyFloatPart.Parent then iyFloatPart:Destroy() end iyFloatPart=nil
    end
    local function startFloat()
        stopFloat() iyFloatEnabled=true iyFloatVal=-3.1
        local char=Players.LocalPlayer.Character if not char then return end
        local root=char:FindFirstChild("HumanoidRootPart") if not root then return end
        local Float=Instance.new("Part") Float.Name="IYFloatPad" Float.Transparency=1
        Float.Size=Vector3.new(2,0.2,1.5) Float.Anchored=true Float.CanCollide=false Float.Parent=char iyFloatPart=Float
        iyFloatQD=UserInputService.InputBegan:Connect(function(i,g)
            if g then return end
            if i.KeyCode==Enum.KeyCode.Q then iyFloatVal=iyFloatVal-0.5 end
            if i.KeyCode==Enum.KeyCode.E then iyFloatVal=iyFloatVal+1.5 end
        end)
        iyFloatED=UserInputService.InputEnded:Connect(function(i)
            if i.KeyCode==Enum.KeyCode.Q then iyFloatVal=iyFloatVal+0.5 end
            if i.KeyCode==Enum.KeyCode.E then iyFloatVal=iyFloatVal-1.5 end
        end)
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then iyFloatDied=hum.Died:Connect(function() stopFloat() end) end
        iyFloatConn=RunService.Heartbeat:Connect(function()
            local r=Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if r and Float.Parent then Float.CFrame=r.CFrame*CFrame.new(0,iyFloatVal,0) else stopFloat() end
        end)
    end
    setFloatToggle = function(state) if state then startFloat() else stopFloat() end end
end

do -- Swim
    local iySwimEnabled=false local iySwimConn=nil local iySwimDied=nil local iyOrigGrav=workspace.Gravity
    local function stopSwim()
        iySwimEnabled=false workspace.Gravity=iyOrigGrav
        if iySwimConn then iySwimConn:Disconnect() iySwimConn=nil end
        if iySwimDied then iySwimDied:Disconnect() iySwimDied=nil end
        local c=Players.LocalPlayer.Character local hum=c and c:FindFirstChildOfClass("Humanoid")
        if hum then for _,v in pairs(Enum.HumanoidStateType:GetEnumItems()) do if v~=Enum.HumanoidStateType.None then pcall(function() hum:SetStateEnabled(v,true) end) end end end
    end
    setSwimToggle = function(state)
        if not state then stopSwim() return end
        stopSwim() local c=Players.LocalPlayer.Character local hum=c and c:FindFirstChildOfClass("Humanoid") if not hum then return end
        iySwimEnabled=true iyOrigGrav=workspace.Gravity workspace.Gravity=0
        iySwimDied=hum.Died:Connect(function() workspace.Gravity=iyOrigGrav iySwimEnabled=false end)
        for _,v in pairs(Enum.HumanoidStateType:GetEnumItems()) do if v~=Enum.HumanoidStateType.None then pcall(function() hum:SetStateEnabled(v,false) end) end end
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Swimming) end)
        iySwimConn=RunService.Heartbeat:Connect(function()
            local ch=Players.LocalPlayer.Character local r=ch and ch:FindFirstChild("HumanoidRootPart") local h=ch and ch:FindFirstChildOfClass("Humanoid")
            if r and h and h.MoveDirection==Vector3.new() then r.Velocity=Vector3.new(0,0,0) end
        end)
    end
end

do -- AntiVoid
    local iyAntiVoidEnabled=false local iyAntiVoidConn=nil local IY_DH=workspace.FallenPartsDestroyHeight
    setAntiVoidToggle = function(state)
        iyAntiVoidEnabled=state
        if state then iyAntiVoidConn=RunService.Stepped:Connect(function()
            local c=Players.LocalPlayer.Character local r=c and c:FindFirstChild("HumanoidRootPart")
            if r and r.Position.Y<=IY_DH+25 then r.Velocity=r.Velocity+Vector3.new(0,250,0) end
        end)
        else if iyAntiVoidConn then iyAntiVoidConn:Disconnect() iyAntiVoidConn=nil end end
    end
end

do -- NoRotate
    local iyNoRotateEnabled=false
    setNoRotateToggle = function(state)
        iyNoRotateEnabled=state local c=Players.LocalPlayer.Character local h=c and c:FindFirstChildOfClass("Humanoid")
        if h then h.AutoRotate=not state end
    end
    Players.LocalPlayer.CharacterAdded:Connect(function(c)
        local h=c:WaitForChild("Humanoid") if iyNoRotateEnabled then task.wait(0.2) h.AutoRotate=false end
    end)
end

do -- Stun
    local iyStunEnabled=false
    setStunToggle = function(state)
        iyStunEnabled=state local c=Players.LocalPlayer.Character local h=c and c:FindFirstChildOfClass("Humanoid")
        if h then h.PlatformStand=state end
    end
end

do -- Body Fling
    local iyBodyFlingEnabled=false
    local function stopBodyFling()
        iyBodyFlingEnabled=false setNoclipToggle(false)
        local c=Players.LocalPlayer.Character local r=c and c:FindFirstChild("HumanoidRootPart")
        if r then for _,v in pairs(r:GetChildren()) do if v:IsA("BodyAngularVelocity") and v.Name=="IYBodyFling" then v:Destroy() end end end
        if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.CustomPhysicalProperties=nil end) pcall(function() p.Massless=false end) end end end
    end
    setBodyFlingToggle = function(state)
        if not state then stopBodyFling() return end
        if iyBodyFlingEnabled then return end
        local c=Players.LocalPlayer.Character local r=c and c:FindFirstChild("HumanoidRootPart") if not r then return end
        for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.CustomPhysicalProperties=PhysicalProperties.new(100,0.3,0.5) end) pcall(function() p.CanCollide=false p.Massless=true end) end end
        setNoclipToggle(true)
        local bav=Instance.new("BodyAngularVelocity") bav.Name="IYBodyFling" bav.Parent=r
        bav.MaxTorque=Vector3.new(0,math.huge,0) bav.P=math.huge bav.AngularVelocity=Vector3.new(0,99999,0)
        iyBodyFlingEnabled=true
        local hum=c:FindFirstChildOfClass("Humanoid") if hum then hum.Died:Connect(function() stopBodyFling() end) end
        task.spawn(function()
            while iyBodyFlingEnabled do
                if bav.Parent then bav.AngularVelocity=Vector3.new(0,99999,0) task.wait(0.2)
                    if iyBodyFlingEnabled then bav.AngularVelocity=Vector3.new(0,0,0) task.wait(0.1) end
                else stopBodyFling() break end
            end
        end)
    end
end

do -- Reach
    local iyOrigSize, iyOrigGrip = nil, nil
    local function stopReach()
        iyReachEnabled=false local c=Players.LocalPlayer.Character if not c then return end
        for _,v in pairs(c:GetDescendants()) do if v:IsA("Tool") and v:FindFirstChild("Handle") then
            if iyOrigSize then v.Handle.Size=iyOrigSize end if iyOrigGrip then v.GripPos=iyOrigGrip end
            local sb=v.Handle:FindFirstChild("IYSelBox") if sb then sb:Destroy() end
        end end iyOrigSize=nil iyOrigGrip=nil
    end
    startReach = function(size)
        stopReach() iyReachSize=size or 60 iyReachEnabled=true
        local c=Players.LocalPlayer.Character if not c then return end
        for _,v in pairs(c:GetDescendants()) do if v:IsA("Tool") and v:FindFirstChild("Handle") then
            iyOrigSize=v.Handle.Size iyOrigGrip=v.GripPos
            local sb=Instance.new("SelectionBox") sb.Name="IYSelBox" sb.Adornee=v.Handle sb.Parent=v.Handle
            v.Handle.Massless=true v.Handle.Size=Vector3.new(0.5,0.5,iyReachSize) v.GripPos=Vector3.new(0,0,0)
        end end
    end
    setReachToggle = function(state) if state then startReach(iyReachSize) else stopReach() end end
end

do -- Auto Click
    local iyAutoClickEnabled=false local iyAutoClickConn=nil
    setAutoClickToggle = function(state)
        iyAutoClickEnabled=state
        if state then iyAutoClickConn=RunService.Heartbeat:Connect(function()
            pcall(function() if mouse1click then mouse1click() elseif mouse1press and mouse1release then mouse1press() mouse1release() end end)
        end)
        else if iyAutoClickConn then iyAutoClickConn:Disconnect() iyAutoClickConn=nil end end
    end
end

do -- Xray
    local iyXrayEnabled=false local iyXrayConn=nil local iyXrayOrig={}
    applyXray = function(on)
        for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then
            local inChar=false local p=v.Parent
            if p then if p:FindFirstChildWhichIsA("Humanoid") then inChar=true end
                if p.Parent and p.Parent:FindFirstChildWhichIsA("Humanoid") then inChar=true end end
            if not inChar then pcall(function()
                if on then if iyXrayOrig[v]==nil then iyXrayOrig[v]=v.LocalTransparencyModifier end v.LocalTransparencyModifier=0.75
                else v.LocalTransparencyModifier=(iyXrayOrig[v]~=nil) and iyXrayOrig[v] or 0 end
            end) end
        end end
        if not on then iyXrayOrig={} end
    end
    setXrayToggle = function(state)
        iyXrayEnabled=state if iyXrayConn then iyXrayConn:Disconnect() iyXrayConn=nil end
        if state then applyXray(true) iyXrayConn=RunService.RenderStepped:Connect(function() applyXray(true) end)
        else applyXray(false) end
    end
end

do -- Hover Name
    local iyHoverEnabled=false local iyHoverGui=nil local iyHoverConn=nil
    stopHoverName = function()
        iyHoverEnabled=false if iyHoverConn then iyHoverConn:Disconnect() iyHoverConn=nil end
        if iyHoverGui and iyHoverGui.Parent then iyHoverGui:Destroy() iyHoverGui=nil end
    end
    startHoverName = function()
        stopHoverName() iyHoverEnabled=true
        local SGui=Instance.new("ScreenGui") SGui.Name="IYHoverName" SGui.ResetOnSpawn=false
        SGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling SGui.Parent=playerGui iyHoverGui=SGui
        local lbl=Instance.new("TextLabel") lbl.BackgroundTransparency=1 lbl.Size=UDim2.new(0,220,0,30)
        lbl.Font=Enum.Font.Code lbl.TextSize=16 lbl.Text="" lbl.TextColor3=Color3.new(1,1,1)
        lbl.TextStrokeTransparency=0 lbl.ZIndex=10 lbl.Visible=false lbl.Parent=SGui
        local selBox=Instance.new("SelectionBox") selBox.LineThickness=0.03 selBox.Color3=Color3.new(1,1,1) selBox.Parent=SGui
        local mouse=player:GetMouse()
        iyHoverConn=mouse.Move:Connect(function()
            local t=mouse.Target if t then
                local hum=t.Parent:FindFirstChildWhichIsA("Humanoid") or t.Parent.Parent:FindFirstChildWhichIsA("Humanoid")
                if hum then local x,y=mouse.X,mouse.Y lbl.Position=UDim2.new(0,x>220 and x-225 or x+10,0,y)
                    lbl.Text=hum.Parent.Name lbl.Visible=true selBox.Adornee=hum.Parent return end
            end lbl.Visible=false selBox.Adornee=nil
        end)
    end
    setHoverNameToggle = function(state) if state then startHoverName() else stopHoverName() end end
end

do -- Character Light
    local iyLightEnabled=false local iyLightObj=nil
    setLightToggle = function(state)
        iyLightEnabled=state if iyLightObj and iyLightObj.Parent then iyLightObj:Destroy() iyLightObj=nil end
        if state then local c=Players.LocalPlayer.Character local r=c and c:FindFirstChild("HumanoidRootPart")
            if r then local pl=Instance.new("PointLight") pl.Brightness=5 pl.Range=20 pl.Parent=r iyLightObj=pl end end
    end
end

do -- Character tweaks
    doNaked  = function() local c=Players.LocalPlayer.Character if not c then return end for _,v in pairs(c:GetDescendants()) do if v:IsA("Clothing") or v:IsA("ShirtGraphic") then v:Destroy() end end end
    doNoFace = function() local c=Players.LocalPlayer.Character if not c then return end for _,v in pairs(c:GetDescendants()) do if v:IsA("Decal") and v.Name:lower()=="face" then v:Destroy() end end end
    doClearHats=function() local c=Players.LocalPlayer.Character if not c then return end local h=c:FindFirstChildOfClass("Humanoid") if h then for _,a in pairs(h:GetAccessories()) do a:Destroy() end end end
end

do -- Hat Spin
    local iyHatSpinEnabled=false local iyHatSpinConn=nil
    stopHatSpin = function()
        iyHatSpinEnabled=false if iyHatSpinConn then iyHatSpinConn:Disconnect() iyHatSpinConn=nil end
    end
    startHatSpin = function(speed)
        stopHatSpin() speed=speed or 100 iyHatSpinEnabled=true
        local c=Players.LocalPlayer.Character local h=c and c:FindFirstChildOfClass("Humanoid") if not h then return end
        for _,acc in pairs(h:GetAccessories()) do local handle=acc:FindFirstChild("Handle") if handle then
            local w=handle:FindFirstChildWhichIsA("Weld") if w then pcall(function() w:Destroy() end) end
            local bp=Instance.new("BodyPosition") bp.P=30000 bp.D=50 bp.Parent=handle
            local bav=Instance.new("BodyAngularVelocity") bav.AngularVelocity=Vector3.new(0,speed,0)
            bav.MaxTorque=Vector3.new(0,speed*2,0) bav.Parent=handle
        end end
        iyHatSpinConn=RunService.Stepped:Connect(function()
            local ch=Players.LocalPlayer.Character local head=ch and ch:FindFirstChild("Head") local h2=ch and ch:FindFirstChildOfClass("Humanoid")
            if head and h2 then for _,acc in pairs(h2:GetAccessories()) do local handle=acc:FindFirstChild("Handle")
                local bpI=handle and handle:FindFirstChildOfClass("BodyPosition")
                if bpI then pcall(function() bpI.Position=head.Position end) end
            end end
        end)
    end
    setHatSpinToggle = function(state) if state then startHatSpin(100) else stopHatSpin() end end
end

-- Last death tracker
Players.LocalPlayer.CharacterAdded:Connect(function(char)
    local hum=char:WaitForChild("Humanoid")
    hum.Died:Connect(function() local r=char:FindFirstChild("HumanoidRootPart") if r then iyLastDeath=r.CFrame end end)
end)

do -- Server Info / AutoRejoin / Day/Night / NoFog
    local origFogEnd,origFogStart=Lighting.FogEnd,Lighting.FogStart
    local iyNoFogEnabled=false local iyNoFogConn=nil
    local iyAutoRejoinEnabled=false local iyAutoRejoinConn=nil

    doServerInfo = function()
        local ok,ping=pcall(function() return Players:GetNetworkPing() end)
        local pStr=(ok and ping) and string.format("%.0fms",ping*1000) or "N/A"
        return "PlaceId:"..game.PlaceId.."\nPlayers:"..#Players:GetPlayers().."/"..Players.MaxPlayers.."\nPing:"..pStr.."\nJobId:"..game.JobId:sub(1,16).."..."
    end
    setAutoRejoinToggle = function(state)
        iyAutoRejoinEnabled=state if iyAutoRejoinConn then iyAutoRejoinConn:Disconnect() iyAutoRejoinConn=nil end
        if state then pcall(function()
            iyAutoRejoinConn=game:GetService("GuiService"):GetPropertyChangedSignal("ErrorMessage"):Connect(function()
                if game:GetService("GuiService").ErrorMessage~="" then task.delay(0.5,doRejoin) end
            end)
        end) end
    end
    doDay   = function() Lighting.ClockTime=14 Lighting.Brightness=2 Lighting.GlobalShadows=true end
    doNight = function() Lighting.ClockTime=0 Lighting.Brightness=0 Lighting.GlobalShadows=false end
    setNoFogToggle = function(state)
        iyNoFogEnabled=state if iyNoFogConn then iyNoFogConn:Disconnect() iyNoFogConn=nil end
        if state then Lighting.FogEnd=100000 Lighting.FogStart=100000
            iyNoFogConn=RunService.RenderStepped:Connect(function() Lighting.FogEnd=100000 Lighting.FogStart=100000 end)
        else Lighting.FogEnd=origFogEnd Lighting.FogStart=origFogStart end
    end
end

-- ───────────────────────────────────────────────────────────────
-- Hub State
-- ───────────────────────────────────────────────────────────────
local killScript
local hubVisible = true
local hubKilled  = false
local _floatGui  = nil

-- ───────────────────────────────────────────────────────────────
-- Colors
-- ───────────────────────────────────────────────────────────────
local C = {
    bg=Color3.fromRGB(13,13,22), sidebar=Color3.fromRGB(18,18,30),
    tabActive=Color3.fromRGB(55,100,230), tabHover=Color3.fromRGB(35,55,120),
    tabInact=Color3.fromRGB(22,22,38), section=Color3.fromRGB(28,28,48),
    item=Color3.fromRGB(22,22,38), togOn=Color3.fromRGB(45,185,90),
    togOff=Color3.fromRGB(55,55,80), btn=Color3.fromRGB(50,55,90),
    btnHov=Color3.fromRGB(65,75,130), accent=Color3.fromRGB(70,110,240),
    text=Color3.fromRGB(225,225,255), textDim=Color3.fromRGB(130,130,175),
    textSec=Color3.fromRGB(90,90,140), stroke=Color3.fromRGB(50,50,100),
    danger=Color3.fromRGB(200,55,55), dangerHov=Color3.fromRGB(230,80,80),
}

-- ───────────────────────────────────────────────────────────────
-- Notification System
-- ───────────────────────────────────────────────────────────────
local notifGui = nil
local notify = function(title, content, duration)
    pcall(function() if notifGui then notifGui:Destroy() notifGui=nil end end)
    duration=duration or 3
    local sg=Instance.new("ScreenGui") sg.Name="USHNotif" sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder=200 sg.ResetOnSpawn=false sg.Parent=playerGui notifGui=sg
    local frame=Instance.new("Frame") frame.Size=UDim2.new(0,300,0,72) frame.AnchorPoint=Vector2.new(0.5,1)
    frame.Position=UDim2.new(0.5,0,1,-20) frame.BackgroundColor3=Color3.fromRGB(18,18,32) frame.BorderSizePixel=0 frame.Parent=sg
    local cr=Instance.new("UICorner",frame) cr.CornerRadius=UDim.new(0,12)
    local stroke=Instance.new("UIStroke",frame) stroke.Color=C.accent stroke.Thickness=1.5
    local bar=Instance.new("Frame",frame) bar.Size=UDim2.new(0,4,1,-20) bar.Position=UDim2.new(0,0,0,10)
    bar.BackgroundColor3=C.accent bar.BorderSizePixel=0
    local bc=Instance.new("UICorner",bar) bc.CornerRadius=UDim.new(0,4)
    local t=Instance.new("TextLabel",frame) t.Size=UDim2.new(1,-18,0,24) t.Position=UDim2.new(0,14,0,8)
    t.BackgroundTransparency=1 t.Text=title t.TextColor3=C.text t.TextSize=14
    t.Font=Enum.Font.GothamBold t.TextXAlignment=Enum.TextXAlignment.Left
    local c=Instance.new("TextLabel",frame) c.Size=UDim2.new(1,-18,0,32) c.Position=UDim2.new(0,14,0,34)
    c.BackgroundTransparency=1 c.Text=content c.TextColor3=C.textDim c.TextSize=12
    c.Font=Enum.Font.Gotham c.TextXAlignment=Enum.TextXAlignment.Left c.TextWrapped=true
    frame.Position=UDim2.new(0.5,0,1,80)
    TweenService:Create(frame,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,1,-20)}):Play()
    task.delay(duration,function()
        if sg and sg.Parent then
            TweenService:Create(frame,TweenInfo.new(0.25),{Position=UDim2.new(0.5,0,1,90)}):Play()
            task.wait(0.3) pcall(function() sg:Destroy() notifGui=nil end)
        end
    end)
end

-- ───────────────────────────────────────────────────────────────
-- UI Component Builders
-- ───────────────────────────────────────────────────────────────
local function addCorner(p, r) local c=Instance.new("UICorner",p) c.CornerRadius=UDim.new(0,r or 8) return c end
local function addStroke(p, col, th) local s=Instance.new("UIStroke",p) s.Color=col or C.stroke s.Thickness=th or 1.2 return s end

local function createSection(parent, title)
    local f=Instance.new("Frame") f.Size=UDim2.new(1,0,0,32) f.BackgroundColor3=C.section f.BorderSizePixel=0 f.Parent=parent addCorner(f,6)
    local accent=Instance.new("Frame",f) accent.Size=UDim2.new(0,3,1,0) accent.BackgroundColor3=C.accent accent.BorderSizePixel=0 addCorner(accent,3)
    local lbl=Instance.new("TextLabel",f) lbl.Size=UDim2.new(1,-14,1,0) lbl.Position=UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency=1 lbl.Text=title lbl.TextColor3=C.textDim
    lbl.TextSize=12 lbl.Font=Enum.Font.GothamBold lbl.TextXAlignment=Enum.TextXAlignment.Left
end

local function createToggle(parent, label, initial, onChange)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,42) row.BackgroundColor3=C.item row.BorderSizePixel=0 row.Parent=parent addCorner(row,7) addStroke(row)
    local lbl=Instance.new("TextLabel",row) lbl.Size=UDim2.new(1,-78,1,0) lbl.Position=UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency=1 lbl.Text=label lbl.TextColor3=C.text lbl.TextSize=12
    lbl.Font=Enum.Font.Gotham lbl.TextXAlignment=Enum.TextXAlignment.Left lbl.TextWrapped=true
    local btn=Instance.new("TextButton",row) btn.Size=UDim2.new(0,60,0,28) btn.Position=UDim2.new(1,-68,0.5,-14)
    btn.BackgroundColor3=initial and C.togOn or C.togOff btn.BorderSizePixel=0
    btn.Text=initial and "ON" or "OFF" btn.TextColor3=Color3.new(1,1,1) btn.TextSize=12 btn.Font=Enum.Font.GothamBold addCorner(btn,14)
    local state=initial
    local function setState(s) state=s btn.BackgroundColor3=s and C.togOn or C.togOff btn.Text=s and "ON" or "OFF" end
    btn.MouseButton1Click:Connect(function() setState(not state) onChange(state) end)
    return row, setState
end

local function createButton(parent, label, danger, onClick)
    if type(danger)=="function" then onClick=danger danger=false end
    local btn=Instance.new("TextButton") btn.Size=UDim2.new(1,0,0,40) btn.BackgroundColor3=danger and C.danger or C.btn
    btn.BorderSizePixel=0 btn.Text=label btn.TextColor3=C.text btn.TextSize=12
    btn.Font=Enum.Font.GothamBold btn.Parent=parent addCorner(btn,8) btn.TextWrapped=true
    btn.MouseEnter:Connect(function() TweenService:Create(btn,TweenInfo.new(0.12),{BackgroundColor3=danger and C.dangerHov or C.btnHov}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn,TweenInfo.new(0.12),{BackgroundColor3=danger and C.danger or C.btn}):Play() end)
    btn.MouseButton1Click:Connect(onClick)
    return btn
end

local function createSlider(parent, label, min, max, step, initial, suffix, onChange)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,50) row.BackgroundColor3=C.item row.BorderSizePixel=0 row.Parent=parent addCorner(row,7) addStroke(row)
    local lbl=Instance.new("TextLabel",row) lbl.Size=UDim2.new(1,-10,0,22) lbl.Position=UDim2.new(0,10,0,4)
    lbl.BackgroundTransparency=1 lbl.Text=label lbl.TextColor3=C.text lbl.TextSize=12 lbl.Font=Enum.Font.Gotham lbl.TextXAlignment=Enum.TextXAlignment.Left
    local val=initial
    local disp=Instance.new("TextLabel",row) disp.Size=UDim2.new(0,70,0,24) disp.Position=UDim2.new(0.5,-35,1,-28)
    disp.BackgroundColor3=Color3.fromRGB(30,30,50) disp.BorderSizePixel=0
    disp.Text=tostring(val)..(suffix or "") disp.TextColor3=C.text disp.TextSize=12 disp.Font=Enum.Font.GothamBold addCorner(disp,5)
    local function clamp(v) return math.max(min,math.min(max,math.floor(v/step+0.5)*step)) end
    local function update(v) val=clamp(v) disp.Text=tostring(val)..(suffix or "") onChange(val) end
    local minus=Instance.new("TextButton",row) minus.Size=UDim2.new(0,32,0,24) minus.Position=UDim2.new(0.5,-105,1,-28)
    minus.BackgroundColor3=C.btn minus.BorderSizePixel=0 minus.Text="−" minus.TextColor3=C.text minus.TextSize=16 minus.Font=Enum.Font.GothamBold addCorner(minus,5)
    local plus=Instance.new("TextButton",row) plus.Size=UDim2.new(0,32,0,24) plus.Position=UDim2.new(0.5,39,1,-28)
    plus.BackgroundColor3=C.btn plus.BorderSizePixel=0 plus.Text="+" plus.TextColor3=C.text plus.TextSize=16 plus.Font=Enum.Font.GothamBold addCorner(plus,5)
    minus.MouseButton1Click:Connect(function() update(val-step) end)
    plus.MouseButton1Click:Connect(function() update(val+step) end)
    for _,b in pairs({minus,plus}) do local dir=b==plus and 1 or -1 local held=false
        b.MouseButton1Down:Connect(function() held=true task.delay(0.5,function() while held do update(val+dir*step) task.wait(0.08) end end) end)
        b.MouseButton1Up:Connect(function() held=false end)
    end
end

local function createDropdown(parent, label, options, initial, onChange)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,42) row.BackgroundColor3=C.item row.BorderSizePixel=0 row.Parent=parent addCorner(row,7) addStroke(row)
    local lbl=Instance.new("TextLabel",row) lbl.Size=UDim2.new(0.45,0,1,0) lbl.Position=UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency=1 lbl.Text=label lbl.TextColor3=C.text lbl.TextSize=12
    lbl.Font=Enum.Font.Gotham lbl.TextXAlignment=Enum.TextXAlignment.Left
    local idx=1 for i,v in ipairs(options) do if v==initial then idx=i break end end
    local btn=Instance.new("TextButton",row) btn.Size=UDim2.new(0.5,-10,0,28) btn.Position=UDim2.new(0.5,0,0.5,-14)
    btn.BackgroundColor3=C.btn btn.BorderSizePixel=0 btn.TextColor3=C.text btn.TextSize=12 btn.Font=Enum.Font.GothamBold
    btn.Text=(options[idx] or "?").." ▼" addCorner(btn,7)
    btn.MouseButton1Click:Connect(function() idx=idx%#options+1 btn.Text=options[idx].." ▼" onChange(options[idx]) end)
end

local function createInput(parent, label, placeholder, onChange)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,50) row.BackgroundColor3=C.item row.BorderSizePixel=0 row.Parent=parent addCorner(row,7) addStroke(row)
    local lbl=Instance.new("TextLabel",row) lbl.Size=UDim2.new(1,-10,0,20) lbl.Position=UDim2.new(0,10,0,4)
    lbl.BackgroundTransparency=1 lbl.Text=label lbl.TextColor3=C.textDim lbl.TextSize=11 lbl.Font=Enum.Font.Gotham lbl.TextXAlignment=Enum.TextXAlignment.Left
    local box=Instance.new("TextBox",row) box.Size=UDim2.new(1,-20,0,24) box.Position=UDim2.new(0,10,1,-28)
    box.BackgroundColor3=Color3.fromRGB(20,20,40) box.BorderSizePixel=0 box.PlaceholderText=placeholder or ""
    box.PlaceholderColor3=C.textSec box.Text="" box.TextColor3=C.text box.TextSize=12 box.Font=Enum.Font.Gotham
    box.ClearTextOnFocus=false addCorner(box,5) addStroke(box,C.accent,1)
    box.FocusLost:Connect(function() if onChange then onChange(box.Text) end end)
    return row, box
end

local function createParagraph(parent, title, body)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,1) row.AutomaticSize=Enum.AutomaticSize.Y
    row.BackgroundColor3=C.section row.BorderSizePixel=0 row.Parent=parent addCorner(row,7)
    local t=Instance.new("TextLabel",row) t.Size=UDim2.new(1,-16,0,20) t.Position=UDim2.new(0,8,0,6)
    t.BackgroundTransparency=1 t.Text=title t.TextColor3=C.accent t.TextSize=12 t.Font=Enum.Font.GothamBold t.TextXAlignment=Enum.TextXAlignment.Left
    local b=Instance.new("TextLabel",row) b.Size=UDim2.new(1,-16,0,1) b.AutomaticSize=Enum.AutomaticSize.Y
    b.Position=UDim2.new(0,8,0,26) b.BackgroundTransparency=1 b.Text=body
    b.TextColor3=C.textDim b.TextSize=11 b.Font=Enum.Font.Gotham b.TextXAlignment=Enum.TextXAlignment.Left b.TextWrapped=true
    local pd=Instance.new("UIPadding",b) pd.PaddingBottom=UDim.new(0,8)
end

local function addSpacer(parent, h) local f=Instance.new("Frame",parent) f.Size=UDim2.new(1,0,0,h or 6) f.BackgroundTransparency=1 end

-- ───────────────────────────────────────────────────────────────
-- Main Window
-- ───────────────────────────────────────────────────────────────
local WIN_W, WIN_H = 540, 420
local HubGui = Instance.new("ScreenGui")
HubGui.Name="USHNormalGui" HubGui.ResetOnSpawn=false HubGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling HubGui.DisplayOrder=10 HubGui.Parent=playerGui

local Window = Instance.new("Frame")
Window.Name="Window" Window.Size=UDim2.new(0,WIN_W,0,WIN_H)
Window.Position=UDim2.new(0.5,-WIN_W/2,0.5,-WIN_H/2)
Window.BackgroundColor3=C.bg Window.BorderSizePixel=0 Window.Parent=HubGui
addCorner(Window,14) addStroke(Window,C.accent,1.5)

local TitleBar = Instance.new("Frame",Window)
TitleBar.Size=UDim2.new(1,0,0,42) TitleBar.BackgroundColor3=C.sidebar TitleBar.BorderSizePixel=0 addCorner(TitleBar,14)
local TBCover=Instance.new("Frame",TitleBar) TBCover.Size=UDim2.new(1,0,0.5,0) TBCover.Position=UDim2.new(0,0,0.5,0) TBCover.BackgroundColor3=C.sidebar TBCover.BorderSizePixel=0
local accentLine=Instance.new("Frame",TitleBar) accentLine.Size=UDim2.new(1,0,0,3) accentLine.Position=UDim2.new(0,0,1,-3) accentLine.BackgroundColor3=C.accent accentLine.BorderSizePixel=0
Instance.new("UIGradient",accentLine).Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.accent),ColorSequenceKeypoint.new(1,Color3.fromRGB(140,60,255))})
local TitleLbl=Instance.new("TextLabel",TitleBar) TitleLbl.Size=UDim2.new(1,-100,1,0) TitleLbl.Position=UDim2.new(0,14,0,0)
TitleLbl.BackgroundTransparency=1 TitleLbl.Text="⚡  Universal Sun Hub" TitleLbl.TextColor3=C.text TitleLbl.TextSize=15 TitleLbl.Font=Enum.Font.GothamBold TitleLbl.TextXAlignment=Enum.TextXAlignment.Left

local function makeHeaderBtn(icon, xOff, col)
    local b=Instance.new("TextButton",TitleBar) b.Size=UDim2.new(0,28,0,28) b.Position=UDim2.new(1,xOff,0.5,-14)
    b.BackgroundColor3=col b.BorderSizePixel=0 b.Text=icon b.TextColor3=Color3.new(1,1,1) b.TextSize=13 b.Font=Enum.Font.GothamBold addCorner(b,14) return b
end
local MinBtn    = makeHeaderBtn("—", -68, Color3.fromRGB(200,160,30))
local CloseBtn2 = makeHeaderBtn("✕", -34, Color3.fromRGB(200,50,50))

local ContentHost=Instance.new("Frame",Window)
ContentHost.Size=UDim2.new(1,0,1,-42) ContentHost.Position=UDim2.new(0,0,0,42) ContentHost.BackgroundTransparency=1 ContentHost.BorderSizePixel=0

local Sidebar=Instance.new("Frame",ContentHost)
Sidebar.Size=UDim2.new(0,110,1,0) Sidebar.BackgroundColor3=C.sidebar Sidebar.BorderSizePixel=0
local SBLayout=Instance.new("UIListLayout",Sidebar) SBLayout.SortOrder=Enum.SortOrder.LayoutOrder SBLayout.Padding=UDim.new(0,4)
local SBPad=Instance.new("UIPadding",Sidebar) SBPad.PaddingTop=UDim.new(0,8)

local TabArea=Instance.new("Frame",ContentHost)
TabArea.Size=UDim2.new(1,-114,1,0) TabArea.Position=UDim2.new(0,114,0,0) TabArea.BackgroundTransparency=1 TabArea.BorderSizePixel=0

-- Tab system
local tabPages  = {}
local tabBtns   = {}
local currentTab = nil

local function makePage()
    local scroll=Instance.new("ScrollingFrame") scroll.Size=UDim2.new(1,0,1,0) scroll.CanvasSize=UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y scroll.ScrollBarThickness=4
    scroll.ScrollBarImageColor3=C.accent scroll.BackgroundTransparency=1 scroll.BorderSizePixel=0 scroll.Visible=false scroll.Parent=TabArea
    local layout=Instance.new("UIListLayout",scroll) layout.SortOrder=Enum.SortOrder.LayoutOrder layout.Padding=UDim.new(0,5)
    local pad=Instance.new("UIPadding",scroll) pad.PaddingLeft=UDim.new(0,6) pad.PaddingRight=UDim.new(0,6) pad.PaddingTop=UDim.new(0,6) pad.PaddingBottom=UDim.new(0,6)
    return scroll
end

local function makeTabBtn(name, icon, order)
    local btn=Instance.new("TextButton",Sidebar)
    btn.Size=UDim2.new(1,-8,0,38) btn.BackgroundColor3=C.tabInact btn.BorderSizePixel=0
    btn.Text=icon.."  "..name btn.TextColor3=C.textDim btn.TextSize=12 btn.Font=Enum.Font.GothamBold
    btn.LayoutOrder=order addCorner(btn,8)
    local function setActive(a) btn.BackgroundColor3=a and C.tabActive or C.tabInact btn.TextColor3=a and C.text or C.textDim end
    btn.MouseEnter:Connect(function() if currentTab~=name then TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=C.tabHover}):Play() end end)
    btn.MouseLeave:Connect(function() if currentTab~=name then TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=C.tabInact}):Play() end end)
    tabBtns[name]={btn=btn,setActive=setActive}
    return btn
end

local function switchTab(name)
    currentTab=name
    for tname,page in pairs(tabPages) do page.Visible=(tname==name) end
    for tname,info in pairs(tabBtns) do info.setActive(tname==name) end
end

tabPages.Home     = makePage()
tabPages.Scripts  = makePage()
tabPages.Executor = makePage()
tabPages.Source   = makePage()

local HomeBtn    = makeTabBtn("Home",    "🏠",1)
local ScriptBtn  = makeTabBtn("Scripts", "📜",2)
local ExecBtn2   = makeTabBtn("Executor","⚙",3)
local SourceBtn  = makeTabBtn("Source",  "🔥",4)

HomeBtn.MouseButton1Click:Connect(function()   switchTab("Home") end)
ScriptBtn.MouseButton1Click:Connect(function() switchTab("Scripts") end)
ExecBtn2.MouseButton1Click:Connect(function()  switchTab("Executor") end)
SourceBtn.MouseButton1Click:Connect(function() switchTab("Source") end)

-- Draggable
do
    local dragging,dragStart,startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true dragStart=input.Position startPos=Window.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
            local d=input.Position-dragStart
            Window.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
end

-- Header buttons
local minimized=false
CloseBtn2.MouseButton1Click:Connect(function() if killScript then killScript() end end)
MinBtn.MouseButton1Click:Connect(function()
    minimized=not minimized
    TweenService:Create(ContentHost,TweenInfo.new(0.2),{Size=minimized and UDim2.new(1,0,0,0) or UDim2.new(1,0,1,-42)}):Play()
    TweenService:Create(Window,TweenInfo.new(0.2),{Size=minimized and UDim2.new(0,WIN_W,0,42) or UDim2.new(0,WIN_W,0,WIN_H)}):Play()
end)

UserInputService.InputBegan:Connect(function(input,gpe)
    if gpe or hubKilled then return end
    if input.KeyCode==menuKey then hubVisible=not hubVisible HubGui.Enabled=hubVisible end
end)

-- ───────────────────────────────────────────────────────────────
-- HOME TAB
-- ───────────────────────────────────────────────────────────────
do
    local HP = tabPages.Home
    createSection(HP,"⚡  Universal Sun Hub")
    createParagraph(HP,"Welcome",#SCRIPTS.." scripts loaded. Toggle hub: "..getKeyName(menuKey).." or N button.")
    addSpacer(HP)
    createSection(HP,"Movement")
    createToggle(HP,"♾  Infinite Jump",settings.ijEnabled,function(v) setIJToggle(v) end)
    createToggle(HP,"⚡  Speed Boost",settings.speedEnabled,function(v) setSpeedToggle(v) end)
    createSlider(HP,"⚡  Walk Speed",0,500,1,settings.speedVal," spd",function(v) currentWalkSpeed=v settings.speedVal=v saveSettings() if speedEnabled then applyWalkSpeed() end end)
    createToggle(HP,"👻  Noclip",settings.noclipEnabled,function(v) setNoclipToggle(v) end)
    createToggle(HP,"🚀  Fly  (WASD · Q up · E down)",settings.flyEnabled,function(v) setFlyToggle(v) end)
    createSlider(HP,"🚀  Fly Speed",0,500,1,settings.flySpeedVal," spd",function(v) flySpeed=v settings.flySpeedVal=v saveSettings() end)
    createToggle(HP,"🌀  Spin",settings.spinEnabled,function(v) setSpinToggle(v) end)
    createSlider(HP,"🌀  Spin Speed",1,200,1,settings.spinSpeedVal," spd",function(v) spinSpeed=v settings.spinSpeedVal=v saveSettings() if spinEnabled then applySpin() end end)
    createToggle(HP,"🪂  No Fall",false,function(v) setNoFallToggle(v) end)
    createToggle(HP,"🕷  Wall Walk",false,function(v) setWallWalkToggle(v) end)
    createToggle(HP,"🌐  Zero Gravity  (WASD to move)",false,function(v) setZeroGravToggle(v) end)
    addSpacer(HP)
    createSection(HP,"Tween TP")
    do
        local names={} for _,p in pairs(Players:GetPlayers()) do if p~=Players.LocalPlayer then table.insert(names,p.Name) end end
        if #names==0 then names={"No players"} end
        createDropdown(HP,"Target Player",names,tweenTPTarget~="" and tweenTPTarget or names[1],function(v) if v=="No players" then return end tweenTPTarget=v settings.tweenTPTarget=v saveSettings() end)
    end
    createSlider(HP,"Tween TP Speed",5,300,5,settings.tweenTPSpeed," spd",function(v) tweenTPSpeed=v settings.tweenTPSpeed=v saveSettings() end)
    createToggle(HP,"✈  Tween TP  (fly to target)",false,function(v) setTweenTPToggle(v) end)
    addSpacer(HP)
    createSection(HP,"Visual")
    createToggle(HP,"☀  Full Bright",settings.fullBrightEnabled,function(v) setFullBrightToggle(v) end)
    createToggle(HP,"👁  ESP  (Highlight + Name Tag)",settings.espEnabled,function(v) setESPToggle(v) end)
    createToggle(HP,"📦  Hitbox Expander",settings.hitboxEnabled,function(v) setHitboxToggle(v) end)
    createSlider(HP,"📦  Hitbox Size",1,50,1,settings.hitboxSizeVal," size",function(v) hitboxSize=v settings.hitboxSizeVal=v saveSettings() if hitboxEnabled then setHitboxToggle(true) end end)
    addSpacer(HP)
    createSection(HP,"Combat")
    createDropdown(HP,"Aimbot Mode",{"Nearest","Target"},settings.aimbotMode,function(v) aimbotMode=v settings.aimbotMode=v saveSettings() end)
    do
        local names={} for _,p in pairs(Players:GetPlayers()) do if p~=Players.LocalPlayer then table.insert(names,p.Name) end end
        if #names==0 then names={"No players"} end
        createDropdown(HP,"Target Player",names,settings.aimbotTarget~="" and settings.aimbotTarget or names[1],function(v) if v=="No players" then return end aimbotTarget=v settings.aimbotTarget=v saveSettings() end)
    end
    createToggle(HP,"🎯  Aimbot  (camera lock)",settings.aimbotEnabled,function(v) setAimbotToggle(v) end)
    createButton(HP,"🔄  Refresh Player List",function()
        local names={} for _,p in pairs(Players:GetPlayers()) do if p~=Players.LocalPlayer then table.insert(names,p.Name) end end
        notify("Players Online",#names>0 and table.concat(names,", ") or "No other players",5)
    end)
    createButton(HP,"📍  Target TP",function() doTargetTP() notify("Target TP","Teleported to "..aimbotTarget,2) end)
    createButton(HP,"💨  Target Fling",function() doTargetFling() notify("Flung","Flung "..aimbotTarget,2) end)
    createToggle(HP,"💥  WalkFling",settings.flingEnabled,function(v) setFlingToggle(v) end)
    createDropdown(HP,"Fling All Mode",{"TP","Tween"},settings.flingAllMode,function(v) flingAllMode=v settings.flingAllMode=v saveSettings() end)
    createToggle(HP,"💥  Fling All",false,function(v) setFlingAllToggle(v) end)
    createToggle(HP,"🛡  Anti-Fling",false,function(v) setNewAntiFlingToggle(v) end)
    addSpacer(HP)
    createSection(HP,"Server")
    createButton(HP,"🔄  Rejoin",function() notify("Rejoin","Rejoining...",3) doRejoin() end)
    createButton(HP,"🔀  Server Hop",function() notify("Server Hop","Searching...",3) doServerHop() end)
    addSpacer(HP)
    createSection(HP,"Settings")
    createButton(HP,"⌨  Set Menu Key",function()
        notify("Listening","Press any key now...",4)
        local conn conn=UserInputService.InputBegan:Connect(function(input,gp)
            if gp or input.UserInputType~=Enum.UserInputType.Keyboard then return end
            menuKey=input.KeyCode settings.menuKey=input.KeyCode.Name saveSettings()
            notify("Key Set",input.KeyCode.Name,3) conn:Disconnect()
        end)
    end)
    createButton(HP,"🗑  Reset All Settings",function()
        settings.menuKey="LeftControl" settings.ijEnabled=false settings.speedEnabled=false settings.speedVal=16
        settings.spinEnabled=false settings.spinSpeedVal=20 settings.noclipEnabled=false settings.flyEnabled=false
        settings.flySpeedVal=50 settings.espEnabled=false settings.hitboxEnabled=false settings.hitboxSizeVal=5
        settings.flingEnabled=false settings.fullBrightEnabled=false settings.aimbotEnabled=false
        settings.aimbotMode="Nearest" settings.aimbotTarget="" settings.flingAllMode="TP"
        settings.tweenTPTarget="" settings.tweenTPSpeed=50 saveSettings()
        setIJToggle(false) setSpeedToggle(false) setSpinToggle(false) setNoclipToggle(false)
        setFlyToggle(false) setESPToggle(false) setHitboxToggle(false) setFlingToggle(false)
        setFlingAllToggle(false) setFullBrightToggle(false) setAimbotToggle(false)
        setNoFallToggle(false) setWallWalkToggle(false) setZeroGravToggle(false) setNewAntiFlingToggle(false)
        notify("Reset","All settings reset.",3)
    end)
    createButton(HP,"💀  Kill Script",true,function() if killScript then killScript() end end)
end

-- ───────────────────────────────────────────────────────────────
-- SCRIPTS TAB
-- ───────────────────────────────────────────────────────────────
do
    local SP = tabPages.Scripts
    createSection(SP,"📜  Click to Execute")
    addSpacer(SP)
    for _,s in ipairs(SCRIPTS) do
        createButton(SP,s.display,function()
            local ok,err=pcall(function() loadstring(s.code)() end)
            notify(ok and "✅ Executed" or "❌ Error",ok and s.display or tostring(err),ok and 3 or 6)
        end)
    end
end

-- ───────────────────────────────────────────────────────────────
-- EXECUTOR TAB
-- ───────────────────────────────────────────────────────────────
do
    local EP = tabPages.Executor
    createSection(EP,"⚙  Custom Lua Executor")
    addSpacer(EP)
    local execCode=""
    local _, execBox = createInput(EP,"Lua Code","Enter your Lua code here...",function(v) execCode=v end)
    execBox.ClearTextOnFocus=false execBox.MultiLine=true
    execBox.Parent.Size=UDim2.new(1,0,0,120) execBox.Size=UDim2.new(1,-20,0,90) execBox.Position=UDim2.new(0,10,1,-100)
    createButton(EP,"▶  Execute Code",function()
        if execCode=="" then notify("Empty","Enter some code first.",3) return end
        local fn,ce=loadstring(execCode) if not fn then notify("❌ Compile Error",tostring(ce),6) return end
        local ok,re=pcall(fn) notify(ok and "✅ Done" or "❌ Error",ok and "Code ran successfully!" or tostring(re),ok and 3 or 6)
    end)
    createButton(EP,"🗑  Clear",function() execCode="" execBox.Text="" notify("Cleared","Code cleared.",2) end)
end

-- ───────────────────────────────────────────────────────────────
-- SOURCE TAB (IY Features)
-- ───────────────────────────────────────────────────────────────
do
    local SrcP = tabPages.Source
    createSection(SrcP,"🏃  Movement (IY)")
    createToggle(SrcP,"🪂  Float  (Q lower · E raise)",false,function(v) setFloatToggle(v) end)
    createToggle(SrcP,"🌊  Swim  (zero-gravity swim)",false,function(v) setSwimToggle(v) end)
    createToggle(SrcP,"🛡  Anti-Void",false,function(v) setAntiVoidToggle(v) end)
    createToggle(SrcP,"🔄  No AutoRotate",false,function(v) setNoRotateToggle(v) end)
    createToggle(SrcP,"💤  Stun  (PlatformStand freeze)",false,function(v) setStunToggle(v) end)
    addSpacer(SrcP)
    createSection(SrcP,"⚔  Combat (IY)")
    createParagraph(SrcP,"Body Fling vs WalkFling","WalkFling = amplify walk velocity.\nBody Fling = spin at 99,999 rad/s.")
    createToggle(SrcP,"🌀  Body Fling",false,function(v) setBodyFlingToggle(v) end)
    createToggle(SrcP,"🔧  Reach  (equip tool first)",false,function(v) setReachToggle(v) end)
    createSlider(SrcP,"🔧  Reach Size",5,200,5,60," studs",function(v) iyReachSize=v if iyReachEnabled then startReach(v) end end)
    createToggle(SrcP,"🖱  Auto Click",false,function(v) setAutoClickToggle(v) end)
    addSpacer(SrcP)
    createSection(SrcP,"👁  Visual (IY)")
    createParagraph(SrcP,"Xray vs ESP","ESP = name tags on players.\nXray = all world geometry transparent.")
    createToggle(SrcP,"🔍  Xray  (see through walls)",false,function(v) setXrayToggle(v) end)
    createToggle(SrcP,"🏷  Hover Name",false,function(v) setHoverNameToggle(v) end)
    createToggle(SrcP,"💡  Character Light",false,function(v) setLightToggle(v) end)
    addSpacer(SrcP)
    createSection(SrcP,"👤  Character (IY)")
    createButton(SrcP,"👕  Naked",function() doNaked() notify("Naked","Clothing removed.",2) end)
    createButton(SrcP,"😶  No Face",function() doNoFace() notify("No Face","Face removed.",2) end)
    createButton(SrcP,"🎩  Clear Hats",function() doClearHats() notify("Clear Hats","Accessories removed.",2) end)
    createToggle(SrcP,"🎩  Hat Spin",false,function(v) setHatSpinToggle(v) end)
    createButton(SrcP,"💀  Flashback  (TP to last death)",function()
        if not iyLastDeath then notify("Flashback","No death recorded.",3) return end
        local c=Players.LocalPlayer.Character local r=c and c:FindFirstChild("HumanoidRootPart")
        if r then r.CFrame=iyLastDeath notify("Flashback","Teleported to last death.",3) end
    end)
    addSpacer(SrcP)
    createSection(SrcP,"🌅  Lighting (IY)")
    createButton(SrcP,"☀  Day",function() doDay() notify("Lighting","Set to Day.",2) end)
    createButton(SrcP,"🌙  Night",function() doNight() notify("Lighting","Set to Night.",2) end)
    createToggle(SrcP,"🌫  No Fog",false,function(v) setNoFogToggle(v) end)
    addSpacer(SrcP)
    createSection(SrcP,"🖥  Server (IY)")
    createButton(SrcP,"ℹ  Server Info",function() notify("Server Info",doServerInfo(),8) end)
    createToggle(SrcP,"🔄  Auto Rejoin",false,function(v) setAutoRejoinToggle(v) end)
end

-- ───────────────────────────────────────────────────────────────
-- Kill Script
-- ───────────────────────────────────────────────────────────────
killScript = function()
    hubKilled=true
    pcall(function() setIJToggle(false) end) pcall(function() setSpeedToggle(false) end)
    pcall(function() setSpinToggle(false) end) pcall(function() setNoclipToggle(false) end)
    pcall(function() setFlyToggle(false) end) pcall(function() setESPToggle(false) end)
    pcall(function() setHitboxToggle(false) end) pcall(function() setFlingToggle(false) end)
    pcall(function() setFullBrightToggle(false) end) pcall(function() setAimbotToggle(false) end)
    pcall(function() setNoFallToggle(false) end) pcall(function() setWallWalkToggle(false) end)
    pcall(function() setZeroGravToggle(false) end) pcall(function() setNewAntiFlingToggle(false) end)
    pcall(function() setFlingAllToggle(false) end) pcall(function() stopTweenTP() end)
    pcall(function() setFloatToggle(false) end) pcall(function() setSwimToggle(false) end)
    pcall(function() setAntiVoidToggle(false) end) pcall(function() setNoRotateToggle(false) end)
    pcall(function() setStunToggle(false) end) pcall(function() setBodyFlingToggle(false) end)
    pcall(function() setReachToggle(false) end) pcall(function() setAutoClickToggle(false) end)
    pcall(function() setXrayToggle(false) end) pcall(function() stopHoverName() end)
    pcall(function() setLightToggle(false) end) pcall(function() stopHatSpin() end)
    pcall(function() setAutoRejoinToggle(false) end) pcall(function() setNoFogToggle(false) end)
    pcall(function()
        local c=Players.LocalPlayer.Character if not c then return end
        local hum=c:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed=16 hum.JumpPower=50 hum.PlatformStand=false hum.AutoRotate=true end
        local root=c:FindFirstChild("HumanoidRootPart")
        if root then for _,o in pairs(root:GetChildren()) do if o:IsA("BodyMover") or o.Name=="USHSpin" or o.Name=="IYBodyFling" then o:Destroy() end end end
        for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.CanCollide=true end) end end
    end)
    pcall(function()
        for _,p in pairs(Players:GetPlayers()) do if p.Character then
            for _,o in pairs(p.Character:GetDescendants()) do if o.Name=="USHESP" or o.Name=="USHESPBill" then o:Destroy() end end
        end end
    end)
    pcall(function() if _floatGui and _floatGui.Parent then _floatGui:Destroy() _floatGui=nil end end)
    pcall(function() local n=playerGui:FindFirstChild("USHFloatBtn") if n then n:Destroy() end end)
    pcall(function() local n=playerGui:FindFirstChild("IYHoverName") if n then n:Destroy() end end)
    pcall(function() HubGui:Destroy() end)
end

-- ───────────────────────────────────────────────────────────────
-- Auto re-execute on teleport
-- ───────────────────────────────────────────────────────────────
local NORMAL_URL = "https://raw.githubusercontent.com/naitikthakur8273-alt/my_script/refs/heads/main/NORMAL_UI_LOADER.lua"
Players.LocalPlayer.OnTeleport:Connect(function(state)
    if state==Enum.TeleportState.Started then
        task.delay(4,function() pcall(function() local fn=loadstring(game:HttpGet(NORMAL_URL)) if fn then fn() end end) end)
    end
end)

-- ───────────────────────────────────────────────────────────────
-- Floating "N" Toggle Button
-- ───────────────────────────────────────────────────────────────
task.spawn(function()
    task.wait(1.5)
    local FloatGui=Instance.new("ScreenGui") FloatGui.Name="USHFloatBtn" _floatGui=FloatGui
    FloatGui.ResetOnSpawn=false FloatGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling FloatGui.DisplayOrder=999 FloatGui.Parent=playerGui
    local Ring=Instance.new("Frame",FloatGui) Ring.Size=UDim2.new(0,52,0,52)
    Ring.Position=UDim2.new(0,16,0.5,-26) Ring.BackgroundColor3=C.accent Ring.BorderSizePixel=0 addCorner(Ring,26)
    local Btn=Instance.new("TextButton",Ring) Btn.Size=UDim2.new(0,44,0,44) Btn.Position=UDim2.new(0.5,-22,0.5,-22)
    Btn.BackgroundColor3=Color3.fromRGB(18,18,35) Btn.BorderSizePixel=0 Btn.Text="N" Btn.TextColor3=C.text Btn.TextSize=16 Btn.Font=Enum.Font.GothamBold addCorner(Btn,22)
    local function updateVisual() Btn.TextColor3=hubVisible and C.text or C.textSec Ring.BackgroundColor3=hubVisible and C.accent or Color3.fromRGB(60,60,80) end
    task.spawn(function() while FloatGui.Parent do TweenService:Create(Ring,TweenInfo.new(1.2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,0,true),{BackgroundTransparency=0.35}):Play() task.wait(2.4) end end)
    local dragging2,dragStart2,dragStartPos,totalDrag=false,nil,nil,0
    Btn.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging2=true dragStart2=i.Position dragStartPos=Ring.Position totalDrag=0 end end)
    UserInputService.InputChanged:Connect(function(i)
        if not dragging2 then return end
        if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
            local d=i.Position-dragStart2 totalDrag=totalDrag+(Vector2.new(d.X,d.Y)).Magnitude
            Ring.Position=UDim2.new(dragStartPos.X.Scale,dragStartPos.X.Offset+d.X,dragStartPos.Y.Scale,dragStartPos.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            if dragging2 and totalDrag<8 then hubVisible=not hubVisible HubGui.Enabled=hubVisible updateVisual() end dragging2=false
        end
    end)
end)

-- ───────────────────────────────────────────────────────────────
-- Launch
-- ───────────────────────────────────────────────────────────────
switchTab("Home")
task.delay(0.8,function() notify("⚡ Universal Sun Hub","Normal UI loaded. "..getKeyName(menuKey).." or N button to toggle.",5) end)
