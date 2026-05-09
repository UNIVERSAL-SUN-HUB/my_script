-- loader_to_run_main.lua
-- Paste into your executor. Choose between Rayfield UI or Normal UI.

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- URLs
local URL_RAYFIELD = "https://raw.githubusercontent.com/naitikthakur8273-alt/my_script/refs/heads/main/loader.lua"
local URL_NORMAL   = "https://raw.githubusercontent.com/naitikthakur8273-alt/my_script/refs/heads/main/NORMAL_UI_LOADER.lua"

-- ── ScreenGui ─────────────────────────────────────────────────────────
local BootGui = Instance.new("ScreenGui")
BootGui.Name           = "USHBootGui"
BootGui.ResetOnSpawn   = false
BootGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BootGui.Parent         = playerGui

-- ── Full-screen dim ───────────────────────────────────────────────────
local Backdrop = Instance.new("Frame")
Backdrop.Size                   = UDim2.new(1, 0, 1, 0)
Backdrop.BackgroundColor3       = Color3.fromRGB(0, 0, 0)
Backdrop.BackgroundTransparency = 0.45
Backdrop.BorderSizePixel        = 0
Backdrop.ZIndex                 = 1
Backdrop.Parent                 = BootGui

-- ── Choose Dialog ─────────────────────────────────────────────────────
local Dialog = Instance.new("Frame")
Dialog.Name             = "Dialog"
Dialog.Size             = UDim2.new(0, 370, 0, 310)
Dialog.Position         = UDim2.new(0.5, -185, 0.5, -155)
Dialog.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
Dialog.BorderSizePixel  = 0
Dialog.ZIndex           = 2
Dialog.Parent           = BootGui
local dlgCorner = Instance.new("UICorner", Dialog)
dlgCorner.CornerRadius = UDim.new(0, 16)

local DialogStroke = Instance.new("UIStroke", Dialog)
DialogStroke.Color     = Color3.fromRGB(80, 80, 200)
DialogStroke.Thickness = 1.8

-- Accent bar
local AccentBar = Instance.new("Frame", Dialog)
AccentBar.Size             = UDim2.new(1, 0, 0, 4)
AccentBar.BackgroundColor3 = Color3.fromRGB(90, 90, 220)
AccentBar.BorderSizePixel  = 0
AccentBar.ZIndex           = 3
Instance.new("UICorner", AccentBar).CornerRadius = UDim.new(0, 4)
Instance.new("UIGradient", AccentBar).Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60,  80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 60, 255)),
})

-- Icon
local IconLabel = Instance.new("TextLabel", Dialog)
IconLabel.Size                   = UDim2.new(1, 0, 0, 46)
IconLabel.Position               = UDim2.new(0, 0, 0, 12)
IconLabel.BackgroundTransparency = 1
IconLabel.Text                   = "⚡"
IconLabel.TextSize               = 36
IconLabel.Font                   = Enum.Font.GothamBold
IconLabel.TextColor3             = Color3.fromRGB(160, 160, 255)
IconLabel.ZIndex                 = 3

-- Title
local TitleLabel = Instance.new("TextLabel", Dialog)
TitleLabel.Size                   = UDim2.new(1, -24, 0, 26)
TitleLabel.Position               = UDim2.new(0, 12, 0, 60)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text                   = "Universal Sun Hub  ·  Choose UI Mode"
TitleLabel.TextColor3             = Color3.fromRGB(230, 230, 255)
TitleLabel.TextSize               = 16
TitleLabel.Font                   = Enum.Font.GothamBold
TitleLabel.ZIndex                 = 3

-- Subtitle
local SubLabel = Instance.new("TextLabel", Dialog)
SubLabel.Size                   = UDim2.new(1, -24, 0, 30)
SubLabel.Position               = UDim2.new(0, 12, 0, 90)
SubLabel.BackgroundTransparency = 1
SubLabel.Text                   = "Select which version of the hub you want to load."
SubLabel.TextColor3             = Color3.fromRGB(120, 120, 170)
SubLabel.TextSize               = 12
SubLabel.Font                   = Enum.Font.Gotham
SubLabel.TextWrapped            = true
SubLabel.ZIndex                 = 3

-- ── Option Card builder ───────────────────────────────────────────────
local function makeCard(yPos, icon, titleText, line1, line2, bgCol, borderCol)
    local card = Instance.new("Frame", Dialog)
    card.Size             = UDim2.new(1, -24, 0, 72)
    card.Position         = UDim2.new(0, 12, 0, yPos)
    card.BackgroundColor3 = bgCol
    card.BorderSizePixel  = 0
    card.ZIndex           = 3
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = borderCol stroke.Thickness = 1.5

    local ico = Instance.new("TextLabel", card)
    ico.Size = UDim2.new(0, 50, 1, 0) ico.BackgroundTransparency = 1
    ico.Text = icon ico.TextSize = 28 ico.Font = Enum.Font.GothamBold
    ico.TextColor3 = Color3.new(1, 1, 1) ico.ZIndex = 4

    local t = Instance.new("TextLabel", card)
    t.Size = UDim2.new(1, -58, 0, 24) t.Position = UDim2.new(0, 52, 0, 8)
    t.BackgroundTransparency = 1 t.Text = titleText
    t.TextColor3 = Color3.new(1, 1, 1) t.TextSize = 14 t.Font = Enum.Font.GothamBold
    t.TextXAlignment = Enum.TextXAlignment.Left t.ZIndex = 4

    local l1 = Instance.new("TextLabel", card)
    l1.Size = UDim2.new(1, -58, 0, 18) l1.Position = UDim2.new(0, 52, 0, 32)
    l1.BackgroundTransparency = 1 l1.Text = line1
    l1.TextColor3 = Color3.fromRGB(180, 180, 230) l1.TextSize = 11 l1.Font = Enum.Font.Gotham
    l1.TextXAlignment = Enum.TextXAlignment.Left l1.ZIndex = 4

    local l2 = Instance.new("TextLabel", card)
    l2.Size = UDim2.new(1, -58, 0, 18) l2.Position = UDim2.new(0, 52, 0, 50)
    l2.BackgroundTransparency = 1 l2.Text = line2
    l2.TextColor3 = Color3.fromRGB(120, 120, 170) l2.TextSize = 10 l2.Font = Enum.Font.Gotham
    l2.TextXAlignment = Enum.TextXAlignment.Left l2.ZIndex = 4

    -- invisible click overlay
    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(1, 0, 1, 0) btn.BackgroundTransparency = 1
    btn.Text = "" btn.ZIndex = 5
    btn.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), { BackgroundColor3 = bgCol:Lerp(Color3.new(1,1,1), 0.06) }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), { BackgroundColor3 = bgCol }):Play()
    end)
    return btn, card
end

local RayfieldBtn, RayfieldCard = makeCard(
    130, "⚡",
    "Rayfield UI",
    "PC: Good · Mobile: Good · UI Quality: Best",
    "Full Rayfield library · polished animations · rich controls",
    Color3.fromRGB(20, 25, 55),
    Color3.fromRGB(70, 100, 240)
)

local NormalBtn, NormalCard = makeCard(
    212, "🖥",
    "Normal UI",
    "PC: Best · Mobile: Best · UI Quality: Good",
    "No external library · lighter · works on all executors",
    Color3.fromRGB(18, 35, 22),
    Color3.fromRGB(50, 180, 90)
)

-- Dismiss button
local CloseBtn = Instance.new("TextButton", Dialog)
CloseBtn.Size             = UDim2.new(1, -24, 0, 32)
CloseBtn.Position         = UDim2.new(0, 12, 1, -42)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 20, 20)
CloseBtn.BorderSizePixel  = 0
CloseBtn.Text             = "✕  Dismiss"
CloseBtn.TextColor3       = Color3.fromRGB(200, 100, 100)
CloseBtn.TextSize         = 12
CloseBtn.Font             = Enum.Font.GothamBold
CloseBtn.ZIndex           = 3
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
local closeBtnStroke = Instance.new("UIStroke", CloseBtn)
closeBtnStroke.Color = Color3.fromRGB(100, 35, 35) closeBtnStroke.Thickness = 1.2
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(60, 25, 25) }):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(35, 20, 20) }):Play()
end)
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Backdrop, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Dialog,   TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
    task.wait(0.4) BootGui:Destroy()
end)

-- ── Progress Panel ────────────────────────────────────────────────────
local ProgressBox = Instance.new("Frame")
ProgressBox.Name             = "ProgressBox"
ProgressBox.Size             = UDim2.new(0, 380, 0, 210)
ProgressBox.Position         = UDim2.new(0.5, -190, 0.5, -105)
ProgressBox.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
ProgressBox.BorderSizePixel  = 0
ProgressBox.Visible          = false
ProgressBox.ZIndex           = 2
ProgressBox.Parent           = BootGui
Instance.new("UICorner", ProgressBox).CornerRadius = UDim.new(0, 16)

local ProgStroke = Instance.new("UIStroke", ProgressBox)
ProgStroke.Color = Color3.fromRGB(80, 80, 200) ProgStroke.Thickness = 1.8

local ProgAccent = Instance.new("Frame", ProgressBox)
ProgAccent.Size = UDim2.new(1, 0, 0, 4) ProgAccent.BackgroundColor3 = Color3.fromRGB(90, 90, 220) ProgAccent.BorderSizePixel = 0
Instance.new("UICorner", ProgAccent).CornerRadius = UDim.new(0, 4)
Instance.new("UIGradient", ProgAccent).Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 60, 255)),
})

local ProgTitle = Instance.new("TextLabel", ProgressBox)
ProgTitle.Size = UDim2.new(1, -20, 0, 34) ProgTitle.Position = UDim2.new(0, 12, 0, 14)
ProgTitle.BackgroundTransparency = 1 ProgTitle.Text = "⚡  Loading Universal Sun Hub..."
ProgTitle.TextColor3 = Color3.fromRGB(220, 220, 255) ProgTitle.TextSize = 15 ProgTitle.Font = Enum.Font.GothamBold
ProgTitle.TextXAlignment = Enum.TextXAlignment.Left

local StageLabel = Instance.new("TextLabel", ProgressBox)
StageLabel.Size = UDim2.new(1, -20, 0, 22) StageLabel.Position = UDim2.new(0, 12, 0, 52)
StageLabel.BackgroundTransparency = 1 StageLabel.Text = "Initializing..."
StageLabel.TextColor3 = Color3.fromRGB(140, 140, 200) StageLabel.TextSize = 12 StageLabel.Font = Enum.Font.Gotham
StageLabel.TextXAlignment = Enum.TextXAlignment.Left

local BarTrack = Instance.new("Frame", ProgressBox)
BarTrack.Size = UDim2.new(1, -30, 0, 10) BarTrack.Position = UDim2.new(0, 15, 0, 88)
BarTrack.BackgroundColor3 = Color3.fromRGB(25, 25, 45) BarTrack.BorderSizePixel = 0
Instance.new("UICorner", BarTrack).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame", BarTrack)
BarFill.Size = UDim2.new(0, 0, 1, 0) BarFill.BackgroundColor3 = Color3.fromRGB(80, 120, 255) BarFill.BorderSizePixel = 0
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)
local FillGrad = Instance.new("UIGradient", BarFill)
FillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 80, 255)),
})

local PercentLabel = Instance.new("TextLabel", ProgressBox)
PercentLabel.Size = UDim2.new(1, -20, 0, 20) PercentLabel.Position = UDim2.new(0, 12, 0, 104)
PercentLabel.BackgroundTransparency = 1 PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(100, 100, 180) PercentLabel.TextSize = 11 PercentLabel.Font = Enum.Font.GothamMedium
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right

local ModeLabel = Instance.new("TextLabel", ProgressBox)
ModeLabel.Size = UDim2.new(1, -20, 0, 20) ModeLabel.Position = UDim2.new(0, 12, 0, 104)
ModeLabel.BackgroundTransparency = 1 ModeLabel.Text = ""
ModeLabel.TextColor3 = Color3.fromRGB(130, 130, 200) ModeLabel.TextSize = 11 ModeLabel.Font = Enum.Font.GothamBold
ModeLabel.TextXAlignment = Enum.TextXAlignment.Left

local LogLabel = Instance.new("TextLabel", ProgressBox)
LogLabel.Size = UDim2.new(1, -24, 0, 52) LogLabel.Position = UDim2.new(0, 12, 0, 148)
LogLabel.BackgroundTransparency = 1 LogLabel.Text = ""
LogLabel.TextColor3 = Color3.fromRGB(80, 80, 140) LogLabel.TextSize = 10 LogLabel.Font = Enum.Font.Gotham
LogLabel.TextXAlignment = Enum.TextXAlignment.Left LogLabel.TextWrapped = true

-- ── Progress Helper ───────────────────────────────────────────────────
local function setProgress(pct, stage, log)
    TweenService:Create(BarFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(pct, 0, 1, 0)
    }):Play()
    PercentLabel.Text = math.floor(pct * 100) .. "%"
    if stage then StageLabel.Text = stage end
    if log   then LogLabel.Text   = log   end
end

-- ── Generic load sequence ─────────────────────────────────────────────
local function runLoad(url, modeName, stages)
    Dialog.Visible      = false
    ProgressBox.Visible = true
    ModeLabel.Text      = modeName

    setProgress(0.08, stages[1], url) task.wait(0.5)
    setProgress(0.25, stages[2], url) task.wait(0.3)

    local rawCode = nil
    local fetchOk, fetchErr = pcall(function()
        rawCode = game:HttpGet(url)
    end)

    if not fetchOk or not rawCode or #rawCode == 0 then
        setProgress(1.0, "❌  Fetch failed!", tostring(fetchErr))
        ProgStroke.Color     = Color3.fromRGB(200, 50, 50)
        ProgTitle.Text       = "⚠  Fetch Error"
        ProgTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[loader_to_run_main] Fetch error: " .. tostring(fetchErr))
        return
    end

    setProgress(0.45, stages[3], "Parsing source...") task.wait(0.2)

    local fn, compileErr = loadstring(rawCode)
    if not fn then
        setProgress(1.0, "❌  Compile error!", tostring(compileErr))
        ProgStroke.Color     = Color3.fromRGB(200, 50, 50)
        ProgTitle.Text       = "⚠  Compile Error"
        ProgTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[loader_to_run_main] Compile error: " .. tostring(compileErr))
        return
    end

    setProgress(0.60, stages[4], "Running "..modeName.."...") task.wait(0.2)

    local runOk, runErr = pcall(fn)
    if not runOk then
        setProgress(1.0, "❌  Runtime error!", tostring(runErr))
        ProgStroke.Color     = Color3.fromRGB(200, 50, 50)
        ProgTitle.Text       = "⚠  Runtime Error"
        ProgTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[loader_to_run_main] Runtime error: " .. tostring(runErr))
        return
    end

    setProgress(0.82, stages[5], "Registering scripts & features...")  task.wait(0.4)
    setProgress(1.0,  "✅  Done! Hub is ready.", modeName.." loaded successfully.")
    ProgStroke.Color = Color3.fromRGB(60, 200, 100) task.wait(0.8)

    TweenService:Create(Backdrop,    TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(ProgressBox, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
    task.wait(0.55) BootGui:Destroy()
end

-- ── Button wiring ─────────────────────────────────────────────────────
local function lockCards()
    RayfieldBtn.Active = false
    NormalBtn.Active   = false
    CloseBtn.Active    = false
end

RayfieldBtn.MouseButton1Click:Connect(function()
    lockCards()
    TweenService:Create(RayfieldCard, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(30, 40, 90) }):Play()
    ProgTitle.Text = "⚡  Loading Rayfield UI..."
    task.delay(0.15, function()
        runLoad(URL_RAYFIELD, "Rayfield UI", {
            "🔌  Connecting to GitHub...",
            "📡  Fetching loader.lua...",
            "🔧  Compiling loader.lua...",
            "🚀  Starting Rayfield hub...",
            "🎨  Loading Rayfield library...",
        })
    end)
end)

NormalBtn.MouseButton1Click:Connect(function()
    lockCards()
    TweenService:Create(NormalCard, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(20, 55, 28) }):Play()
    ProgTitle.Text = "🖥  Loading Normal UI..."
    task.delay(0.15, function()
        runLoad(URL_NORMAL, "Normal UI", {
            "🔌  Connecting to GitHub...",
            "📡  Fetching NORMAL_UI_LOADER.lua...",
            "🔧  Compiling NORMAL_UI_LOADER.lua...",
            "🚀  Starting Normal UI hub...",
            "📦  Registering scripts & features...",
        })
    end)
end)
