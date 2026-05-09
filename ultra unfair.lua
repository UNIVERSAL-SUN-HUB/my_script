-- ╔══════════════════════════════════════════════╗
-- ║       Universal Sun Hub — Ultra unFair       ║
-- ║         Game ID: 14339696091                 ║
-- ╚══════════════════════════════════════════════╝

local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService   = game:GetService("TweenService")
local HttpService    = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player   = Players.LocalPlayer
local char     = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(c)
    char      = c
    humanoid  = c:WaitForChild("Humanoid")
    rootPart  = c:WaitForChild("HumanoidRootPart")
end)

-- ─────────────────────────────────────────────────
--  Feature State
-- ─────────────────────────────────────────────────
local State = {
    autoFarm     = false,
    autoRoll     = false,
    killAura     = false,
    autoBoss     = false,
    autoSpin     = false,
    infJump      = false,
    speedEnabled = false,
    speedValue   = 50,
    killAuraRange = 20,
}

-- ─────────────────────────────────────────────────
--  Destroy old GUI
-- ─────────────────────────────────────────────────
local oldGui = player.PlayerGui:FindFirstChild("UltraUnFairHub")
if oldGui then oldGui:Destroy() end

-- ─────────────────────────────────────────────────
--  Root GUI
-- ─────────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name            = "UltraUnFairHub"
ScreenGui.ResetOnSpawn    = false
ScreenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent          = player.PlayerGui

-- ─────────────────────────────────────────────────
--  Colour palette
-- ─────────────────────────────────────────────────
local C = {
    bg       = Color3.fromRGB(15,  15,  20),
    panel    = Color3.fromRGB(22,  22,  30),
    accent   = Color3.fromRGB(130,  60, 220),
    accent2  = Color3.fromRGB(90,  30, 180),
    text     = Color3.fromRGB(240, 240, 255),
    subtext  = Color3.fromRGB(160, 160, 190),
    green    = Color3.fromRGB( 60, 210, 110),
    red      = Color3.fromRGB(210,  60,  80),
    divider  = Color3.fromRGB( 40,  40,  55),
    topbar   = Color3.fromRGB(25,  10,  50),
}

-- ─────────────────────────────────────────────────
--  Helper: corner + stroke
-- ─────────────────────────────────────────────────
local function corner(parent, radius)
    local u = Instance.new("UICorner", parent)
    u.CornerRadius = UDim.new(0, radius or 8)
end
local function stroke(parent, color, thickness)
    local s = Instance.new("UIStroke", parent)
    s.Color     = color or C.accent
    s.Thickness = thickness or 1.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end
local function padding(parent, px)
    local p = Instance.new("UIPadding", parent)
    local ud = UDim.new(0, px or 8)
    p.PaddingLeft   = ud
    p.PaddingRight  = ud
    p.PaddingTop    = ud
    p.PaddingBottom = ud
end

-- ─────────────────────────────────────────────────
--  Main Window
-- ─────────────────────────────────────────────────
local Main = Instance.new("Frame")
Main.Name            = "Main"
Main.Size            = UDim2.new(0, 480, 0, 520)
Main.Position        = UDim2.new(0.5, -240, 0.5, -260)
Main.BackgroundColor3 = C.bg
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent          = ScreenGui
corner(Main, 14)
stroke(Main, C.accent, 2)

-- ─────────────────────────────────────────────────
--  Title Bar
-- ─────────────────────────────────────────────────
local TitleBar = Instance.new("Frame")
TitleBar.Name              = "TitleBar"
TitleBar.Size              = UDim2.new(1, 0, 0, 48)
TitleBar.BackgroundColor3  = C.topbar
TitleBar.BorderSizePixel   = 0
TitleBar.Parent            = Main
corner(TitleBar, 14)

-- gradient on titlebar
local tg = Instance.new("UIGradient", TitleBar)
tg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(100, 30, 200)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(30,  10,  80)),
}
tg.Rotation = 90

local TitleIcon = Instance.new("TextLabel")
TitleIcon.Size              = UDim2.new(0, 36, 0, 36)
TitleIcon.Position          = UDim2.new(0, 10, 0.5, -18)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Text              = "⚔️"
TitleIcon.TextSize          = 22
TitleIcon.Font              = Enum.Font.GothamBold
TitleIcon.Parent            = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size             = UDim2.new(1, -110, 1, 0)
TitleLabel.Position         = UDim2.new(0, 50, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text             = "Ultra unFair  •  Sun Hub"
TitleLabel.TextColor3       = C.text
TitleLabel.Font             = Enum.Font.GothamBold
TitleLabel.TextSize         = 17
TitleLabel.TextXAlignment   = Enum.TextXAlignment.Left
TitleLabel.Parent           = TitleBar

local SubLabel = Instance.new("TextLabel")
SubLabel.Size               = UDim2.new(1, -110, 0, 14)
SubLabel.Position           = UDim2.new(0, 50, 1, -16)
SubLabel.BackgroundTransparency = 1
SubLabel.Text               = "Game ID: 14339696091"
SubLabel.TextColor3         = C.subtext
SubLabel.Font               = Enum.Font.Gotham
SubLabel.TextSize           = 11
SubLabel.TextXAlignment      = Enum.TextXAlignment.Left
SubLabel.Parent             = TitleBar

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size               = UDim2.new(0, 30, 0, 30)
CloseBtn.Position           = UDim2.new(1, -40, 0.5, -15)
CloseBtn.BackgroundColor3   = Color3.fromRGB(200, 50, 70)
CloseBtn.Text               = "✕"
CloseBtn.TextColor3         = Color3.new(1,1,1)
CloseBtn.Font               = Enum.Font.GothamBold
CloseBtn.TextSize           = 14
CloseBtn.BorderSizePixel    = 0
CloseBtn.Parent             = TitleBar
corner(CloseBtn, 6)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0,480,0,0)}):Play()
    task.delay(0.35, function() ScreenGui:Destroy() end)
end)

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size               = UDim2.new(0, 30, 0, 30)
MinBtn.Position           = UDim2.new(1, -78, 0.5, -15)
MinBtn.BackgroundColor3   = Color3.fromRGB(200, 160, 30)
MinBtn.Text               = "–"
MinBtn.TextColor3         = Color3.new(1,1,1)
MinBtn.Font               = Enum.Font.GothamBold
MinBtn.TextSize            = 18
MinBtn.BorderSizePixel    = 0
MinBtn.Parent             = TitleBar
corner(MinBtn, 6)

local minimised = false
MinBtn.MouseButton1Click:Connect(function()
    minimised = not minimised
    local target = minimised and UDim2.new(0,480,0,48) or UDim2.new(0,480,0,520)
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = target}):Play()
end)

-- ─────────────────────────────────────────────────
--  Drag
-- ─────────────────────────────────────────────────
local dragging, dragStart, startPos = false, nil, nil
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging  = true
        dragStart = input.Position
        startPos  = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ─────────────────────────────────────────────────
--  Tab Bar
-- ─────────────────────────────────────────────────
local TabBar = Instance.new("Frame")
TabBar.Name             = "TabBar"
TabBar.Size             = UDim2.new(1, -20, 0, 36)
TabBar.Position         = UDim2.new(0, 10, 0, 56)
TabBar.BackgroundColor3 = C.panel
TabBar.BorderSizePixel  = 0
TabBar.Parent           = Main
corner(TabBar, 8)
stroke(TabBar, C.divider, 1)

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection    = Enum.FillDirection.Horizontal
TabLayout.SortOrder        = Enum.SortOrder.LayoutOrder
TabLayout.Padding          = UDim.new(0, 4)
padding(TabBar, 4)

-- Content area
local Content = Instance.new("ScrollingFrame")
Content.Name                 = "Content"
Content.Size                 = UDim2.new(1, -20, 1, -108)
Content.Position             = UDim2.new(0, 10, 0, 100)
Content.BackgroundTransparency = 1
Content.BorderSizePixel      = 0
Content.ScrollBarThickness   = 3
Content.ScrollBarImageColor3 = C.accent
Content.CanvasSize           = UDim2.new(0,0,0,0)
Content.AutomaticCanvasSize  = Enum.AutomaticSize.Y
Content.Parent               = Main

local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.SortOrder        = Enum.SortOrder.LayoutOrder
ContentLayout.Padding          = UDim.new(0, 8)
padding(Content, 6)

-- ─────────────────────────────────────────────────
--  Tab system
-- ─────────────────────────────────────────────────
local tabs       = {}
local tabPages   = {}
local activeTab  = nil

local function makeTab(name, icon, order)
    local btn = Instance.new("TextButton")
    btn.Size              = UDim2.new(0, 98, 1, -6)
    btn.BackgroundColor3  = C.bg
    btn.Text              = icon .. "  " .. name
    btn.TextColor3        = C.subtext
    btn.Font              = Enum.Font.GothamBold
    btn.TextSize          = 12
    btn.BorderSizePixel   = 0
    btn.LayoutOrder       = order
    btn.Parent            = TabBar
    corner(btn, 6)

    local page = Instance.new("Frame")
    page.Name             = name
    page.Size             = UDim2.new(1, 0, 0, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel  = 0
    page.AutomaticSize    = Enum.AutomaticSize.Y
    page.Visible          = false
    page.Parent           = Content
    local pl = Instance.new("UIListLayout", page)
    pl.SortOrder  = Enum.SortOrder.LayoutOrder
    pl.Padding    = UDim.new(0, 6)

    tabs[name]     = btn
    tabPages[name] = page

    btn.MouseButton1Click:Connect(function()
        if activeTab then
            tabPages[activeTab].Visible = false
            tabs[activeTab].BackgroundColor3 = C.bg
            tabs[activeTab].TextColor3       = C.subtext
        end
        activeTab = name
        page.Visible              = true
        btn.BackgroundColor3      = C.accent
        btn.TextColor3            = C.text
    end)

    return page
end

local pageFarm     = makeTab("Farm",    "🌾", 1)
local pageRoll     = makeTab("Roll",    "🎲", 2)
local pageCombat   = makeTab("Combat",  "⚔️",  3)
local pagePlayer   = makeTab("Player",  "🧍", 4)

-- activate first tab
tabs["Farm"].BackgroundColor3 = C.accent
tabs["Farm"].TextColor3       = C.text
tabPages["Farm"].Visible      = true
activeTab = "Farm"

-- ─────────────────────────────────────────────────
--  UI Helpers — Toggle + Slider + Button + Divider
-- ─────────────────────────────────────────────────
local function makeDivider(parent, label, order)
    local wrap = Instance.new("Frame")
    wrap.Size             = UDim2.new(1, 0, 0, 22)
    wrap.BackgroundTransparency = 1
    wrap.LayoutOrder      = order
    wrap.Parent           = parent

    local line = Instance.new("Frame")
    line.Size             = UDim2.new(1, 0, 0, 1)
    line.Position         = UDim2.new(0, 0, 0.5, 0)
    line.BackgroundColor3 = C.divider
    line.BorderSizePixel  = 0
    line.Parent           = wrap

    local lbl = Instance.new("TextLabel")
    lbl.Size              = UDim2.new(0, 120, 1, 0)
    lbl.Position          = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundColor3  = C.bg
    lbl.Text              = "  " .. label .. "  "
    lbl.TextColor3        = C.accent
    lbl.Font              = Enum.Font.GothamBold
    lbl.TextSize          = 11
    lbl.BorderSizePixel   = 0
    lbl.Parent            = wrap
end

local function makeToggle(parent, label, desc, order, callback)
    local row = Instance.new("Frame")
    row.Size              = UDim2.new(1, 0, 0, 52)
    row.BackgroundColor3  = C.panel
    row.BorderSizePixel   = 0
    row.LayoutOrder       = order
    row.Parent            = parent
    corner(row, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Size              = UDim2.new(1, -70, 0, 22)
    lbl.Position          = UDim2.new(0, 12, 0, 8)
    lbl.BackgroundTransparency = 1
    lbl.Text              = label
    lbl.TextColor3        = C.text
    lbl.Font              = Enum.Font.GothamBold
    lbl.TextSize          = 13
    lbl.TextXAlignment    = Enum.TextXAlignment.Left
    lbl.Parent            = row

    local sub = Instance.new("TextLabel")
    sub.Size              = UDim2.new(1, -70, 0, 16)
    sub.Position          = UDim2.new(0, 12, 0, 30)
    sub.BackgroundTransparency = 1
    sub.Text              = desc
    sub.TextColor3        = C.subtext
    sub.Font              = Enum.Font.Gotham
    sub.TextSize          = 11
    sub.TextXAlignment    = Enum.TextXAlignment.Left
    sub.Parent            = row

    -- pill toggle
    local pill = Instance.new("Frame")
    pill.Size             = UDim2.new(0, 44, 0, 24)
    pill.Position         = UDim2.new(1, -56, 0.5, -12)
    pill.BackgroundColor3 = C.red
    pill.BorderSizePixel  = 0
    pill.Parent           = row
    corner(pill, 12)

    local knob = Instance.new("Frame")
    knob.Size             = UDim2.new(0, 18, 0, 18)
    knob.Position         = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.BorderSizePixel  = 0
    knob.Parent           = pill
    corner(knob, 9)

    local on = false
    local function setOn(v)
        on = v
        local tw = TweenService:Create(pill, TweenInfo.new(0.2), {BackgroundColor3 = v and C.green or C.red})
        tw:Play()
        local tw2 = TweenService:Create(knob, TweenInfo.new(0.2), {Position = v and UDim2.new(0,23,0.5,-9) or UDim2.new(0,3,0.5,-9)})
        tw2:Play()
        if callback then callback(v) end
    end

    local btn = Instance.new("TextButton")
    btn.Size              = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text              = ""
    btn.Parent            = row
    btn.MouseButton1Click:Connect(function() setOn(not on) end)

    return setOn
end

local function makeButton(parent, label, desc, order, callback)
    local row = Instance.new("Frame")
    row.Size              = UDim2.new(1, 0, 0, 52)
    row.BackgroundColor3  = C.panel
    row.BorderSizePixel   = 0
    row.LayoutOrder       = order
    row.Parent            = parent
    corner(row, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Size              = UDim2.new(1, -120, 0, 22)
    lbl.Position          = UDim2.new(0, 12, 0, 8)
    lbl.BackgroundTransparency = 1
    lbl.Text              = label
    lbl.TextColor3        = C.text
    lbl.Font              = Enum.Font.GothamBold
    lbl.TextSize          = 13
    lbl.TextXAlignment    = Enum.TextXAlignment.Left
    lbl.Parent            = row

    local sub = Instance.new("TextLabel")
    sub.Size              = UDim2.new(1, -120, 0, 16)
    sub.Position          = UDim2.new(0, 12, 0, 30)
    sub.BackgroundTransparency = 1
    sub.Text              = desc
    sub.TextColor3        = C.subtext
    sub.Font              = Enum.Font.Gotham
    sub.TextSize          = 11
    sub.TextXAlignment    = Enum.TextXAlignment.Left
    sub.Parent            = row

    local btn = Instance.new("TextButton")
    btn.Size              = UDim2.new(0, 90, 0, 30)
    btn.Position          = UDim2.new(1, -102, 0.5, -15)
    btn.BackgroundColor3  = C.accent
    btn.Text              = "Execute"
    btn.TextColor3        = C.text
    btn.Font              = Enum.Font.GothamBold
    btn.TextSize          = 12
    btn.BorderSizePixel   = 0
    btn.Parent            = row
    corner(btn, 6)

    btn.MouseButton1Click:Connect(function()
        local tw = TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = C.accent2})
        tw:Play()
        task.delay(0.15, function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = C.accent}):Play()
        end)
        if callback then callback() end
    end)
end

local function makeSlider(parent, label, min, max, default, order, callback)
    local row = Instance.new("Frame")
    row.Size              = UDim2.new(1, 0, 0, 62)
    row.BackgroundColor3  = C.panel
    row.BorderSizePixel   = 0
    row.LayoutOrder       = order
    row.Parent            = parent
    corner(row, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Size              = UDim2.new(0.6, 0, 0, 20)
    lbl.Position          = UDim2.new(0, 12, 0, 8)
    lbl.BackgroundTransparency = 1
    lbl.Text              = label
    lbl.TextColor3        = C.text
    lbl.Font              = Enum.Font.GothamBold
    lbl.TextSize          = 13
    lbl.TextXAlignment    = Enum.TextXAlignment.Left
    lbl.Parent            = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size           = UDim2.new(0.35, 0, 0, 20)
    valLbl.Position       = UDim2.new(0.6, 0, 0, 8)
    valLbl.BackgroundTransparency = 1
    valLbl.Text           = tostring(default)
    valLbl.TextColor3     = C.accent
    valLbl.Font           = Enum.Font.GothamBold
    valLbl.TextSize       = 13
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent         = row

    local track = Instance.new("Frame")
    track.Size            = UDim2.new(1, -24, 0, 6)
    track.Position        = UDim2.new(0, 12, 0, 38)
    track.BackgroundColor3 = C.divider
    track.BorderSizePixel = 0
    track.Parent          = row
    corner(track, 3)

    local fill = Instance.new("Frame")
    fill.Size             = UDim2.new((default - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = C.accent
    fill.BorderSizePixel  = 0
    fill.Parent           = track
    corner(fill, 3)

    local knob = Instance.new("Frame")
    knob.Size             = UDim2.new(0, 14, 0, 14)
    knob.Position         = UDim2.new((default - min)/(max - min), -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.BorderSizePixel  = 0
    knob.Parent           = track
    corner(knob, 7)

    local draggingSlider = false
    local function update(x)
        local abs   = track.AbsolutePosition.X
        local width = track.AbsoluteSize.X
        local pct   = math.clamp((x - abs) / width, 0, 1)
        local val   = math.floor(min + (max - min) * pct)
        fill.Size         = UDim2.new(pct, 0, 1, 0)
        knob.Position     = UDim2.new(pct, -7, 0.5, -7)
        valLbl.Text       = tostring(val)
        if callback then callback(val) end
    end

    local hitbox = Instance.new("TextButton")
    hitbox.Size             = UDim2.new(1, 0, 0, 30)
    hitbox.Position         = UDim2.new(0, 0, 0, 28)
    hitbox.BackgroundTransparency = 1
    hitbox.Text             = ""
    hitbox.Parent           = row
    hitbox.MouseButton1Down:Connect(function() draggingSlider = true end)
    hitbox.MouseButton1Up:Connect(function()   draggingSlider = false end)
    hitbox.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = true
            update(i.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if draggingSlider and i.UserInputType == Enum.UserInputType.MouseMovement then
            update(i.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = false
        end
    end)
end

-- ─────────────────────────────────────────────────
--  Toast Notification
-- ─────────────────────────────────────────────────
local function toast(msg)
    local t = Instance.new("Frame")
    t.Size             = UDim2.new(0, 280, 0, 40)
    t.Position         = UDim2.new(0.5, -140, 1, 10)
    t.BackgroundColor3 = C.accent
    t.BorderSizePixel  = 0
    t.Parent           = ScreenGui
    corner(t, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Size             = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text             = msg
    lbl.TextColor3       = C.text
    lbl.Font             = Enum.Font.GothamBold
    lbl.TextSize         = 13
    lbl.Parent           = t

    TweenService:Create(t, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5,-140,1,-54)}):Play()
    task.delay(2.5, function()
        TweenService:Create(t, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5,-140,1,10)}):Play()
        task.delay(0.35, function() t:Destroy() end)
    end)
end

-- ─────────────────────────────────────────────────
--  ══ FARM TAB ══
-- ─────────────────────────────────────────────────
makeDivider(pageFarm, "Auto Farm", 1)

makeToggle(pageFarm, "Auto Farm", "Automatically kills nearby enemies for EXP", 2, function(v)
    State.autoFarm = v
    toast(v and "Auto Farm ON" or "Auto Farm OFF")
end)

makeToggle(pageFarm, "Auto Boss", "Automatically targets and attacks boss enemies", 4, function(v)
    State.autoBoss = v
    toast(v and "Auto Boss ON" or "Auto Boss OFF")
end)

makeButton(pageFarm, "Collect All Rewards", "Collect any pending quest / daily rewards", 5, function()
    toast("Collecting rewards...")
    pcall(function()
        local remote = ReplicatedStorage:FindFirstChild("CollectRewards") or ReplicatedStorage:FindFirstChild("ClaimReward")
        if remote then remote:FireServer() end
    end)
end)

makeDivider(pageFarm, "Quests", 6)

makeButton(pageFarm, "Auto Complete Quest", "Clicks quest buttons & fires quest remotes", 7, function()
    toast("Attempting quest complete...")
    pcall(function()
        -- 1) Click any visible quest-related GUI button
        local keywords = {"complete", "claim", "quest", "accept", "finish", "submit", "turn"}
        for _, v in ipairs(player.PlayerGui:GetDescendants()) do
            if (v:IsA("TextButton") or v:IsA("ImageButton")) and v.Visible then
                local t = (v.Text or ""):lower()
                for _, kw in ipairs(keywords) do
                    if t:find(kw) then
                        v.MouseButton1Click:Fire()
                        task.wait(0.05)
                        break
                    end
                end
            end
        end
        -- 2) Fire any quest/claim/complete remotes
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                local n = v.Name:lower()
                if n:find("quest") or n:find("claim") or n:find("complete") or n:find("finish") or n:find("submit") then
                    if v:IsA("RemoteEvent") then v:FireServer()
                    else pcall(function() v:InvokeServer() end) end
                end
            end
        end
    end)
end)

-- ─────────────────────────────────────────────────
--  ══ ROLL TAB ══
-- ─────────────────────────────────────────────────
makeDivider(pageRoll, "Ability Rolling", 1)

makeToggle(pageRoll, "Auto Roll", "Continuously rolls for a new ability", 2, function(v)
    State.autoRoll = v
    toast(v and "Auto Roll ON — rolling for abilities!" or "Auto Roll OFF")
end)

makeToggle(pageRoll, "Auto Spin (Wheel)", "Continuously spins the reward wheel", 3, function(v)
    State.autoSpin = v
    toast(v and "Auto Spin ON" or "Auto Spin OFF")
end)

makeDivider(pageRoll, "One-Time Actions", 4)

makeButton(pageRoll, "Roll Once", "Fire a single ability roll", 5, function()
    toast("Rolling once...")
    pcall(function()
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") and (v.Name:lower():find("roll") or v.Name:lower():find("reroll")) then
                v:FireServer()
                break
            end
        end
    end)
end)

makeButton(pageRoll, "Spin Wheel Once", "Spin the reward wheel one time", 6, function()
    toast("Spinning wheel...")
    pcall(function()
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") and v.Name:lower():find("spin") then
                v:FireServer()
                break
            end
        end
    end)
end)

-- ─────────────────────────────────────────────────
--  ══ COMBAT TAB ══
-- ─────────────────────────────────────────────────
makeDivider(pageCombat, "Combat", 1)

makeToggle(pageCombat, "Kill Aura", "Auto-attacks all enemies within range", 2, function(v)
    State.killAura = v
    toast(v and "Kill Aura ON" or "Kill Aura OFF")
end)

makeSlider(pageCombat, "Kill Aura Range", 5, 100, 20, 3, function(v)
    State.killAuraRange = v
end)

makeDivider(pageCombat, "Utilities", 4)

makeButton(pageCombat, "Kill All Near Me", "Rapidly M1-spams all NPCs in aura range", 5, function()
    toast("Attacking nearby NPCs...")
    task.spawn(function()
        for i = 1, 30 do
            pcall(function()
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("Humanoid") and v.Parent ~= char and v.Health > 0 then
                        local rp = v.Parent:FindFirstChild("HumanoidRootPart")
                        if rp and (rp.Position - rootPart.Position).Magnitude <= State.killAuraRange then
                            rootPart.CFrame = rp.CFrame * CFrame.new(0, 2.5, 0)
                            fireM1(rp)
                        end
                    end
                end
            end)
            task.wait(0.08)
        end
    end)
end)

makeButton(pageCombat, "Teleport to Nearest Boss", "TP directly to the nearest boss enemy", 6, function()
    toast("Teleporting to boss...")
    pcall(function()
        local closest, dist = nil, math.huge
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Humanoid") and v.Parent ~= char and v.Health > 0 then
                local rp = v.Parent:FindFirstChild("HumanoidRootPart")
                local maxHp = v.MaxHealth
                if rp and maxHp > 5000 then
                    local d = (rp.Position - rootPart.Position).Magnitude
                    if d < dist then dist = d; closest = rp end
                end
            end
        end
        if closest then
            rootPart.CFrame = closest.CFrame + Vector3.new(0, 5, 0)
        else
            toast("No boss found nearby!")
        end
    end)
end)

-- ─────────────────────────────────────────────────
--  ══ PLAYER TAB ══
-- ─────────────────────────────────────────────────
makeDivider(pagePlayer, "Movement", 1)

makeToggle(pagePlayer, "Infinite Jump", "Jump as many times as you want in the air", 2, function(v)
    State.infJump = v
    toast(v and "Infinite Jump ON" or "Infinite Jump OFF")
end)

makeToggle(pagePlayer, "Speed Hack", "Increases your WalkSpeed", 3, function(v)
    State.speedEnabled = v
    pcall(function()
        humanoid.WalkSpeed = v and State.speedValue or 16
    end)
    toast(v and ("Speed Hack ON — " .. State.speedValue .. " WS") or "Speed Hack OFF")
end)

makeSlider(pagePlayer, "Walk Speed", 16, 200, 50, 4, function(v)
    State.speedValue = v
    if State.speedEnabled then
        pcall(function() humanoid.WalkSpeed = v end)
    end
end)

makeDivider(pagePlayer, "Teleport", 5)

makeButton(pagePlayer, "Teleport to Spawn", "Teleport back to the game spawn point", 6, function()
    toast("Teleporting to spawn...")
    pcall(function()
        local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
        if spawn then
            rootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
        end
    end)
end)

makeButton(pagePlayer, "Rejoin Server", "Leaves and rejoins the same game", 7, function()
    toast("Rejoining...")
    task.delay(1, function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId, player)
    end)
end)

-- ─────────────────────────────────────────────────
--  Shared target references (set by farm/aura loops)
-- ─────────────────────────────────────────────────
local farmTarget = nil   -- RootPart of current farm NPC
local auraTarget = nil   -- RootPart of current kill aura NPC

-- ─────────────────────────────────────────────────
--  M1 Spam helper — activates equipped tool properly
--  so the server registers damage and gives rewards
-- ─────────────────────────────────────────────────
local function fireM1(targetRoot)
    pcall(function()
        -- Face the target
        if targetRoot then
            rootPart.CFrame = CFrame.lookAt(rootPart.Position, targetRoot.Position)
        end
        -- 1) Activate the equipped tool (main approach — server-sided)
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
        -- 2) Also fire any attack/hit/m1/punch remotes as fallback
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                local n = v.Name:lower()
                if n:find("attack") or n:find("m1") or n:find("punch")
                or n:find("hit") or n:find("swing") or n:find("damage") then
                    if targetRoot then
                        v:FireServer(targetRoot.Parent, targetRoot.CFrame.Position)
                    else
                        v:FireServer()
                    end
                    break
                end
            end
        end
    end)
end

-- ─────────────────────────────────────────────────
--  Find nearest valid NPC
-- ─────────────────────────────────────────────────
local function getNearestNPC(maxHp)
    local best, bestDist = nil, math.huge
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Humanoid") and v.Parent ~= char and v.Health > 0 then
            local rp = v.Parent:FindFirstChild("HumanoidRootPart")
            if rp then
                local inHpRange = (maxHp == nil) or (v.MaxHealth <= maxHp)
                if inHpRange then
                    local d = (rp.Position - rootPart.Position).Magnitude
                    if d < bestDist then bestDist = d; best = rp end
                end
            end
        end
    end
    return best
end

local function getNearestBoss()
    local best, bestDist = nil, math.huge
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Humanoid") and v.Parent ~= char and v.Health > 0 and v.MaxHealth > 5000 then
            local rp = v.Parent:FindFirstChild("HumanoidRootPart")
            if rp then
                local d = (rp.Position - rootPart.Position).Magnitude
                if d < bestDist then bestDist = d; best = rp end
            end
        end
    end
    return best
end

-- ─────────────────────────────────────────────────
--  ══ RunService Loop ══
--  Runs every frame: pins character on top of targets
--  and handles inf jump / speed. Kept minimal to avoid lag.
-- ─────────────────────────────────────────────────
RunService.Heartbeat:Connect(function()
    -- Infinite Jump
    if State.infJump then
        pcall(function()
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end

    -- Speed persistence
    if State.speedEnabled then
        pcall(function() humanoid.WalkSpeed = State.speedValue end)
    end

    -- Pin ON TOP of farm target so NPC can't run away
    if State.autoFarm and farmTarget and farmTarget.Parent and farmTarget.Parent:FindFirstChildOfClass("Humanoid") then
        pcall(function()
            rootPart.CFrame = farmTarget.CFrame * CFrame.new(0, 2.5, 0)
        end)
    end

    -- Pin ON TOP of boss target
    if State.autoBoss and auraTarget and auraTarget.Parent and auraTarget.Parent:FindFirstChildOfClass("Humanoid") then
        pcall(function()
            rootPart.CFrame = auraTarget.CFrame * CFrame.new(0, 2.5, 0)
        end)
    end
end)

-- ─────────────────────────────────────────────────
--  M1 spam loop — 0.1s tick (separate from Heartbeat
--  to avoid frame-rate lag while still being fast)
-- ─────────────────────────────────────────────────
task.spawn(function()
    while task.wait(0.1) do
        -- Auto Farm M1 spam
        if State.autoFarm then
            pcall(function()
                -- Pick or refresh target
                if not farmTarget or not farmTarget.Parent
                or not farmTarget.Parent:FindFirstChildOfClass("Humanoid")
                or farmTarget.Parent:FindFirstChildOfClass("Humanoid").Health <= 0 then
                    farmTarget = getNearestNPC(8000)
                end
                if farmTarget then
                    fireM1(farmTarget)
                end
            end)
        else
            farmTarget = nil
        end

        -- Kill Aura M1 spam — uses tool activation, NOT Health=0
        -- This ensures rewards are properly given by the server
        if State.killAura then
            pcall(function()
                local best, bestDist = nil, math.huge
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("Humanoid") and v.Parent ~= char and v.Health > 0 then
                        local rp = v.Parent:FindFirstChild("HumanoidRootPart")
                        if rp then
                            local d = (rp.Position - rootPart.Position).Magnitude
                            if d <= State.killAuraRange and d < bestDist then
                                bestDist = d; best = rp
                            end
                        end
                    end
                end
                if best then
                    -- Teleport next to target (not on top, to avoid conflict with farm pin)
                    if not State.autoFarm then
                        rootPart.CFrame = best.CFrame * CFrame.new(0, 2.5, 0)
                    end
                    fireM1(best)
                end
            end)
        end

        -- Auto Boss M1 spam
        if State.autoBoss then
            pcall(function()
                if not auraTarget or not auraTarget.Parent
                or not auraTarget.Parent:FindFirstChildOfClass("Humanoid")
                or auraTarget.Parent:FindFirstChildOfClass("Humanoid").Health <= 0 then
                    auraTarget = getNearestBoss()
                end
                if auraTarget then
                    fireM1(auraTarget)
                end
            end)
        else
            auraTarget = nil
        end
    end
end)

-- ─────────────────────────────────────────────────
--  Slow loop — Roll / Spin / Quest (0.4s tick)
-- ─────────────────────────────────────────────────
task.spawn(function()
    while task.wait(0.4) do
        -- Auto Roll
        if State.autoRoll then
            pcall(function()
                -- Try remotes first
                for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
                    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                        local n = v.Name:lower()
                        if n:find("roll") or n:find("reroll") or n:find("ability") then
                            if v:IsA("RemoteEvent") then v:FireServer()
                            else pcall(function() v:InvokeServer() end) end
                            break
                        end
                    end
                end
                -- Also try clicking any Roll button in PlayerGui
                for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                    if v:IsA("TextButton") or v:IsA("ImageButton") then
                        local t = v.Text and v.Text:lower() or ""
                        if t:find("roll") or t:find("reroll") then
                            v.MouseButton1Click:Fire()
                            break
                        end
                    end
                end
            end)
        end

        -- Auto Spin
        if State.autoSpin then
            pcall(function()
                for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
                    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                        local n = v.Name:lower()
                        if n:find("spin") or n:find("wheel") then
                            if v:IsA("RemoteEvent") then v:FireServer()
                            else pcall(function() v:InvokeServer() end) end
                            break
                        end
                    end
                end
                -- Also try clicking the spin/wheel button in GUI
                for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                    if v:IsA("TextButton") or v:IsA("ImageButton") then
                        local t = v.Text and v.Text:lower() or ""
                        if t:find("spin") or t:find("wheel") then
                            v.MouseButton1Click:Fire()
                            break
                        end
                    end
                end
            end)
        end
    end
end)

-- ─────────────────────────────────────────────────
--  Boot toast
-- ─────────────────────────────────────────────────
task.delay(0.5, function()
    toast("⚔️  Ultra unFair Hub loaded!")
end)
