-- main_loader.lua
-- Paste into your executor. Shows a styled confirm dialog then loads loader.lua from GitHub.

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ── ScreenGui ────────────────────────────────────────────────────────
local BootGui = Instance.new("ScreenGui")
BootGui.Name          = "USHBootGui"
BootGui.ResetOnSpawn  = false
BootGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BootGui.Parent        = playerGui

-- ── Full-screen dim ──────────────────────────────────────────────────
local Backdrop = Instance.new("Frame")
Backdrop.Size                 = UDim2.new(1, 0, 1, 0)
Backdrop.BackgroundColor3     = Color3.fromRGB(0, 0, 0)
Backdrop.BackgroundTransparency = 0.5
Backdrop.BorderSizePixel      = 0
Backdrop.ZIndex               = 1
Backdrop.Parent               = BootGui

-- ── Confirm Dialog ───────────────────────────────────────────────────
local Dialog = Instance.new("Frame")
Dialog.Name             = "Dialog"
Dialog.Size             = UDim2.new(0, 340, 0, 220)
Dialog.Position         = UDim2.new(0.5, -170, 0.5, -110)
Dialog.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
Dialog.BorderSizePixel  = 0
Dialog.ZIndex           = 2
Dialog.Parent           = BootGui
Instance.new("UICorner", Dialog).CornerRadius = UDim.new(0, 16)

local DialogStroke = Instance.new("UIStroke")
DialogStroke.Color     = Color3.fromRGB(80, 80, 200)
DialogStroke.Thickness = 1.8
DialogStroke.Parent    = Dialog

-- Accent bar at the top
local AccentBar = Instance.new("Frame")
AccentBar.Size            = UDim2.new(1, 0, 0, 4)
AccentBar.BackgroundColor3 = Color3.fromRGB(90, 90, 220)
AccentBar.BorderSizePixel = 0
AccentBar.ZIndex          = 3
AccentBar.Parent          = Dialog
Instance.new("UIGradient", AccentBar).Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 60, 255)),
})
local AccentCorner = Instance.new("UICorner")
AccentCorner.CornerRadius = UDim.new(0, 4)
AccentCorner.Parent = AccentBar

-- Icon
local IconLabel = Instance.new("TextLabel")
IconLabel.Size                 = UDim2.new(1, 0, 0, 52)
IconLabel.Position             = UDim2.new(0, 0, 0, 14)
IconLabel.BackgroundTransparency = 1
IconLabel.Text                 = "⚡"
IconLabel.TextSize             = 40
IconLabel.Font                 = Enum.Font.GothamBold
IconLabel.TextColor3           = Color3.fromRGB(160, 160, 255)
IconLabel.ZIndex               = 3
IconLabel.Parent               = Dialog

-- Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size                 = UDim2.new(1, -24, 0, 28)
TitleLabel.Position             = UDim2.new(0, 12, 0, 68)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text                 = "Universal Sun Hub  ·  Ready to execute"
TitleLabel.TextColor3           = Color3.fromRGB(230, 230, 255)
TitleLabel.TextSize             = 17
TitleLabel.Font                 = Enum.Font.GothamBold
TitleLabel.ZIndex               = 3
TitleLabel.Parent               = Dialog

-- Subtitle
local SubLabel = Instance.new("TextLabel")
SubLabel.Size                 = UDim2.new(1, -24, 0, 50)
SubLabel.Position             = UDim2.new(0, 12, 0, 100)
SubLabel.BackgroundTransparency = 1
SubLabel.Text                 = "This will load Rayfield UI + all scripts\nand open the full Universal Sun Hub menu."
SubLabel.TextColor3           = Color3.fromRGB(130, 130, 180)
SubLabel.TextSize             = 13
SubLabel.Font                 = Enum.Font.Gotham
SubLabel.TextWrapped          = true
SubLabel.ZIndex               = 3
SubLabel.Parent               = Dialog

-- Execute button
local ExecBtn = Instance.new("TextButton")
ExecBtn.Size             = UDim2.new(0, 140, 0, 38)
ExecBtn.Position         = UDim2.new(0, 18, 1, -56)
ExecBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 230)
ExecBtn.BorderSizePixel  = 0
ExecBtn.Text             = "▶  Execute"
ExecBtn.TextColor3       = Color3.fromRGB(255, 255, 255)
ExecBtn.TextSize         = 14
ExecBtn.Font             = Enum.Font.GothamBold
ExecBtn.ZIndex           = 3
ExecBtn.Parent           = Dialog
Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 9)

local ExecGrad = Instance.new("UIGradient")
ExecGrad.Color  = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 80, 220)),
})
ExecGrad.Rotation = 90
ExecGrad.Parent   = ExecBtn

ExecBtn.MouseEnter:Connect(function()
    TweenService:Create(ExecBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(90, 140, 255) }):Play()
end)
ExecBtn.MouseLeave:Connect(function()
    TweenService:Create(ExecBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(60, 100, 230) }):Play()
end)

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size             = UDim2.new(0, 140, 0, 38)
CloseBtn.Position         = UDim2.new(1, -158, 1, -56)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
CloseBtn.BorderSizePixel  = 0
CloseBtn.Text             = "✕  Dismiss"
CloseBtn.TextColor3       = Color3.fromRGB(220, 120, 120)
CloseBtn.TextSize         = 14
CloseBtn.Font             = Enum.Font.GothamBold
CloseBtn.ZIndex           = 3
CloseBtn.Parent           = Dialog
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 9)

local CloseBtnStroke = Instance.new("UIStroke")
CloseBtnStroke.Color     = Color3.fromRGB(120, 40, 40)
CloseBtnStroke.Thickness = 1.2
CloseBtnStroke.Parent    = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(80, 30, 30) }):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(50, 20, 20) }):Play()
end)
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Backdrop, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Dialog,   TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
    task.wait(0.4)
    BootGui:Destroy()
end)

-- ── Progress Panel ───────────────────────────────────────────────────
local ProgressBox = Instance.new("Frame")
ProgressBox.Name            = "ProgressBox"
ProgressBox.Size            = UDim2.new(0, 380, 0, 200)
ProgressBox.Position        = UDim2.new(0.5, -190, 0.5, -100)
ProgressBox.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
ProgressBox.BorderSizePixel = 0
ProgressBox.Visible         = false
ProgressBox.ZIndex          = 2
ProgressBox.Parent          = BootGui
Instance.new("UICorner", ProgressBox).CornerRadius = UDim.new(0, 16)

local ProgStroke = Instance.new("UIStroke")
ProgStroke.Color     = Color3.fromRGB(80, 80, 200)
ProgStroke.Thickness = 1.8
ProgStroke.Parent    = ProgressBox

local ProgAccent = Instance.new("Frame")
ProgAccent.Size             = UDim2.new(1, 0, 0, 4)
ProgAccent.BackgroundColor3 = Color3.fromRGB(90, 90, 220)
ProgAccent.BorderSizePixel  = 0
ProgAccent.ZIndex           = 3
ProgAccent.Parent           = ProgressBox
Instance.new("UICorner", ProgAccent).CornerRadius = UDim.new(0, 4)
Instance.new("UIGradient", ProgAccent).Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 60, 255)),
})

local ProgTitle = Instance.new("TextLabel")
ProgTitle.Size                 = UDim2.new(1, -20, 0, 34)
ProgTitle.Position             = UDim2.new(0, 12, 0, 14)
ProgTitle.BackgroundTransparency = 1
ProgTitle.Text                 = "⚡  Loading Universal Sun Hub..."
ProgTitle.TextColor3           = Color3.fromRGB(220, 220, 255)
ProgTitle.TextSize             = 16
ProgTitle.Font                 = Enum.Font.GothamBold
ProgTitle.TextXAlignment       = Enum.TextXAlignment.Left
ProgTitle.ZIndex               = 3
ProgTitle.Parent               = ProgressBox

local StageLabel = Instance.new("TextLabel")
StageLabel.Size                 = UDim2.new(1, -20, 0, 22)
StageLabel.Position             = UDim2.new(0, 12, 0, 52)
StageLabel.BackgroundTransparency = 1
StageLabel.Text                 = "Initializing..."
StageLabel.TextColor3           = Color3.fromRGB(140, 140, 200)
StageLabel.TextSize             = 13
StageLabel.Font                 = Enum.Font.Gotham
StageLabel.TextXAlignment       = Enum.TextXAlignment.Left
StageLabel.ZIndex               = 3
StageLabel.Parent               = ProgressBox

-- Track background
local BarTrack = Instance.new("Frame")
BarTrack.Size             = UDim2.new(1, -30, 0, 10)
BarTrack.Position         = UDim2.new(0, 15, 0, 88)
BarTrack.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
BarTrack.BorderSizePixel  = 0
BarTrack.ZIndex           = 3
BarTrack.Parent           = ProgressBox
Instance.new("UICorner", BarTrack).CornerRadius = UDim.new(1, 0)

-- Fill bar
local BarFill = Instance.new("Frame")
BarFill.Size             = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
BarFill.BorderSizePixel  = 0
BarFill.ZIndex           = 4
BarFill.Parent           = BarTrack
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local FillGrad = Instance.new("UIGradient")
FillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 80, 255)),
})
FillGrad.Parent = BarFill

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size                 = UDim2.new(1, -20, 0, 20)
PercentLabel.Position             = UDim2.new(0, 12, 0, 104)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text                 = "0%"
PercentLabel.TextColor3           = Color3.fromRGB(100, 100, 180)
PercentLabel.TextSize             = 12
PercentLabel.Font                 = Enum.Font.GothamMedium
PercentLabel.TextXAlignment       = Enum.TextXAlignment.Right
PercentLabel.ZIndex               = 3
PercentLabel.Parent               = ProgressBox

local LogLabel = Instance.new("TextLabel")
LogLabel.Size                 = UDim2.new(1, -24, 0, 48)
LogLabel.Position             = UDim2.new(0, 12, 0, 142)
LogLabel.BackgroundTransparency = 1
LogLabel.Text                 = ""
LogLabel.TextColor3           = Color3.fromRGB(80, 80, 140)
LogLabel.TextSize             = 11
LogLabel.Font                 = Enum.Font.Gotham
LogLabel.TextXAlignment       = Enum.TextXAlignment.Left
LogLabel.TextWrapped          = true
LogLabel.ZIndex               = 3
LogLabel.Parent               = ProgressBox

-- ── Progress Helper ───────────────────────────────────────────────────
local function setProgress(pct, stage, log)
    TweenService:Create(BarFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(pct, 0, 1, 0)
    }):Play()
    PercentLabel.Text = math.floor(pct * 100) .. "%"
    if stage then StageLabel.Text = stage end
    if log   then LogLabel.Text   = log   end
end

-- ── Load Sequence ─────────────────────────────────────────────────────
local function runLoadSequence()
    Dialog.Visible      = false
    ProgressBox.Visible = true

    setProgress(0.08, "🔌  Connecting to GitHub...", "raw.githubusercontent.com")
    task.wait(0.5)

    setProgress(0.25, "📡  Fetching loader.lua...", "naitikthakur8273-alt/my_script · main/loader.lua")
    task.wait(0.3)

    local rawCode = nil
    local fetchOk, fetchErr = pcall(function()
        rawCode = game:HttpGet("https://raw.githubusercontent.com/naitikthakur8273-alt/my_script/refs/heads/main/loader.lua")
    end)

    if not fetchOk or not rawCode or #rawCode == 0 then
        setProgress(1.0, "❌  Fetch failed!", tostring(fetchErr))
        ProgStroke.Color   = Color3.fromRGB(200, 50, 50)
        ProgTitle.Text     = "⚠  Fetch Error"
        ProgTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[main_loader] Fetch error: " .. tostring(fetchErr))
        return
    end

    setProgress(0.45, "🔧  Compiling...", "Parsing loader.lua source")
    task.wait(0.2)

    local fn, compileErr = loadstring(rawCode)
    if not fn then
        setProgress(1.0, "❌  Compile error!", tostring(compileErr))
        ProgStroke.Color   = Color3.fromRGB(200, 50, 50)
        ProgTitle.Text     = "⚠  Compile Error"
        ProgTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[main_loader] Compile error: " .. tostring(compileErr))
        return
    end

    setProgress(0.60, "🚀  Running loader.lua...", "Executing hub script")
    task.wait(0.2)

    local runOk, runErr = pcall(fn)
    if not runOk then
        setProgress(1.0, "❌  Runtime error!", tostring(runErr))
        ProgStroke.Color   = Color3.fromRGB(200, 50, 50)
        ProgTitle.Text     = "⚠  Runtime Error"
        ProgTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[main_loader] Runtime error: " .. tostring(runErr))
        return
    end

    setProgress(0.80, "🎨  Loading Rayfield UI...", "Downloading Rayfield library from sirius.menu")
    task.wait(0.5)

    setProgress(0.92, "📦  Registering scripts & features...", "20 scripts · 7 features · settings restored")
    task.wait(0.4)

    setProgress(1.0, "✅  Done! Hub is ready.", "Universal Sun Hub loaded successfully.")
    ProgStroke.Color = Color3.fromRGB(60, 200, 100)
    task.wait(0.8)

    TweenService:Create(Backdrop,     TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(ProgressBox,  TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
    task.wait(0.55)
    BootGui:Destroy()
end

-- ── Button Wiring ────────────────────────────────────────────────────
ExecBtn.MouseButton1Click:Connect(function()
    ExecBtn.Active            = false
    ExecBtn.Text              = "Loading..."
    ExecBtn.BackgroundColor3  = Color3.fromRGB(40, 70, 160)
    task.delay(0.15, runLoadSequence)
end)
