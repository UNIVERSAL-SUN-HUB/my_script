-- main_loader.lua
-- Paste into your executor. Shows a confirm menu then loads loader.lua from GitHub.

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ──────────────────────────────────────────────
-- ScreenGui
-- ──────────────────────────────────────────────
local BootGui = Instance.new("ScreenGui")
BootGui.Name = "BootGui"
BootGui.ResetOnSpawn = false
BootGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BootGui.Parent = playerGui

-- ──────────────────────────────────────────────
-- Backdrop
-- ──────────────────────────────────────────────
local Backdrop = Instance.new("Frame")
Backdrop.Size = UDim2.new(1, 0, 1, 0)
Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Backdrop.BackgroundTransparency = 0.45
Backdrop.BorderSizePixel = 0
Backdrop.ZIndex = 1
Backdrop.Parent = BootGui

-- ──────────────────────────────────────────────
-- Confirm Dialog
-- ──────────────────────────────────────────────
local ConfirmBox = Instance.new("Frame")
ConfirmBox.Size = UDim2.new(0, 320, 0, 200)
ConfirmBox.Position = UDim2.new(0.5, -160, 0.5, -100)
ConfirmBox.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
ConfirmBox.BorderSizePixel = 0
ConfirmBox.ZIndex = 2
ConfirmBox.Parent = BootGui
Instance.new("UICorner", ConfirmBox).CornerRadius = UDim.new(0, 14)

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Color = Color3.fromRGB(70, 70, 160)
ConfirmStroke.Thickness = 1.5
ConfirmStroke.Parent = ConfirmBox

local IconLabel = Instance.new("TextLabel")
IconLabel.Size = UDim2.new(1, 0, 0, 48)
IconLabel.Position = UDim2.new(0, 0, 0, 14)
IconLabel.BackgroundTransparency = 1
IconLabel.Text = "⚡"
IconLabel.TextSize = 36
IconLabel.Font = Enum.Font.GothamBold
IconLabel.TextColor3 = Color3.fromRGB(160, 160, 255)
IconLabel.ZIndex = 3
IconLabel.Parent = ConfirmBox

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -20, 0, 28)
TitleText.Position = UDim2.new(0, 10, 0, 62)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Loader  ·  Ready to execute"
TitleText.TextColor3 = Color3.fromRGB(220, 220, 255)
TitleText.TextSize = 17
TitleText.Font = Enum.Font.GothamBold
TitleText.ZIndex = 3
TitleText.Parent = ConfirmBox

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(1, -20, 0, 44)
SubText.Position = UDim2.new(0, 10, 0, 94)
SubText.BackgroundTransparency = 1
SubText.Text = "Do you want to execute the Loader?\nThis will load all scripts and open the menu."
SubText.TextColor3 = Color3.fromRGB(140, 140, 190)
SubText.TextSize = 13
SubText.Font = Enum.Font.Gotham
SubText.TextWrapped = true
SubText.ZIndex = 3
SubText.Parent = ConfirmBox

local ExecBtn = Instance.new("TextButton")
ExecBtn.Size = UDim2.new(0, 130, 0, 36)
ExecBtn.Position = UDim2.new(0, 20, 1, -52)
ExecBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 220)
ExecBtn.BorderSizePixel = 0
ExecBtn.Text = "▶  Execute"
ExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBtn.TextSize = 14
ExecBtn.Font = Enum.Font.GothamBold
ExecBtn.ZIndex = 3
ExecBtn.Parent = ConfirmBox
Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 8)

ExecBtn.MouseEnter:Connect(function()
    TweenService:Create(ExecBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(80, 130, 255) }):Play()
end)
ExecBtn.MouseLeave:Connect(function()
    TweenService:Create(ExecBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(60, 100, 220) }):Play()
end)

-- ──────────────────────────────────────────────
-- Close Button
-- ──────────────────────────────────────────────
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 130, 0, 36)
CloseBtn.Position = UDim2.new(1, -150, 1, -52)
CloseBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕  Close"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 3
CloseBtn.Parent = ConfirmBox
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(210, 60, 60) }):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(160, 40, 40) }):Play()
end)
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Backdrop,    TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(ConfirmBox,  TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    task.wait(0.35)
    BootGui:Destroy()
end)

-- ──────────────────────────────────────────────
-- Progress Panel
-- ──────────────────────────────────────────────
local ProgressBox = Instance.new("Frame")
ProgressBox.Size = UDim2.new(0, 360, 0, 190)
ProgressBox.Position = UDim2.new(0.5, -180, 0.5, -95)
ProgressBox.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
ProgressBox.BorderSizePixel = 0
ProgressBox.ZIndex = 2
ProgressBox.Visible = false
ProgressBox.Parent = BootGui
Instance.new("UICorner", ProgressBox).CornerRadius = UDim.new(0, 14)

local ProgressStroke = Instance.new("UIStroke")
ProgressStroke.Color = Color3.fromRGB(70, 70, 160)
ProgressStroke.Thickness = 1.5
ProgressStroke.Parent = ProgressBox

local ProgressTitle = Instance.new("TextLabel")
ProgressTitle.Size = UDim2.new(1, -20, 0, 34)
ProgressTitle.Position = UDim2.new(0, 10, 0, 12)
ProgressTitle.BackgroundTransparency = 1
ProgressTitle.Text = "⚡  Loading Loader..."
ProgressTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
ProgressTitle.TextSize = 16
ProgressTitle.Font = Enum.Font.GothamBold
ProgressTitle.TextXAlignment = Enum.TextXAlignment.Left
ProgressTitle.ZIndex = 3
ProgressTitle.Parent = ProgressBox

local StageLabel = Instance.new("TextLabel")
StageLabel.Size = UDim2.new(1, -20, 0, 22)
StageLabel.Position = UDim2.new(0, 10, 0, 50)
StageLabel.BackgroundTransparency = 1
StageLabel.Text = "Initializing..."
StageLabel.TextColor3 = Color3.fromRGB(140, 140, 200)
StageLabel.TextSize = 13
StageLabel.Font = Enum.Font.Gotham
StageLabel.TextXAlignment = Enum.TextXAlignment.Left
StageLabel.ZIndex = 3
StageLabel.Parent = ProgressBox

local BarTrack = Instance.new("Frame")
BarTrack.Size = UDim2.new(1, -30, 0, 14)
BarTrack.Position = UDim2.new(0, 15, 0, 86)
BarTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
BarTrack.BorderSizePixel = 0
BarTrack.ZIndex = 3
BarTrack.Parent = ProgressBox
Instance.new("UICorner", BarTrack).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
BarFill.BorderSizePixel = 0
BarFill.ZIndex = 4
BarFill.Parent = BarTrack
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, -20, 0, 20)
PercentLabel.Position = UDim2.new(0, 10, 0, 106)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(100, 100, 160)
PercentLabel.TextSize = 12
PercentLabel.Font = Enum.Font.GothamMedium
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
PercentLabel.ZIndex = 3
PercentLabel.Parent = ProgressBox

local LogLabel = Instance.new("TextLabel")
LogLabel.Size = UDim2.new(1, -20, 0, 44)
LogLabel.Position = UDim2.new(0, 10, 0, 132)
LogLabel.BackgroundTransparency = 1
LogLabel.Text = ""
LogLabel.TextColor3 = Color3.fromRGB(80, 80, 130)
LogLabel.TextSize = 11
LogLabel.Font = Enum.Font.Gotham
LogLabel.TextXAlignment = Enum.TextXAlignment.Left
LogLabel.TextWrapped = true
LogLabel.ZIndex = 3
LogLabel.Parent = ProgressBox

-- ──────────────────────────────────────────────
-- Progress Helper
-- ──────────────────────────────────────────────
local function setProgress(pct, stage, log)
    TweenService:Create(BarFill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(pct, 0, 1, 0)
    }):Play()
    local r = math.floor(80  + (0   - 80)  * pct)
    local g = math.floor(120 + (200 - 120) * pct)
    local b = math.floor(255 + (100 - 255) * pct)
    TweenService:Create(BarFill, TweenInfo.new(0.35), {
        BackgroundColor3 = Color3.fromRGB(r, g, b)
    }):Play()
    PercentLabel.Text = math.floor(pct * 100) .. "%"
    if stage then StageLabel.Text = stage end
    if log   then LogLabel.Text   = log   end
end

-- ──────────────────────────────────────────────
-- Load Sequence
-- ──────────────────────────────────────────────
local function runLoadSequence()
    ConfirmBox.Visible  = false
    ProgressBox.Visible = true

    setProgress(0.10, "🔌  Connecting to GitHub...", "Reaching raw.githubusercontent.com")
    task.wait(0.5)

    setProgress(0.30, "📡  Fetching loader.lua...", "naitikthakur8273-alt/my_script · main/loader.lua")
    task.wait(0.3)

    -- Actual fetch happens here
    local rawCode = nil
    local fetchOk, fetchErr = pcall(function()
        rawCode = game:HttpGet("https://raw.githubusercontent.com/naitikthakur8273-alt/my_script/refs/heads/main/loader.lua")
    end)

    if not fetchOk or rawCode == nil or #rawCode == 0 then
        setProgress(1.0, "❌  Failed to fetch!", tostring(fetchErr))
        ProgressStroke.Color = Color3.fromRGB(200, 50, 50)
        BarFill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        ProgressTitle.Text = "⚠  Fetch Error"
        ProgressTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[main_loader] Fetch error: " .. tostring(fetchErr))
        return
    end

    -- Compile
    local fn, compileErr = loadstring(rawCode)
    if not fn then
        setProgress(1.0, "❌  Compile error!", tostring(compileErr))
        ProgressStroke.Color = Color3.fromRGB(200, 50, 50)
        BarFill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        ProgressTitle.Text = "⚠  Compile Error"
        ProgressTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[main_loader] Compile error: " .. tostring(compileErr))
        return
    end

    -- Run
    local runOk, runErr = pcall(fn)
    if not runOk then
        setProgress(1.0, "❌  Runtime error!", tostring(runErr))
        ProgressStroke.Color = Color3.fromRGB(200, 50, 50)
        BarFill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        ProgressTitle.Text = "⚠  Runtime Error"
        ProgressTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[main_loader] Runtime error: " .. tostring(runErr))
        return
    end

    setProgress(0.60, "🗂  Parsing scripts...", "Reading 27 embedded script entries")
    task.wait(0.4)

    setProgress(0.78, "🎨  Building UI...", "Constructing menu frames, tabs, cards")
    task.wait(0.4)

    setProgress(0.92, "⌨️  Registering keybinds...", "LControl toggle · drag · confirm dialog")
    task.wait(0.35)

    setProgress(1.0, "🚀  Done! Launching menu...", "All scripts loaded successfully.")
    ProgressStroke.Color = Color3.fromRGB(60, 200, 100)
    task.wait(0.65)

    -- Fade out and destroy boot screen
    TweenService:Create(Backdrop,    TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(ProgressBox, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
    task.wait(0.55)
    BootGui:Destroy()
end

-- ──────────────────────────────────────────────
-- Execute button
-- ──────────────────────────────────────────────
ExecBtn.MouseButton1Click:Connect(function()
    ExecBtn.Active = false
    ExecBtn.Text = "Loading..."
    ExecBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 160)
    task.delay(0.15, runLoadSequence)
end)
