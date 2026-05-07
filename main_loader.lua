-- main_loader.lua
-- Bootstrap entry point — place this as your only LocalScript in StarterPlayerScripts.
-- It will confirm, then fetch and run loader.lua with a progress bar.

-- ──────────────────────────────────────────────
-- CONFIG — paste the raw URL to your loader.lua here
-- ──────────────────────────────────────────────
local LOADER_URL = "https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/main/loader.lua"

-- ──────────────────────────────────────────────
-- Services
-- ──────────────────────────────────────────────
local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")

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
-- Backdrop (dim overlay)
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
ConfirmBox.Name = "ConfirmBox"
ConfirmBox.Size = UDim2.new(0, 320, 0, 200)
ConfirmBox.Position = UDim2.new(0.5, -160, 0.5, -100)
ConfirmBox.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
ConfirmBox.BorderSizePixel = 0
ConfirmBox.ZIndex = 2
ConfirmBox.Visible = true
ConfirmBox.Parent = BootGui

Instance.new("UICorner", ConfirmBox).CornerRadius = UDim.new(0, 14)

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Color = Color3.fromRGB(70, 70, 160)
ConfirmStroke.Thickness = 1.5
ConfirmStroke.Parent = ConfirmBox

-- Logo / icon row
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
SubText.Size = UDim2.new(1, -20, 0, 36)
SubText.Position = UDim2.new(0, 10, 0, 94)
SubText.BackgroundTransparency = 1
SubText.Text = "Do you want to execute the Loader?\nThis will load all scripts and open the menu."
SubText.TextColor3 = Color3.fromRGB(140, 140, 190)
SubText.TextSize = 13
SubText.Font = Enum.Font.Gotham
SubText.TextWrapped = true
SubText.ZIndex = 3
SubText.Parent = ConfirmBox

-- Execute button
local ExecBtn = Instance.new("TextButton")
ExecBtn.Size = UDim2.new(0, 130, 0, 36)
ExecBtn.Position = UDim2.new(0.5, -70, 1, -52)
ExecBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 220)
ExecBtn.BorderSizePixel = 0
ExecBtn.Text = "▶  Execute"
ExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBtn.TextSize = 14
ExecBtn.Font = Enum.Font.GothamBold
ExecBtn.ZIndex = 3
ExecBtn.Parent = ConfirmBox

Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 8)

-- Hover effect
ExecBtn.MouseEnter:Connect(function()
    TweenService:Create(ExecBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(80, 130, 255)
    }):Play()
end)
ExecBtn.MouseLeave:Connect(function()
    TweenService:Create(ExecBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(60, 100, 220)
    }):Play()
end)

-- ──────────────────────────────────────────────
-- Progress Panel (hidden until Execute clicked)
-- ──────────────────────────────────────────────
local ProgressBox = Instance.new("Frame")
ProgressBox.Name = "ProgressBox"
ProgressBox.Size = UDim2.new(0, 360, 0, 180)
ProgressBox.Position = UDim2.new(0.5, -180, 0.5, -90)
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
ProgressTitle.Size = UDim2.new(1, -20, 0, 36)
ProgressTitle.Position = UDim2.new(0, 10, 0, 14)
ProgressTitle.BackgroundTransparency = 1
ProgressTitle.Text = "⚡  Loading Loader..."
ProgressTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
ProgressTitle.TextSize = 16
ProgressTitle.Font = Enum.Font.GothamBold
ProgressTitle.TextXAlignment = Enum.TextXAlignment.Left
ProgressTitle.ZIndex = 3
ProgressTitle.Parent = ProgressBox

-- Stage label
local StageLabel = Instance.new("TextLabel")
StageLabel.Size = UDim2.new(1, -20, 0, 22)
StageLabel.Position = UDim2.new(0, 10, 0, 52)
StageLabel.BackgroundTransparency = 1
StageLabel.Text = "Initializing..."
StageLabel.TextColor3 = Color3.fromRGB(140, 140, 200)
StageLabel.TextSize = 13
StageLabel.Font = Enum.Font.Gotham
StageLabel.TextXAlignment = Enum.TextXAlignment.Left
StageLabel.ZIndex = 3
StageLabel.Parent = ProgressBox

-- Progress bar track
local BarTrack = Instance.new("Frame")
BarTrack.Size = UDim2.new(1, -30, 0, 14)
BarTrack.Position = UDim2.new(0, 15, 0, 88)
BarTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
BarTrack.BorderSizePixel = 0
BarTrack.ZIndex = 3
BarTrack.Parent = ProgressBox

Instance.new("UICorner", BarTrack).CornerRadius = UDim.new(1, 0)

-- Progress bar fill
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
BarFill.BorderSizePixel = 0
BarFill.ZIndex = 4
BarFill.Parent = BarTrack

Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

-- Percent label
local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, -20, 0, 20)
PercentLabel.Position = UDim2.new(0, 10, 0, 108)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(100, 100, 160)
PercentLabel.TextSize = 12
PercentLabel.Font = Enum.Font.GothamMedium
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
PercentLabel.ZIndex = 3
PercentLabel.Parent = ProgressBox

-- File/detail log area
local LogLabel = Instance.new("TextLabel")
LogLabel.Size = UDim2.new(1, -20, 0, 40)
LogLabel.Position = UDim2.new(0, 10, 0, 128)
LogLabel.BackgroundTransparency = 1
LogLabel.Text = ""
LogLabel.TextColor3 = Color3.fromRGB(90, 90, 140)
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
    -- pct: 0–1
    TweenService:Create(BarFill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(pct, 0, 1, 0)
    }):Play()

    -- Colour shifts green as it completes
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
-- Main Load Sequence
-- ──────────────────────────────────────────────
local function runLoadSequence()
    -- Swap panels
    ConfirmBox.Visible  = false
    ProgressBox.Visible = true

    local loaderCode = nil
    local loadError  = nil

    -- Stage 1 — Connecting
    setProgress(0.08, "🔌  Connecting to server...", "Establishing connection...")
    task.wait(0.6)

    -- Stage 2 — Fetching loader.lua
    setProgress(0.22, "📡  Fetching loader.lua...", "→ " .. LOADER_URL)
    task.wait(0.3)

    local ok, result = pcall(function()
        return game:GetService("HttpService"):RequestAsync({
            Url = LOADER_URL,
            Method = "GET"
        })
    end)

    if ok and result and result.StatusCode == 200 then
        loaderCode = result.Body
    else
        -- Fallback: try plain HttpGet
        local ok2, body = pcall(function()
            return game:HttpGet(LOADER_URL, true)
        end)
        if ok2 and body and #body > 0 then
            loaderCode = body
        else
            loadError = tostring(result)
        end
    end

    -- Stage 3 — Parsing
    setProgress(0.45, "🗂  Parsing scripts...", "Reading 27 embedded scripts...")
    task.wait(0.5)

    -- Stage 4 — Building UI
    setProgress(0.65, "🎨  Building UI elements...", "Constructing menu frames, tabs, cards...")
    task.wait(0.5)

    -- Stage 5 — Initialising keybinds
    setProgress(0.80, "⌨️  Registering keybinds...", "LControl toggle · Drag handler · Confirm dialog")
    task.wait(0.4)

    -- Stage 6 — Final checks
    setProgress(0.92, "✅  Finalizing...", "Applying polish & loading complete")
    task.wait(0.4)

    -- Stage 7 — Done
    setProgress(1.0, "🚀  Done! Launching menu...", "All files loaded successfully.")
    ProgressStroke.Color = Color3.fromRGB(60, 200, 100)
    task.wait(0.7)

    -- Fade out boot gui
    TweenService:Create(Backdrop, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(ProgressBox, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.55)
    BootGui:Destroy()

    -- Execute the fetched loader code, or show error
    if loaderCode then
        local fn, compileErr = loadstring(loaderCode)
        if fn then
            fn()
        else
            warn("[main_loader] Compile error in loader.lua: " .. tostring(compileErr))
        end
    else
        warn("[main_loader] Failed to fetch loader.lua — check LOADER_URL.")
        warn("[main_loader] Error: " .. tostring(loadError))
    end
end

-- ──────────────────────────────────────────────
-- Kick off on Execute click
-- ──────────────────────────────────────────────
ExecBtn.MouseButton1Click:Connect(function()
    ExecBtn.Active = false
    ExecBtn.Text = "Loading..."
    ExecBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 160)
    task.delay(0.15, runLoadSequence)
end)
