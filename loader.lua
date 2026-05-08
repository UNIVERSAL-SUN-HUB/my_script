-- Loader UI Script
-- Place in StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ──────────────────────────────────────────────
-- Settings  (saved to file, loaded on startup)
-- ──────────────────────────────────────────────
local SETTINGS_FILE = "naitik_hub_settings.txt"

local settings = {
    menuKey       = "LeftControl",
    ijEnabled     = false,
    speedVal      = 16,
    spinEnabled   = false,
    spinSpeedVal  = 20,
    noclipEnabled = false,
    flyEnabled    = false,
    flySpeedVal   = 50,
    espEnabled    = false,
    hitboxEnabled = false,
    hitboxSizeVal = 5,
    flingEnabled  = false,
}

local function saveSettings()
    local lines = {
        "menuKey="       .. settings.menuKey,
        "ijEnabled="     .. tostring(settings.ijEnabled),
        "speedVal="      .. tostring(settings.speedVal),
        "spinEnabled="   .. tostring(settings.spinEnabled),
        "spinSpeedVal="  .. tostring(settings.spinSpeedVal),
        "noclipEnabled=" .. tostring(settings.noclipEnabled),
        "flyEnabled="    .. tostring(settings.flyEnabled),
        "flySpeedVal="   .. tostring(settings.flySpeedVal),
        "espEnabled="    .. tostring(settings.espEnabled),
        "hitboxEnabled=" .. tostring(settings.hitboxEnabled),
        "hitboxSizeVal=" .. tostring(settings.hitboxSizeVal),
        "flingEnabled="  .. tostring(settings.flingEnabled),
    }
    pcall(function() writefile(SETTINGS_FILE, table.concat(lines, "\n")) end)
end

pcall(function()
    if isfile(SETTINGS_FILE) then
        for key, val in readfile(SETTINGS_FILE):gmatch("([%w]+)=([^\n]+)") do
            if key == "menuKey" then
                settings.menuKey = val
            elseif key == "ijEnabled" then
                settings.ijEnabled = (val == "true")
            elseif key == "speedVal" then
                settings.speedVal = tonumber(val) or 16
            elseif key == "spinEnabled" then
                settings.spinEnabled = (val == "true")
            elseif key == "spinSpeedVal" then
                settings.spinSpeedVal = tonumber(val) or 20
            elseif key == "noclipEnabled" then
                settings.noclipEnabled = (val == "true")
            elseif key == "flyEnabled" then
                settings.flyEnabled = (val == "true")
            elseif key == "flySpeedVal" then
                settings.flySpeedVal = tonumber(val) or 50
            elseif key == "espEnabled" then
                settings.espEnabled = (val == "true")
            elseif key == "hitboxEnabled" then
                settings.hitboxEnabled = (val == "true")
            elseif key == "hitboxSizeVal" then
                settings.hitboxSizeVal = tonumber(val) or 5
            elseif key == "flingEnabled" then
                settings.flingEnabled = (val == "true")
            end
        end
    end
end)

local menuKey = Enum.KeyCode[settings.menuKey] or Enum.KeyCode.LeftControl

local function getKeyName(kc)
    local pretty = {
        LeftControl = "LControl", RightControl = "RControl",
        LeftShift   = "LShift",   RightShift   = "RShift",
        LeftAlt     = "LAlt",     RightAlt     = "RAlt",
    }
    return pretty[kc.Name] or kc.Name
end

-- ──────────────────────────────────────────────
-- Embedded Scripts
-- ──────────────────────────────────────────────
local SCRIPTS = {
    [1] = {
        display = "(Blox Fruits - Gravity Hub) VapeVoidware Loader",
        code = "-- Script taken from https://xenoscripts.com website --\n\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua\", true))()",
    },
    [2] = {
        display = "(Blox Fruits - Auto Farm + Raid) Blue X Hub",
        code = "_G.AutoTranslate = true\n_G.SaveConfig = true\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua\"))()",
    },
    [3] = {
        display = "(Blox Fruits - Auto V4 + Level + Raid) Xeno Gravity Hub",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/GRAVITY-Blox-Fruits-BEST-SCRIPT-SOLARA-AND-XENO-AUTO-V4-AUTO-LEVEL-AUTO-RAID-37566\"))()",
    },
    [4] = {
        display = "(Universal - Admin Panel) Admin Panel Keyless",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Universal-Script-Admin-Panel-Universal-KEYLESS-171955\"))()",
    },
    [5] = {
        display = "(Bite By Night - Auto Win + Farm + Aimbot) Bite By Night Hub",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Bite-By-Night-Auto-win-Money-Farm-Kill-All-Aimbot-and-70-features-202018\"))()",
    },
    [6] = {
        display = "(Universal - Multi Hub) Molyn Hub Keyless",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Universal-Script-MOLYN-DEVELOPMENT-201480\"))()",
    },
    [7] = {
        display = "(Universal - Multi Hub) Real Cryptic Free",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/OnlyCryptic/Cryptic/hm/main.lua\"))()",
    },
    [8] = {
        display = "(DOORS - Godmode + Speed Bypass) ZeScript",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/DOORS-ZeScript-67246\"))()",
    },
    [9] = {
        display = "(Blox Fruits - Gravity Hub V2) Gravity Hub",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua\"))()",
    },
    [10] = {
        display = "(Blox Fruits - Server Hop) Master Hop",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/HopScript.luau\"))()",
    },
    [11] = {
        display = "(Break In 2 - Hub Script) Break In 2 Hub",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/RScriptz/RobloxScripts/main/BreakIn2.lua\"))()",
    },
    [12] = {
        display = "(Forsaken - Hub Script) Forsaken Hub",
        code = "loadstring(game:HttpGet(\"https://pastebin.com/raw/zH9Extzk\"))()",
    },
    [13] = {
        display = "(Blox Fruits - Fruit Finder) Fruit Find",
        code = "getgenv().Team = \"Marines\"\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/FindFruit.lua\"))()",
    },
    [14] = {
        display = "(Blox Fruits - Bounty Hunt + Auto Hop) Bounty Hunt Hop",
        code = "getgenv().Config = {\n    Team = \"Pirates\",\n    HideUI = true,\n    HuntConfig = {\n        [\"Earned Notification Enabled\"] = false,\n        [\"Reset Farm (New)\"] = true,\n        [\"Chat\"] = false,\n        [\"Farm Delay\"] = 0.22,\n        [\"Webhook\"] = { Enabled = false, Url = \"\" }\n    }\n}\nloadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/2ffcdb62773f587bfb9eb0d52bb35b0c.lua\"))()",
    },
    [15] = {
        display = "(Ink - Needs Key) AX Scripts Ink",
        code = "script_key=\"KEY_HERE\";\nloadstring(game:HttpGet(\"https://officialaxscripts.vercel.app/scripts/AX-Loader.lua\"))()",
    },
    [16] = {
        display = "(Ink - Bypass) Ink Game Bypass",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/eikikrkr-ux/bypasok/refs/heads/main/ok\"))()",
    },
    [17] = {
        display = "(DOORS - NullFire Hub) NullFire Doors",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/TeamNullFire/NullFire/main/loader.lua\"))()",
    },
    [18] = {
        display = "(Universal - Multi Hub) Orange Hub",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/HieuDepTrai-Z/Dev_Orange/refs/heads/main/OrangeHub.lua\"))()",
    },
    [19] = {
        display = "(Blox Fruits - WhiteX Beta) WhiteX BF-Beta",
        code = "script_key = \"false\"\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua\"))()",
    },
    [20] = {
        display = "(Blox Fruits - Auto Bounty) SeraHub AutoBounty",
        code = "getgenv().config = {\n    [\"Team\"] = \"Pirates\",\n    [\"Use Race\"] = { [\"V3\"] = true, [\"V4\"] = true },\n    [\"Info Screen\"] = true,\n    [\"White Screen\"] = false,\n    [\"BypassTp\"] = true,\n    [\"SkipFruit\"] = { \"Portal-Portal\" },\n    [\"Skip Race V4 User\"] = true,\n    [\"MinBountyHunt\"] = 0,\n    [\"MaxBountyHunt\"] = 30000000,\n    [\"SafeHealth\"] = 4000\n}\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/LumosSera/SeraHub/main/AutoBounty.lua\"))()",
    },
}

-- ──────────────────────────────────────────────
-- ScreenGui Setup
-- ──────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoaderGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- ──────────────────────────────────────────────
-- Mobile Detection & UI Scaling
-- ──────────────────────────────────────────────
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local GuiScale = Instance.new("UIScale")
GuiScale.Scale = isMobile and 0.62 or 1.0
GuiScale.Parent = ScreenGui

-- Forward declarations so notification click can reference these
local openMenu, hideMenu, menuOpen

-- ──────────────────────────────────────────────
-- Notification
-- ──────────────────────────────────────────────
local Notification = Instance.new("Frame")
Notification.Name = "Notification"
Notification.Size = UDim2.new(0, 280, 0, 40)
Notification.Position = UDim2.new(0.5, -140, 0, -50)
Notification.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Notification.BorderSizePixel = 0
Notification.ZIndex = 20
Notification.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 8)
NotifCorner.Parent = Notification

local NotifStroke = Instance.new("UIStroke")
NotifStroke.Color = Color3.fromRGB(80, 80, 160)
NotifStroke.Thickness = 1.5
NotifStroke.Parent = Notification

local NotifLabel = Instance.new("TextButton")
NotifLabel.Size = UDim2.new(1, 0, 1, 0)
NotifLabel.BackgroundTransparency = 1
NotifLabel.Text = "🔑  Tap here or " .. getKeyName(menuKey) .. " to open"
NotifLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
NotifLabel.TextSize = 14
NotifLabel.Font = Enum.Font.GothamMedium
NotifLabel.ZIndex = 21
NotifLabel.AutoButtonColor = false
NotifLabel.Parent = Notification

NotifLabel.Activated:Connect(function()
    openMenu()
end)

local function showNotification()
    TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -140, 0, 16)
    }):Play()
    task.delay(2, function()
        TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -140, 0, -50)
        }):Play()
    end)
end

local function hideNotification()
    TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -140, 0, -50)
    }):Play()
end

showNotification()

-- ──────────────────────────────────────────────
-- Execute Notification (feedback toast)
-- ──────────────────────────────────────────────
local ExecToast = Instance.new("Frame")
ExecToast.Name = "ExecToast"
ExecToast.Size = UDim2.new(0, 280, 0, 40)
ExecToast.Position = UDim2.new(0.5, -140, 1, 10)
ExecToast.BackgroundColor3 = Color3.fromRGB(20, 40, 20)
ExecToast.BorderSizePixel = 0
ExecToast.ZIndex = 20
ExecToast.Parent = ScreenGui

local ExecToastCorner = Instance.new("UICorner")
ExecToastCorner.CornerRadius = UDim.new(0, 8)
ExecToastCorner.Parent = ExecToast

local ExecToastStroke = Instance.new("UIStroke")
ExecToastStroke.Color = Color3.fromRGB(60, 160, 80)
ExecToastStroke.Thickness = 1.5
ExecToastStroke.Parent = ExecToast

local ExecToastLabel = Instance.new("TextLabel")
ExecToastLabel.Size = UDim2.new(1, 0, 1, 0)
ExecToastLabel.BackgroundTransparency = 1
ExecToastLabel.Text = "✅  Executed!"
ExecToastLabel.TextColor3 = Color3.fromRGB(160, 255, 160)
ExecToastLabel.TextSize = 14
ExecToastLabel.Font = Enum.Font.GothamMedium
ExecToastLabel.ZIndex = 21
ExecToastLabel.Parent = ExecToast

local function showExecToast(name)
    ExecToastLabel.Text = "✅  Executed: " .. name
    TweenService:Create(ExecToast, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -140, 1, -56)
    }):Play()
    task.delay(2, function()
        TweenService:Create(ExecToast, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -140, 1, 10)
        }):Play()
    end)
end

-- ──────────────────────────────────────────────
-- Confirm Dialog
-- ──────────────────────────────────────────────
local ConfirmDialog = Instance.new("Frame")
ConfirmDialog.Name = "ConfirmDialog"
ConfirmDialog.Size = UDim2.new(0, 260, 0, 120)
ConfirmDialog.Position = UDim2.new(0.5, -130, 0.5, -60)
ConfirmDialog.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
ConfirmDialog.BorderSizePixel = 0
ConfirmDialog.ZIndex = 30
ConfirmDialog.Visible = false
ConfirmDialog.Parent = ScreenGui

local DialogCorner = Instance.new("UICorner")
DialogCorner.CornerRadius = UDim.new(0, 10)
DialogCorner.Parent = ConfirmDialog

local DialogStroke = Instance.new("UIStroke")
DialogStroke.Color = Color3.fromRGB(80, 80, 160)
DialogStroke.Thickness = 1.5
DialogStroke.Parent = ConfirmDialog

local DialogTitle = Instance.new("TextLabel")
DialogTitle.Size = UDim2.new(1, 0, 0, 40)
DialogTitle.Position = UDim2.new(0, 0, 0, 8)
DialogTitle.BackgroundTransparency = 1
DialogTitle.Text = "Close Menu?"
DialogTitle.TextColor3 = Color3.fromRGB(230, 230, 255)
DialogTitle.TextSize = 16
DialogTitle.Font = Enum.Font.GothamBold
DialogTitle.ZIndex = 31
DialogTitle.Parent = ConfirmDialog

local DialogSub = Instance.new("TextLabel")
DialogSub.Size = UDim2.new(1, -20, 0, 24)
DialogSub.Position = UDim2.new(0, 10, 0, 44)
DialogSub.BackgroundTransparency = 1
DialogSub.Text = "Are you sure you want to close?"
DialogSub.TextColor3 = Color3.fromRGB(160, 160, 200)
DialogSub.TextSize = 13
DialogSub.Font = Enum.Font.Gotham
DialogSub.ZIndex = 31
DialogSub.Parent = ConfirmDialog

local DialogYes = Instance.new("TextButton")
DialogYes.Size = UDim2.new(0, 100, 0, 30)
DialogYes.Position = UDim2.new(0, 20, 1, -42)
DialogYes.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
DialogYes.BorderSizePixel = 0
DialogYes.Text = "Yes, Close"
DialogYes.TextColor3 = Color3.fromRGB(255, 255, 255)
DialogYes.TextSize = 13
DialogYes.Font = Enum.Font.GothamBold
DialogYes.ZIndex = 32
DialogYes.Parent = ConfirmDialog

local DialogYesCorner = Instance.new("UICorner")
DialogYesCorner.CornerRadius = UDim.new(0, 6)
DialogYesCorner.Parent = DialogYes

local DialogNo = Instance.new("TextButton")
DialogNo.Size = UDim2.new(0, 100, 0, 30)
DialogNo.Position = UDim2.new(1, -120, 1, -42)
DialogNo.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
DialogNo.BorderSizePixel = 0
DialogNo.Text = "Cancel"
DialogNo.TextColor3 = Color3.fromRGB(200, 200, 255)
DialogNo.TextSize = 13
DialogNo.Font = Enum.Font.GothamBold
DialogNo.ZIndex = 32
DialogNo.Parent = ConfirmDialog

local DialogNoCorner = Instance.new("UICorner")
DialogNoCorner.CornerRadius = UDim.new(0, 6)
DialogNoCorner.Parent = DialogNo

-- ──────────────────────────────────────────────
-- Main Menu Window
-- ──────────────────────────────────────────────
local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 500, 0, 340)
MenuFrame.Position = UDim2.new(0.5, -250, 0.5, -170)
MenuFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.ZIndex = 10
MenuFrame.Parent = ScreenGui

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 12)
MenuCorner.Parent = MenuFrame

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(70, 70, 150)
MenuStroke.Thickness = 1.5
MenuStroke.Parent = MenuFrame

-- ── Title Bar ──
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 36)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 11
TitleBar.Parent = MenuFrame

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 12)
TitleBarCorner.Parent = TitleBar

local TitleBarFill = Instance.new("Frame")
TitleBarFill.Size = UDim2.new(1, 0, 0, 12)
TitleBarFill.Position = UDim2.new(0, 0, 1, -12)
TitleBarFill.BackgroundColor3 = Color3.fromRGB(20, 20, 36)
TitleBarFill.BorderSizePixel = 0
TitleBarFill.ZIndex = 11
TitleBarFill.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡  Loader Menu"
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 12
TitleLabel.Parent = TitleBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 22)
MinimizeBtn.Position = UDim2.new(1, -62, 0.5, -11)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
MinimizeBtn.TextSize = 16
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.ZIndex = 13
MinimizeBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 22)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -11)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 13
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

-- ── Sidebar ──
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 110, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Sidebar.Parent = MenuFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.Parent = Sidebar

local SidebarPad = Instance.new("UIPadding")
SidebarPad.PaddingTop = UDim.new(0, 8)
SidebarPad.PaddingLeft = UDim.new(0, 6)
SidebarPad.PaddingRight = UDim.new(0, 6)
SidebarPad.Parent = Sidebar

-- ── Content Area ──
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -110, 1, -36)
ContentArea.Position = UDim2.new(0, 110, 0, 36)
ContentArea.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
ContentArea.BorderSizePixel = 0
ContentArea.ZIndex = 11
ContentArea.Parent = MenuFrame

-- ──────────────────────────────────────────────
-- Tab System
-- ──────────────────────────────────────────────
local tabs = {}

local function createTabButton(name, icon, order)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Tab"
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.BorderSizePixel = 0
    btn.Text = icon .. "  " .. name
    btn.TextColor3 = Color3.fromRGB(160, 160, 200)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = order
    btn.ZIndex = 12
    btn.Parent = Sidebar

    local btnPad = Instance.new("UIPadding")
    btnPad.PaddingLeft = UDim.new(0, 8)
    btnPad.Parent = btn

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    return btn
end

local function createTabPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 160)
    page.Visible = false
    page.ZIndex = 12
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Parent = ContentArea

    local pagePad = Instance.new("UIPadding")
    pagePad.PaddingTop = UDim.new(0, 8)
    pagePad.PaddingLeft = UDim.new(0, 8)
    pagePad.PaddingRight = UDim.new(0, 8)
    pagePad.PaddingBottom = UDim.new(0, 8)
    pagePad.Parent = page

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 6)
    pageLayout.Parent = page

    return page
end

local function setActiveTab(name)
    for tabName, tabData in pairs(tabs) do
        local isActive = (tabName == name)
        tabData.button.BackgroundColor3 = isActive
            and Color3.fromRGB(60, 60, 120)
            or Color3.fromRGB(30, 30, 50)
        tabData.button.TextColor3 = isActive
            and Color3.fromRGB(230, 230, 255)
            or Color3.fromRGB(160, 160, 200)
        tabData.page.Visible = isActive
    end
end

local tabDefs = {
    { name = "Home",     icon = "🏠", order = 1 },
    { name = "Script",   icon = "📜", order = 2 },
    { name = "Executor", icon = "⚙️", order = 3 },
    { name = "Features", icon = "⭐", order = 4 },
}

for _, def in ipairs(tabDefs) do
    local btn  = createTabButton(def.name, def.icon, def.order)
    local page = createTabPage(def.name)
    tabs[def.name] = { button = btn, page = page }
    btn.MouseButton1Click:Connect(function()
        setActiveTab(def.name)
    end)
end

-- ──────────────────────────────────────────────
-- Home Page
-- ──────────────────────────────────────────────
local homePage = tabs["Home"].page

local homeWelcome = Instance.new("TextLabel")
homeWelcome.Size = UDim2.new(1, 0, 0, 50)
homeWelcome.BackgroundColor3 = Color3.fromRGB(20, 20, 36)
homeWelcome.BorderSizePixel = 0
homeWelcome.Text = "Welcome to Loader Menu"
homeWelcome.TextColor3 = Color3.fromRGB(200, 200, 255)
homeWelcome.TextSize = 16
homeWelcome.Font = Enum.Font.GothamBold
homeWelcome.ZIndex = 13
homeWelcome.LayoutOrder = 1
homeWelcome.Parent = homePage
Instance.new("UICorner", homeWelcome).CornerRadius = UDim.new(0, 8)

local homeCredit = Instance.new("TextLabel")
homeCredit.Size = UDim2.new(1, 0, 0, 28)
homeCredit.BackgroundTransparency = 1
homeCredit.Text = "Created by Naitik  ·  Developer: Naitik"
homeCredit.TextColor3 = Color3.fromRGB(120, 120, 180)
homeCredit.TextSize = 12
homeCredit.Font = Enum.Font.GothamMedium
homeCredit.ZIndex = 13
homeCredit.LayoutOrder = 1
homeCredit.Parent = homePage

local homeDesc = Instance.new("TextLabel")
homeDesc.Size = UDim2.new(1, 0, 0, 60)
homeDesc.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
homeDesc.BorderSizePixel = 0
homeDesc.Text = "Use the sidebar to navigate between tabs.\nPress " .. getKeyName(menuKey) .. " to hide / show this menu."
homeDesc.TextColor3 = Color3.fromRGB(160, 160, 200)
homeDesc.TextSize = 13
homeDesc.Font = Enum.Font.Gotham
homeDesc.TextWrapped = true
homeDesc.ZIndex = 13
homeDesc.LayoutOrder = 2
homeDesc.Parent = homePage
Instance.new("UICorner", homeDesc).CornerRadius = UDim.new(0, 8)

local homeCount = Instance.new("TextLabel")
homeCount.Size = UDim2.new(1, 0, 0, 36)
homeCount.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
homeCount.BorderSizePixel = 0
homeCount.Text = "📦  " .. #SCRIPTS .. " scripts loaded"
homeCount.TextColor3 = Color3.fromRGB(180, 180, 255)
homeCount.TextSize = 13
homeCount.Font = Enum.Font.GothamMedium
homeCount.ZIndex = 13
homeCount.LayoutOrder = 3
homeCount.Parent = homePage
Instance.new("UICorner", homeCount).CornerRadius = UDim.new(0, 8)

-- Rejoin Server button
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(1, 0, 0, 40)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 180)
rejoinBtn.BorderSizePixel = 0
rejoinBtn.Text = "🔄  Rejoin Server"
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.TextSize = 14
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.ZIndex = 13
rejoinBtn.LayoutOrder = 4
rejoinBtn.Parent = homePage
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 8)

local rejoinStroke = Instance.new("UIStroke")
rejoinStroke.Color = Color3.fromRGB(60, 110, 220)
rejoinStroke.Thickness = 1.5
rejoinStroke.Parent = rejoinBtn

rejoinBtn.MouseEnter:Connect(function()
    TweenService:Create(rejoinBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(60, 110, 230)
    }):Play()
end)
rejoinBtn.MouseLeave:Connect(function()
    TweenService:Create(rejoinBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(40, 80, 180)
    }):Play()
end)

rejoinBtn.MouseButton1Click:Connect(function()
    rejoinBtn.Text = "🔄  Rejoining..."
    rejoinBtn.BackgroundColor3 = Color3.fromRGB(30, 60, 140)
    task.spawn(function()
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        local ok, err = pcall(function()
            TeleportService:Teleport(placeId, Players.LocalPlayer)
        end)
        if not ok then
            task.wait(1)
            rejoinBtn.Text = "🔄  Rejoin Server"
            rejoinBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 180)
            warn("[Loader] Rejoin failed: " .. tostring(err))
        end
    end)
end)

-- ──────────────────────────────────────────────
-- Script Page — one card per script
-- ──────────────────────────────────────────────
local scriptPage = tabs["Script"].page

local scriptHeader = Instance.new("TextLabel")
scriptHeader.Size = UDim2.new(1, 0, 0, 34)
scriptHeader.BackgroundColor3 = Color3.fromRGB(20, 20, 36)
scriptHeader.BorderSizePixel = 0
scriptHeader.Text = "📜  Scripts  —  click Execute to run"
scriptHeader.TextColor3 = Color3.fromRGB(200, 200, 255)
scriptHeader.TextSize = 13
scriptHeader.Font = Enum.Font.GothamBold
scriptHeader.ZIndex = 13
scriptHeader.LayoutOrder = 0
scriptHeader.Parent = scriptPage
Instance.new("UICorner", scriptHeader).CornerRadius = UDim.new(0, 8)

-- Search bar
local searchFrame = Instance.new("Frame")
searchFrame.Size = UDim2.new(1, 0, 0, 32)
searchFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 40)
searchFrame.BorderSizePixel = 0
searchFrame.ZIndex = 13
searchFrame.LayoutOrder = 1
searchFrame.Parent = scriptPage
Instance.new("UICorner", searchFrame).CornerRadius = UDim.new(0, 7)

local searchStroke = Instance.new("UIStroke")
searchStroke.Color = Color3.fromRGB(60, 60, 110)
searchStroke.Thickness = 1.2
searchStroke.Parent = searchFrame

local searchIcon = Instance.new("TextLabel")
searchIcon.Size = UDim2.new(0, 28, 1, 0)
searchIcon.BackgroundTransparency = 1
searchIcon.Text = "🔍"
searchIcon.TextSize = 14
searchIcon.Font = Enum.Font.Gotham
searchIcon.ZIndex = 14
searchIcon.Parent = searchFrame

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -36, 1, 0)
searchBox.Position = UDim2.new(0, 28, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.PlaceholderText = "Search scripts..."
searchBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 130)
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(210, 210, 255)
searchBox.TextSize = 13
searchBox.Font = Enum.Font.GothamMedium
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.ZIndex = 14
searchBox.Parent = searchFrame

-- Focus highlight
searchBox.Focused:Connect(function()
    TweenService:Create(searchStroke, TweenInfo.new(0.15), {
        Color = Color3.fromRGB(100, 100, 200)
    }):Play()
end)
searchBox.FocusLost:Connect(function()
    TweenService:Create(searchStroke, TweenInfo.new(0.15), {
        Color = Color3.fromRGB(60, 60, 110)
    }):Play()
end)

local scriptCards = {}

local function filterScripts(query)
    local q = query:lower():gsub("^%s+", ""):gsub("%s+$", "")
    for _, cardData in ipairs(scriptCards) do
        local matches = (q == "") or (cardData.name:lower():find(q, 1, true) ~= nil)
        cardData.card.Visible = matches
    end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    filterScripts(searchBox.Text)
end)

for i, scriptData in ipairs(SCRIPTS) do
    -- Card frame
    local card = Instance.new("Frame")
    card.Name = "ScriptCard_" .. i
    card.Size = UDim2.new(1, 0, 0, 38)
    card.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
    card.BorderSizePixel = 0
    card.ZIndex = 13
    card.LayoutOrder = i
    card.Parent = scriptPage
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 7)
    table.insert(scriptCards, { name = scriptData.display, card = card })

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Color3.fromRGB(50, 50, 90)
    cardStroke.Thickness = 1
    cardStroke.Parent = card

    -- Script name label
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -100, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = scriptData.display
    nameLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamMedium
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    nameLabel.ZIndex = 14
    nameLabel.Parent = card

    -- Execute button
    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0, 82, 0, 26)
    execBtn.Position = UDim2.new(1, -90, 0.5, -13)
    execBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    execBtn.BorderSizePixel = 0
    execBtn.Text = "▶  Execute"
    execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    execBtn.TextSize = 12
    execBtn.Font = Enum.Font.GothamBold
    execBtn.ZIndex = 14
    execBtn.Parent = card
    Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0, 6)

    -- Capture variables for closure
    local capturedCode    = scriptData.code
    local capturedDisplay = scriptData.display
    local capturedBtn     = execBtn
    local capturedStroke  = cardStroke

    execBtn.MouseButton1Click:Connect(function()
        -- Visual feedback
        capturedBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 60)
        capturedBtn.Text = "Running..."
        capturedStroke.Color = Color3.fromRGB(60, 160, 80)

        task.spawn(function()
            local ok, err = pcall(loadstring, capturedCode)
            if ok then
                if type(loadstring(capturedCode)) == "function" then
                    pcall(loadstring(capturedCode))
                end
            end
        end)

        showExecToast(capturedDisplay)

        task.delay(1.5, function()
            capturedBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
            capturedBtn.Text = "▶  Execute"
            capturedStroke.Color = Color3.fromRGB(50, 50, 90)
        end)
    end)
end

-- ──────────────────────────────────────────────
-- Executor Page
-- ──────────────────────────────────────────────
local execPage = tabs["Executor"].page

-- Header
local execHeader = Instance.new("TextLabel")
execHeader.Size = UDim2.new(1, 0, 0, 34)
execHeader.BackgroundColor3 = Color3.fromRGB(20, 20, 36)
execHeader.BorderSizePixel = 0
execHeader.Text = "⚙️  Executor  —  write & run Lua"
execHeader.TextColor3 = Color3.fromRGB(200, 200, 255)
execHeader.TextSize = 13
execHeader.Font = Enum.Font.GothamBold
execHeader.ZIndex = 13
execHeader.LayoutOrder = 1
execHeader.Parent = execPage
Instance.new("UICorner", execHeader).CornerRadius = UDim.new(0, 8)

-- Code editor frame
local editorFrame = Instance.new("Frame")
editorFrame.Size = UDim2.new(1, 0, 0, 170)
editorFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
editorFrame.BorderSizePixel = 0
editorFrame.ZIndex = 13
editorFrame.LayoutOrder = 2
editorFrame.Parent = execPage
Instance.new("UICorner", editorFrame).CornerRadius = UDim.new(0, 8)

local editorStroke = Instance.new("UIStroke")
editorStroke.Color = Color3.fromRGB(55, 55, 100)
editorStroke.Thickness = 1.2
editorStroke.Parent = editorFrame

-- Line numbers column
local lineNumFrame = Instance.new("Frame")
lineNumFrame.Size = UDim2.new(0, 26, 1, -8)
lineNumFrame.Position = UDim2.new(0, 4, 0, 4)
lineNumFrame.BackgroundTransparency = 1
lineNumFrame.ZIndex = 14
lineNumFrame.Parent = editorFrame

local lineNumLabel = Instance.new("TextLabel")
lineNumLabel.Size = UDim2.new(1, 0, 1, 0)
lineNumLabel.BackgroundTransparency = 1
lineNumLabel.Text = "1\n2\n3\n4\n5\n6\n7\n8"
lineNumLabel.TextColor3 = Color3.fromRGB(70, 70, 110)
lineNumLabel.TextSize = 12
lineNumLabel.Font = Enum.Font.Code
lineNumLabel.TextXAlignment = Enum.TextXAlignment.Right
lineNumLabel.TextYAlignment = Enum.TextYAlignment.Top
lineNumLabel.ZIndex = 14
lineNumLabel.Parent = lineNumFrame

-- Code TextBox
local codeBox = Instance.new("TextBox")
codeBox.Size = UDim2.new(1, -36, 1, -8)
codeBox.Position = UDim2.new(0, 32, 0, 4)
codeBox.BackgroundTransparency = 1
codeBox.Text = 'print("Hello World")'
codeBox.PlaceholderText = "-- Write your Lua code here..."
codeBox.PlaceholderColor3 = Color3.fromRGB(70, 70, 110)
codeBox.TextColor3 = Color3.fromRGB(180, 220, 255)
codeBox.TextSize = 12
codeBox.Font = Enum.Font.Code
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.MultiLine = true
codeBox.ClearTextOnFocus = false
codeBox.ZIndex = 14
codeBox.Parent = editorFrame

-- Update line numbers when code changes
codeBox:GetPropertyChangedSignal("Text"):Connect(function()
    local lines = 1
    for _ in codeBox.Text:gmatch("\n") do lines = lines + 1 end
    local nums = {}
    for i = 1, math.max(lines, 8) do nums[i] = tostring(i) end
    lineNumLabel.Text = table.concat(nums, "\n")
end)

-- Focus glow
codeBox.Focused:Connect(function()
    TweenService:Create(editorStroke, TweenInfo.new(0.15), {
        Color = Color3.fromRGB(90, 90, 180)
    }):Play()
end)
codeBox.FocusLost:Connect(function()
    TweenService:Create(editorStroke, TweenInfo.new(0.15), {
        Color = Color3.fromRGB(55, 55, 100)
    }):Play()
end)

-- Button row
local btnRow = Instance.new("Frame")
btnRow.Size = UDim2.new(1, 0, 0, 34)
btnRow.BackgroundTransparency = 1
btnRow.ZIndex = 13
btnRow.LayoutOrder = 3
btnRow.Parent = execPage

local btnRowLayout = Instance.new("UIListLayout")
btnRowLayout.FillDirection = Enum.FillDirection.Horizontal
btnRowLayout.SortOrder = Enum.SortOrder.LayoutOrder
btnRowLayout.Padding = UDim.new(0, 6)
btnRowLayout.Parent = btnRow

-- Run button
local runBtn = Instance.new("TextButton")
runBtn.Size = UDim2.new(0, 110, 0, 34)
runBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
runBtn.BorderSizePixel = 0
runBtn.Text = "▶  Run"
runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
runBtn.TextSize = 13
runBtn.Font = Enum.Font.GothamBold
runBtn.ZIndex = 14
runBtn.LayoutOrder = 1
runBtn.Parent = btnRow
Instance.new("UICorner", runBtn).CornerRadius = UDim.new(0, 7)

-- Clear button
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 80, 0, 34)
clearBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
clearBtn.BorderSizePixel = 0
clearBtn.Text = "🗑  Clear"
clearBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
clearBtn.TextSize = 13
clearBtn.Font = Enum.Font.GothamBold
clearBtn.ZIndex = 14
clearBtn.LayoutOrder = 2
clearBtn.Parent = btnRow
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 7)

-- Output box
local outputFrame = Instance.new("Frame")
outputFrame.Size = UDim2.new(1, 0, 0, 80)
outputFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
outputFrame.BorderSizePixel = 0
outputFrame.ZIndex = 13
outputFrame.LayoutOrder = 4
outputFrame.Parent = execPage
Instance.new("UICorner", outputFrame).CornerRadius = UDim.new(0, 8)

local outputStroke = Instance.new("UIStroke")
outputStroke.Color = Color3.fromRGB(50, 50, 90)
outputStroke.Thickness = 1
outputStroke.Parent = outputFrame

local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(1, -10, 1, -8)
outputLabel.Position = UDim2.new(0, 6, 0, 4)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "-- Output will appear here"
outputLabel.TextColor3 = Color3.fromRGB(90, 90, 130)
outputLabel.TextSize = 12
outputLabel.Font = Enum.Font.Code
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.TextYAlignment = Enum.TextYAlignment.Top
outputLabel.TextWrapped = true
outputLabel.ZIndex = 14
outputLabel.Parent = outputFrame

-- Run logic
local function runCode()
    local code = codeBox.Text
    if code:gsub("%s", "") == "" then return end

    runBtn.Text = "Running..."
    runBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 50)
    outputLabel.TextColor3 = Color3.fromRGB(90, 90, 130)
    outputLabel.Text = "-- Running..."

    task.spawn(function()
        local fn, compileErr = loadstring(code)
        if not fn then
            outputLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            outputLabel.Text = "❌  " .. tostring(compileErr)
        else
            local ok, runtimeErr = pcall(fn)
            if ok then
                outputLabel.TextColor3 = Color3.fromRGB(100, 220, 130)
                outputLabel.Text = "✅  Executed successfully"
            else
                outputLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                outputLabel.Text = "❌  " .. tostring(runtimeErr)
            end
        end

        runBtn.Text = "▶  Run"
        runBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
    end)
end

runBtn.Activated:Connect(runCode)

clearBtn.Activated:Connect(function()
    codeBox.Text = ""
    outputLabel.TextColor3 = Color3.fromRGB(90, 90, 130)
    outputLabel.Text = "-- Output will appear here"
end)

-- ──────────────────────────────────────────────
-- Features Page
-- ──────────────────────────────────────────────
local featPage = tabs["Features"].page

-- Header
local featHeader = Instance.new("TextLabel")
featHeader.Size = UDim2.new(1, 0, 0, 34)
featHeader.BackgroundColor3 = Color3.fromRGB(20, 20, 36)
featHeader.BorderSizePixel = 0
featHeader.Text = "⭐  Features"
featHeader.TextColor3 = Color3.fromRGB(200, 200, 255)
featHeader.TextSize = 13
featHeader.Font = Enum.Font.GothamBold
featHeader.ZIndex = 13
featHeader.LayoutOrder = 1
featHeader.Parent = featPage
Instance.new("UICorner", featHeader).CornerRadius = UDim.new(0, 8)

-- ── Infinite Jump card ──────────────────────────────
local ijCard = Instance.new("Frame")
ijCard.Size = UDim2.new(1, 0, 0, 60)
ijCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
ijCard.BorderSizePixel = 0
ijCard.ZIndex = 13
ijCard.LayoutOrder = 2
ijCard.Parent = featPage
Instance.new("UICorner", ijCard).CornerRadius = UDim.new(0, 8)

local ijStroke = Instance.new("UIStroke")
ijStroke.Color = Color3.fromRGB(55, 55, 100)
ijStroke.Thickness = 1.2
ijStroke.Parent = ijCard

-- Label
local ijLabel = Instance.new("TextLabel")
ijLabel.Size = UDim2.new(1, -80, 1, 0)
ijLabel.Position = UDim2.new(0, 12, 0, 0)
ijLabel.BackgroundTransparency = 1
ijLabel.Text = "🦘  Infinite Jump"
ijLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
ijLabel.TextSize = 14
ijLabel.Font = Enum.Font.GothamBold
ijLabel.TextXAlignment = Enum.TextXAlignment.Left
ijLabel.ZIndex = 14
ijLabel.Parent = ijCard

-- Sub-label
local ijSub = Instance.new("TextLabel")
ijSub.Size = UDim2.new(1, -80, 0, 16)
ijSub.Position = UDim2.new(0, 12, 0, 30)
ijSub.BackgroundTransparency = 1
ijSub.Text = "Jump again mid-air infinitely"
ijSub.TextColor3 = Color3.fromRGB(110, 110, 150)
ijSub.TextSize = 11
ijSub.Font = Enum.Font.Gotham
ijSub.TextXAlignment = Enum.TextXAlignment.Left
ijSub.ZIndex = 14
ijSub.Parent = ijCard

-- Toggle button
local ijToggle = Instance.new("TextButton")
ijToggle.Size = UDim2.new(0, 58, 0, 28)
ijToggle.Position = UDim2.new(1, -70, 0.5, -14)
ijToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
ijToggle.BorderSizePixel = 0
ijToggle.Text = "OFF"
ijToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
ijToggle.TextSize = 12
ijToggle.Font = Enum.Font.GothamBold
ijToggle.ZIndex = 15
ijToggle.Parent = ijCard
Instance.new("UICorner", ijToggle).CornerRadius = UDim.new(0, 6)

-- State & connection
local ijEnabled = false
local ijConnection = nil

local function setIJToggle(state)
    ijEnabled = state
    settings.ijEnabled = state
    saveSettings()
    if state then
        ijToggle.Text = "ON"
        ijToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        ijToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ijStroke.Color = Color3.fromRGB(40, 160, 70)
        -- Connect infinite jump
        ijConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            local char = game:GetService("Players").LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        ijToggle.Text = "OFF"
        ijToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        ijToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
        ijStroke.Color = Color3.fromRGB(55, 55, 100)
        -- Disconnect
        if ijConnection then
            ijConnection:Disconnect()
            ijConnection = nil
        end
    end
end

ijToggle.Activated:Connect(function()
    setIJToggle(not ijEnabled)
end)

-- Restore saved inf jump state
if settings.ijEnabled then
    setIJToggle(true)
end

-- ── Menu Key card ──────────────────────────────
local mkCard = Instance.new("Frame")
mkCard.Size = UDim2.new(1, 0, 0, 60)
mkCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
mkCard.BorderSizePixel = 0
mkCard.ZIndex = 13
mkCard.LayoutOrder = 3
mkCard.Parent = featPage
Instance.new("UICorner", mkCard).CornerRadius = UDim.new(0, 8)

local mkStroke = Instance.new("UIStroke")
mkStroke.Color = Color3.fromRGB(55, 55, 100)
mkStroke.Thickness = 1.2
mkStroke.Parent = mkCard

local mkLabel = Instance.new("TextLabel")
mkLabel.Size = UDim2.new(1, -90, 1, 0)
mkLabel.Position = UDim2.new(0, 12, 0, 0)
mkLabel.BackgroundTransparency = 1
mkLabel.Text = "⌨️  Menu Key"
mkLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
mkLabel.TextSize = 14
mkLabel.Font = Enum.Font.GothamBold
mkLabel.TextXAlignment = Enum.TextXAlignment.Left
mkLabel.ZIndex = 14
mkLabel.Parent = mkCard

local mkSub = Instance.new("TextLabel")
mkSub.Size = UDim2.new(1, -90, 0, 16)
mkSub.Position = UDim2.new(0, 12, 0, 32)
mkSub.BackgroundTransparency = 1
mkSub.Text = "Current: " .. getKeyName(menuKey)
mkSub.TextColor3 = Color3.fromRGB(110, 110, 150)
mkSub.TextSize = 11
mkSub.Font = Enum.Font.Gotham
mkSub.TextXAlignment = Enum.TextXAlignment.Left
mkSub.ZIndex = 14
mkSub.Parent = mkCard

local mkBtn = Instance.new("TextButton")
mkBtn.Size = UDim2.new(0, 72, 0, 28)
mkBtn.Position = UDim2.new(1, -82, 0.5, -14)
mkBtn.BackgroundColor3 = Color3.fromRGB(50, 80, 160)
mkBtn.BorderSizePixel = 0
mkBtn.Text = "Set Key"
mkBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
mkBtn.TextSize = 12
mkBtn.Font = Enum.Font.GothamBold
mkBtn.ZIndex = 15
mkBtn.Parent = mkCard
Instance.new("UICorner", mkBtn).CornerRadius = UDim.new(0, 6)

local listeningForKey = false
local mkKeyConn = nil

mkBtn.Activated:Connect(function()
    if listeningForKey then return end
    listeningForKey = true
    mkBtn.Text = "Press..."
    mkBtn.BackgroundColor3 = Color3.fromRGB(160, 120, 20)
    mkSub.Text = "Press any key..."

    mkKeyConn = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

        menuKey = input.KeyCode
        settings.menuKey = input.KeyCode.Name
        saveSettings()

        local name = getKeyName(menuKey)
        mkSub.Text = "Current: " .. name
        mkBtn.Text = "Set Key"
        mkBtn.BackgroundColor3 = Color3.fromRGB(50, 80, 160)
        NotifLabel.Text = "🔑  Tap here or " .. name .. " to open"
        homeDesc.Text = "Use the sidebar to navigate between tabs.\nPress " .. name .. " to hide / show this menu."

        listeningForKey = false
        if mkKeyConn then
            mkKeyConn:Disconnect()
            mkKeyConn = nil
        end
    end)
end)

-- ── Rejoin card ──────────────────────────────
local rjCard = Instance.new("Frame")
rjCard.Size = UDim2.new(1, 0, 0, 60)
rjCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
rjCard.BorderSizePixel = 0
rjCard.ZIndex = 13
rjCard.LayoutOrder = 4
rjCard.Parent = featPage
Instance.new("UICorner", rjCard).CornerRadius = UDim.new(0, 8)

local rjStroke = Instance.new("UIStroke")
rjStroke.Color = Color3.fromRGB(55, 55, 100)
rjStroke.Thickness = 1.2
rjStroke.Parent = rjCard

local rjLabel = Instance.new("TextLabel")
rjLabel.Size = UDim2.new(1, -160, 1, 0)
rjLabel.Position = UDim2.new(0, 12, 0, 0)
rjLabel.BackgroundTransparency = 1
rjLabel.Text = "🔄  Rejoin"
rjLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
rjLabel.TextSize = 14
rjLabel.Font = Enum.Font.GothamBold
rjLabel.TextXAlignment = Enum.TextXAlignment.Left
rjLabel.ZIndex = 14
rjLabel.Parent = rjCard

local rjSub = Instance.new("TextLabel")
rjSub.Size = UDim2.new(1, -160, 0, 16)
rjSub.Position = UDim2.new(0, 12, 0, 32)
rjSub.BackgroundTransparency = 1
rjSub.Text = "Same server  ·  or hop to new server"
rjSub.TextColor3 = Color3.fromRGB(110, 110, 150)
rjSub.TextSize = 11
rjSub.Font = Enum.Font.Gotham
rjSub.TextXAlignment = Enum.TextXAlignment.Left
rjSub.ZIndex = 14
rjSub.Parent = rjCard

local rjSameBtn = Instance.new("TextButton")
rjSameBtn.Size = UDim2.new(0, 62, 0, 28)
rjSameBtn.Position = UDim2.new(1, -148, 0.5, -14)
rjSameBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 180)
rjSameBtn.BorderSizePixel = 0
rjSameBtn.Text = "Rejoin"
rjSameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rjSameBtn.TextSize = 12
rjSameBtn.Font = Enum.Font.GothamBold
rjSameBtn.ZIndex = 15
rjSameBtn.Parent = rjCard
Instance.new("UICorner", rjSameBtn).CornerRadius = UDim.new(0, 6)

local rjNewBtn = Instance.new("TextButton")
rjNewBtn.Size = UDim2.new(0, 76, 0, 28)
rjNewBtn.Position = UDim2.new(1, -78, 0.5, -14)
rjNewBtn.BackgroundColor3 = Color3.fromRGB(55, 40, 110)
rjNewBtn.BorderSizePixel = 0
rjNewBtn.Text = "New Server"
rjNewBtn.TextColor3 = Color3.fromRGB(200, 180, 255)
rjNewBtn.TextSize = 11
rjNewBtn.Font = Enum.Font.GothamBold
rjNewBtn.ZIndex = 15
rjNewBtn.Parent = rjCard
Instance.new("UICorner", rjNewBtn).CornerRadius = UDim.new(0, 6)

rjSameBtn.Activated:Connect(function()
    rjSameBtn.Text = "..."
    pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId, game.JobId, Players.LocalPlayer
        )
    end)
    task.delay(3, function() rjSameBtn.Text = "Rejoin" end)
end)

rjNewBtn.Activated:Connect(function()
    rjNewBtn.Text = "..."
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
    end)
    task.delay(3, function() rjNewBtn.Text = "New Server" end)
end)

-- ── Speed card ──────────────────────────────
local speedCard = Instance.new("Frame")
speedCard.Size = UDim2.new(1, 0, 0, 70)
speedCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
speedCard.BorderSizePixel = 0
speedCard.ZIndex = 13
speedCard.LayoutOrder = 5
speedCard.Parent = featPage
Instance.new("UICorner", speedCard).CornerRadius = UDim.new(0, 8)

local speedCardStroke = Instance.new("UIStroke")
speedCardStroke.Color = Color3.fromRGB(55, 55, 100)
speedCardStroke.Thickness = 1.2
speedCardStroke.Parent = speedCard

local speedCardLabel = Instance.new("TextLabel")
speedCardLabel.Size = UDim2.new(0, 160, 0, 20)
speedCardLabel.Position = UDim2.new(0, 12, 0, 8)
speedCardLabel.BackgroundTransparency = 1
speedCardLabel.Text = "⚡  Speed"
speedCardLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
speedCardLabel.TextSize = 14
speedCardLabel.Font = Enum.Font.GothamBold
speedCardLabel.TextXAlignment = Enum.TextXAlignment.Left
speedCardLabel.ZIndex = 14
speedCardLabel.Parent = speedCard

local speedCardSub = Instance.new("TextLabel")
speedCardSub.Size = UDim2.new(0, 160, 0, 16)
speedCardSub.Position = UDim2.new(0, 12, 0, 32)
speedCardSub.BackgroundTransparency = 1
speedCardSub.Text = "Set walk speed (default 16)"
speedCardSub.TextColor3 = Color3.fromRGB(110, 110, 150)
speedCardSub.TextSize = 11
speedCardSub.Font = Enum.Font.Gotham
speedCardSub.TextXAlignment = Enum.TextXAlignment.Left
speedCardSub.ZIndex = 14
speedCardSub.Parent = speedCard

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0, 110, 0, 28)
speedInput.Position = UDim2.new(1, -122, 0.5, -14)
speedInput.BackgroundColor3 = Color3.fromRGB(28, 28, 46)
speedInput.BorderSizePixel = 0
speedInput.Text = "16"
speedInput.PlaceholderText = "Speed..."
speedInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 120)
speedInput.TextColor3 = Color3.fromRGB(200, 200, 255)
speedInput.TextSize = 13
speedInput.Font = Enum.Font.GothamMedium
speedInput.ZIndex = 15
speedInput.Parent = speedCard
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 6)

local speedInputStroke = Instance.new("UIStroke")
speedInputStroke.Color = Color3.fromRGB(60, 60, 110)
speedInputStroke.Thickness = 1
speedInputStroke.Parent = speedInput

local currentWalkSpeed = 16

local function applyWalkSpeed()
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = currentWalkSpeed
    end
end

speedInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(speedInput.Text)
        if num then
            currentWalkSpeed = math.clamp(num, 0, 500)
            speedInput.Text = tostring(currentWalkSpeed)
            settings.speedVal = currentWalkSpeed
            saveSettings()
            applyWalkSpeed()
        else
            speedInput.Text = tostring(currentWalkSpeed)
        end
    end
end)

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    task.wait(0.2)
    hum.WalkSpeed = currentWalkSpeed
end)

-- ── Spin card ──────────────────────────────
local spinCard = Instance.new("Frame")
spinCard.Size = UDim2.new(1, 0, 0, 70)
spinCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
spinCard.BorderSizePixel = 0
spinCard.ZIndex = 13
spinCard.LayoutOrder = 6
spinCard.Parent = featPage
Instance.new("UICorner", spinCard).CornerRadius = UDim.new(0, 8)

local spinCardStroke = Instance.new("UIStroke")
spinCardStroke.Color = Color3.fromRGB(55, 55, 100)
spinCardStroke.Thickness = 1.2
spinCardStroke.Parent = spinCard

local spinCardLabel = Instance.new("TextLabel")
spinCardLabel.Size = UDim2.new(0, 160, 0, 20)
spinCardLabel.Position = UDim2.new(0, 12, 0, 8)
spinCardLabel.BackgroundTransparency = 1
spinCardLabel.Text = "🌀  Spin"
spinCardLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
spinCardLabel.TextSize = 14
spinCardLabel.Font = Enum.Font.GothamBold
spinCardLabel.TextXAlignment = Enum.TextXAlignment.Left
spinCardLabel.ZIndex = 14
spinCardLabel.Parent = spinCard

local spinCardSub = Instance.new("TextLabel")
spinCardSub.Size = UDim2.new(0, 160, 0, 16)
spinCardSub.Position = UDim2.new(0, 12, 0, 32)
spinCardSub.BackgroundTransparency = 1
spinCardSub.Text = "Rotate your character"
spinCardSub.TextColor3 = Color3.fromRGB(110, 110, 150)
spinCardSub.TextSize = 11
spinCardSub.Font = Enum.Font.Gotham
spinCardSub.TextXAlignment = Enum.TextXAlignment.Left
spinCardSub.ZIndex = 14
spinCardSub.Parent = spinCard

local spinInput = Instance.new("TextBox")
spinInput.Size = UDim2.new(0, 60, 0, 28)
spinInput.Position = UDim2.new(1, -140, 0.5, -14)
spinInput.BackgroundColor3 = Color3.fromRGB(28, 28, 46)
spinInput.BorderSizePixel = 0
spinInput.Text = "20"
spinInput.PlaceholderText = "Speed"
spinInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 120)
spinInput.TextColor3 = Color3.fromRGB(200, 200, 255)
spinInput.TextSize = 13
spinInput.Font = Enum.Font.GothamMedium
spinInput.ZIndex = 15
spinInput.Parent = spinCard
Instance.new("UICorner", spinInput).CornerRadius = UDim.new(0, 6)

local spinInputStroke = Instance.new("UIStroke")
spinInputStroke.Color = Color3.fromRGB(60, 60, 110)
spinInputStroke.Thickness = 1
spinInputStroke.Parent = spinInput

local spinToggle = Instance.new("TextButton")
spinToggle.Size = UDim2.new(0, 58, 0, 28)
spinToggle.Position = UDim2.new(1, -70, 0.5, -14)
spinToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
spinToggle.BorderSizePixel = 0
spinToggle.Text = "OFF"
spinToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
spinToggle.TextSize = 12
spinToggle.Font = Enum.Font.GothamBold
spinToggle.ZIndex = 15
spinToggle.Parent = spinCard
Instance.new("UICorner", spinToggle).CornerRadius = UDim.new(0, 6)

local spinEnabled = false
local spinSpeed = 20

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
        bav.Name = "NaitikSpin"
        bav.MaxTorque = Vector3.new(0, math.huge, 0)
        bav.AngularVelocity = Vector3.new(0, spinSpeed, 0)
        bav.Parent = root
    end
end

local function setSpinToggle(state)
    spinEnabled = state
    settings.spinEnabled = state
    saveSettings()
    if state then
        spinToggle.Text = "ON"
        spinToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        spinToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        spinCardStroke.Color = Color3.fromRGB(40, 160, 70)
    else
        spinToggle.Text = "OFF"
        spinToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        spinToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
        spinCardStroke.Color = Color3.fromRGB(55, 55, 100)
    end
    applySpin()
end

spinToggle.Activated:Connect(function()
    setSpinToggle(not spinEnabled)
end)

spinInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(spinInput.Text)
        if num then
            spinSpeed = num
            spinInput.Text = tostring(spinSpeed)
            settings.spinSpeedVal = spinSpeed
            saveSettings()
            if spinEnabled then applySpin() end
        else
            spinInput.Text = tostring(spinSpeed)
        end
    end
end)

Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.3)
    if spinEnabled then applySpin() end
end)

-- ── Noclip card ──────────────────────────────
local noclipCard = Instance.new("Frame")
noclipCard.Size = UDim2.new(1, 0, 0, 60)
noclipCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
noclipCard.BorderSizePixel = 0
noclipCard.ZIndex = 13
noclipCard.LayoutOrder = 7
noclipCard.Parent = featPage
Instance.new("UICorner", noclipCard).CornerRadius = UDim.new(0, 8)

local noclipCardStroke = Instance.new("UIStroke")
noclipCardStroke.Color = Color3.fromRGB(55, 55, 100)
noclipCardStroke.Thickness = 1.2
noclipCardStroke.Parent = noclipCard

local noclipCardLabel = Instance.new("TextLabel")
noclipCardLabel.Size = UDim2.new(1, -80, 1, 0)
noclipCardLabel.Position = UDim2.new(0, 12, 0, 0)
noclipCardLabel.BackgroundTransparency = 1
noclipCardLabel.Text = "👻  Noclip"
noclipCardLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
noclipCardLabel.TextSize = 14
noclipCardLabel.Font = Enum.Font.GothamBold
noclipCardLabel.TextXAlignment = Enum.TextXAlignment.Left
noclipCardLabel.ZIndex = 14
noclipCardLabel.Parent = noclipCard

local noclipCardSub = Instance.new("TextLabel")
noclipCardSub.Size = UDim2.new(1, -80, 0, 16)
noclipCardSub.Position = UDim2.new(0, 12, 0, 30)
noclipCardSub.BackgroundTransparency = 1
noclipCardSub.Text = "Walk through walls"
noclipCardSub.TextColor3 = Color3.fromRGB(110, 110, 150)
noclipCardSub.TextSize = 11
noclipCardSub.Font = Enum.Font.Gotham
noclipCardSub.TextXAlignment = Enum.TextXAlignment.Left
noclipCardSub.ZIndex = 14
noclipCardSub.Parent = noclipCard

local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0, 58, 0, 28)
noclipToggle.Position = UDim2.new(1, -70, 0.5, -14)
noclipToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
noclipToggle.BorderSizePixel = 0
noclipToggle.Text = "OFF"
noclipToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
noclipToggle.TextSize = 12
noclipToggle.Font = Enum.Font.GothamBold
noclipToggle.ZIndex = 15
noclipToggle.Parent = noclipCard
Instance.new("UICorner", noclipToggle).CornerRadius = UDim.new(0, 6)

local noclipEnabled = false
local noclipConn = nil
local noclipClip = true

local function startNoclip()
    noclipClip = false
    task.wait(0.1)
    noclipConn = game:GetService("RunService").Stepped:Connect(function()
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
    noclipEnabled = state
    settings.noclipEnabled = state
    saveSettings()
    if state then
        noclipToggle.Text = "ON"
        noclipToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        noclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        noclipCardStroke.Color = Color3.fromRGB(40, 160, 70)
        startNoclip()
    else
        noclipToggle.Text = "OFF"
        noclipToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        noclipToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
        noclipCardStroke.Color = Color3.fromRGB(55, 55, 100)
        stopNoclip()
    end
end

noclipToggle.Activated:Connect(function()
    setNoclipToggle(not noclipEnabled)
end)

Players.LocalPlayer.CharacterAdded:Connect(function()
    if noclipEnabled then startNoclip() end
end)

-- ── Fly card ──────────────────────────────
local flyCard = Instance.new("Frame")
flyCard.Size = UDim2.new(1, 0, 0, 70)
flyCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
flyCard.BorderSizePixel = 0
flyCard.ZIndex = 13
flyCard.LayoutOrder = 8
flyCard.Parent = featPage
Instance.new("UICorner", flyCard).CornerRadius = UDim.new(0, 8)

local flyCardStroke = Instance.new("UIStroke")
flyCardStroke.Color = Color3.fromRGB(55, 55, 100)
flyCardStroke.Thickness = 1.2
flyCardStroke.Parent = flyCard

local flyCardLabel = Instance.new("TextLabel")
flyCardLabel.Size = UDim2.new(0, 160, 0, 20)
flyCardLabel.Position = UDim2.new(0, 12, 0, 8)
flyCardLabel.BackgroundTransparency = 1
flyCardLabel.Text = "🚀  Fly"
flyCardLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
flyCardLabel.TextSize = 14
flyCardLabel.Font = Enum.Font.GothamBold
flyCardLabel.TextXAlignment = Enum.TextXAlignment.Left
flyCardLabel.ZIndex = 14
flyCardLabel.Parent = flyCard

local flyCardSub = Instance.new("TextLabel")
flyCardSub.Size = UDim2.new(0, 160, 0, 16)
flyCardSub.Position = UDim2.new(0, 12, 0, 32)
flyCardSub.BackgroundTransparency = 1
flyCardSub.Text = "WASD to move · Q/E up/down"
flyCardSub.TextColor3 = Color3.fromRGB(110, 110, 150)
flyCardSub.TextSize = 11
flyCardSub.Font = Enum.Font.Gotham
flyCardSub.TextXAlignment = Enum.TextXAlignment.Left
flyCardSub.ZIndex = 14
flyCardSub.Parent = flyCard

local flyInput = Instance.new("TextBox")
flyInput.Size = UDim2.new(0, 60, 0, 28)
flyInput.Position = UDim2.new(1, -140, 0.5, -14)
flyInput.BackgroundColor3 = Color3.fromRGB(28, 28, 46)
flyInput.BorderSizePixel = 0
flyInput.Text = "50"
flyInput.PlaceholderText = "Speed"
flyInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 120)
flyInput.TextColor3 = Color3.fromRGB(200, 200, 255)
flyInput.TextSize = 13
flyInput.Font = Enum.Font.GothamMedium
flyInput.ZIndex = 15
flyInput.Parent = flyCard
Instance.new("UICorner", flyInput).CornerRadius = UDim.new(0, 6)

local flyInputStroke = Instance.new("UIStroke")
flyInputStroke.Color = Color3.fromRGB(60, 60, 110)
flyInputStroke.Thickness = 1
flyInputStroke.Parent = flyInput

local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0, 58, 0, 28)
flyToggle.Position = UDim2.new(1, -70, 0.5, -14)
flyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
flyToggle.BorderSizePixel = 0
flyToggle.Text = "OFF"
flyToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
flyToggle.TextSize = 12
flyToggle.Font = Enum.Font.GothamBold
flyToggle.ZIndex = 15
flyToggle.Parent = flyCard
Instance.new("UICorner", flyToggle).CornerRadius = UDim.new(0, 6)

local FLYING = false
local FLY_CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
local FLY_LCONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
local FLY_SPEED = 0
local flySpeed = 50
local flyHumanoid, flyRoot
local flyEnabled = false

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.W then FLY_CONTROL.F = 1 end
    if input.KeyCode == Enum.KeyCode.S then FLY_CONTROL.B = -1 end
    if input.KeyCode == Enum.KeyCode.A then FLY_CONTROL.L = -1 end
    if input.KeyCode == Enum.KeyCode.D then FLY_CONTROL.R = 1 end
    if input.KeyCode == Enum.KeyCode.E then FLY_CONTROL.Q = 1 end
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
    BG.P = 9e4
    BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BG.CFrame = flyRoot.CFrame
    BG.Parent = flyRoot
    BV.Velocity = Vector3.new(0,0,0)
    BV.MaxForce = Vector3.new(9e9,9e9,9e9)
    BV.Parent = flyRoot
    task.spawn(function()
        repeat task.wait()
            local camera = workspace.CurrentCamera
            if flyHumanoid then flyHumanoid.PlatformStand = true end
            if FLY_CONTROL.L+FLY_CONTROL.R ~= 0 or FLY_CONTROL.F+FLY_CONTROL.B ~= 0 or FLY_CONTROL.Q+FLY_CONTROL.E ~= 0 then
                FLY_SPEED = flySpeed
            elseif FLY_SPEED ~= 0 then
                FLY_SPEED = 0
            end
            if (FLY_CONTROL.L+FLY_CONTROL.R) ~= 0 or (FLY_CONTROL.F+FLY_CONTROL.B) ~= 0 or (FLY_CONTROL.Q+FLY_CONTROL.E) ~= 0 then
                BV.Velocity = ((camera.CFrame.LookVector*(FLY_CONTROL.F+FLY_CONTROL.B)) + ((camera.CFrame*CFrame.new(FLY_CONTROL.L+FLY_CONTROL.R,(FLY_CONTROL.F+FLY_CONTROL.B+FLY_CONTROL.Q+FLY_CONTROL.E)*0.2,0).p) - camera.CFrame.p)) * FLY_SPEED
                FLY_LCONTROL = {F=FLY_CONTROL.F,B=FLY_CONTROL.B,L=FLY_CONTROL.L,R=FLY_CONTROL.R}
            elseif FLY_SPEED ~= 0 then
                BV.Velocity = ((camera.CFrame.LookVector*(FLY_LCONTROL.F+FLY_LCONTROL.B)) + ((camera.CFrame*CFrame.new(FLY_LCONTROL.L+FLY_LCONTROL.R,(FLY_LCONTROL.F+FLY_LCONTROL.B+FLY_CONTROL.Q+FLY_CONTROL.E)*0.2,0).p) - camera.CFrame.p)) * FLY_SPEED
            else
                BV.Velocity = Vector3.new(0,0,0)
            end
            BG.CFrame = camera.CFrame
        until not FLYING
        FLY_CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
        FLY_LCONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
        FLY_SPEED = 0
        BG:Destroy()
        BV:Destroy()
        if flyHumanoid then flyHumanoid.PlatformStand = false end
    end)
end

local function stopFly()
    FLYING = false
end

local function setFlyToggle(state)
    flyEnabled = state
    settings.flyEnabled = state
    saveSettings()
    if state then
        flyToggle.Text = "ON"
        flyToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        flyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        flyCardStroke.Color = Color3.fromRGB(40, 160, 70)
        local char = Players.LocalPlayer.Character
        if char then
            flyHumanoid = char:FindFirstChildOfClass("Humanoid")
            flyRoot = char:FindFirstChild("HumanoidRootPart")
            if flyHumanoid and flyRoot then startFly() end
        end
    else
        flyToggle.Text = "OFF"
        flyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        flyToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
        flyCardStroke.Color = Color3.fromRGB(55, 55, 100)
        stopFly()
    end
end

flyToggle.Activated:Connect(function()
    setFlyToggle(not flyEnabled)
end)

flyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(flyInput.Text)
        if num then
            flySpeed = math.clamp(num, 0, 500)
            flyInput.Text = tostring(flySpeed)
            settings.flySpeedVal = flySpeed
            saveSettings()
        else
            flyInput.Text = tostring(flySpeed)
        end
    end
end)

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.3)
    if flyEnabled then
        flyHumanoid = char:FindFirstChildOfClass("Humanoid")
        flyRoot = char:FindFirstChild("HumanoidRootPart")
        if flyHumanoid and flyRoot then startFly() end
    end
end)

-- ── ESP card ──────────────────────────────
local espCard = Instance.new("Frame")
espCard.Size = UDim2.new(1, 0, 0, 60)
espCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
espCard.BorderSizePixel = 0
espCard.ZIndex = 13
espCard.LayoutOrder = 9
espCard.Parent = featPage
Instance.new("UICorner", espCard).CornerRadius = UDim.new(0, 8)

local espCardStroke = Instance.new("UIStroke")
espCardStroke.Color = Color3.fromRGB(55, 55, 100)
espCardStroke.Thickness = 1.2
espCardStroke.Parent = espCard

local espCardLabel = Instance.new("TextLabel")
espCardLabel.Size = UDim2.new(1, -80, 1, 0)
espCardLabel.Position = UDim2.new(0, 12, 0, 0)
espCardLabel.BackgroundTransparency = 1
espCardLabel.Text = "👁  ESP"
espCardLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
espCardLabel.TextSize = 14
espCardLabel.Font = Enum.Font.GothamBold
espCardLabel.TextXAlignment = Enum.TextXAlignment.Left
espCardLabel.ZIndex = 14
espCardLabel.Parent = espCard

local espCardSub = Instance.new("TextLabel")
espCardSub.Size = UDim2.new(1, -80, 0, 16)
espCardSub.Position = UDim2.new(0, 12, 0, 30)
espCardSub.BackgroundTransparency = 1
espCardSub.Text = "Highlight players through walls"
espCardSub.TextColor3 = Color3.fromRGB(110, 110, 150)
espCardSub.TextSize = 11
espCardSub.Font = Enum.Font.Gotham
espCardSub.TextXAlignment = Enum.TextXAlignment.Left
espCardSub.ZIndex = 14
espCardSub.Parent = espCard

local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(0, 58, 0, 28)
espToggle.Position = UDim2.new(1, -70, 0.5, -14)
espToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
espToggle.BorderSizePixel = 0
espToggle.Text = "OFF"
espToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
espToggle.TextSize = 12
espToggle.Font = Enum.Font.GothamBold
espToggle.ZIndex = 15
espToggle.Parent = espCard
Instance.new("UICorner", espToggle).CornerRadius = UDim.new(0, 6)

local espEnabled = false
local espObjects = {}

local function createESP(plr)
    if plr == Players.LocalPlayer then return end
    local function apply(char)
        if not espEnabled then return end
        local head = char:FindFirstChild("Head")
        if not head then return end
        local highlight = Instance.new("Highlight")
        highlight.Name = "NaitikESP"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = char
        local bill = Instance.new("BillboardGui")
        bill.Name = "NaitikESPBill"
        bill.Size = UDim2.new(0, 100, 0, 20)
        bill.StudsOffset = Vector3.new(0, 2, 0)
        bill.AlwaysOnTop = true
        bill.Parent = head
        local nameText = Instance.new("TextLabel")
        nameText.Size = UDim2.new(1, 0, 1, 0)
        nameText.BackgroundTransparency = 1
        nameText.Text = plr.Name
        nameText.TextColor3 = Color3.fromRGB(255, 0, 0)
        nameText.TextStrokeTransparency = 0
        nameText.Font = Enum.Font.GothamBold
        nameText.TextScaled = true
        nameText.Parent = bill
        espObjects[plr] = {highlight, bill}
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
    espEnabled = state
    settings.espEnabled = state
    saveSettings()
    if state then
        espToggle.Text = "ON"
        espToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        espCardStroke.Color = Color3.fromRGB(40, 160, 70)
        enableESP()
    else
        espToggle.Text = "OFF"
        espToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        espToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
        espCardStroke.Color = Color3.fromRGB(55, 55, 100)
        disableESP()
    end
end

espToggle.Activated:Connect(function()
    setESPToggle(not espEnabled)
end)

Players.PlayerAdded:Connect(function(plr)
    if espEnabled then createESP(plr) end
end)

-- ── Hitbox card ──────────────────────────────
local hitboxCard = Instance.new("Frame")
hitboxCard.Size = UDim2.new(1, 0, 0, 70)
hitboxCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
hitboxCard.BorderSizePixel = 0
hitboxCard.ZIndex = 13
hitboxCard.LayoutOrder = 10
hitboxCard.Parent = featPage
Instance.new("UICorner", hitboxCard).CornerRadius = UDim.new(0, 8)

local hitboxCardStroke = Instance.new("UIStroke")
hitboxCardStroke.Color = Color3.fromRGB(55, 55, 100)
hitboxCardStroke.Thickness = 1.2
hitboxCardStroke.Parent = hitboxCard

local hitboxCardLabel = Instance.new("TextLabel")
hitboxCardLabel.Size = UDim2.new(0, 160, 0, 20)
hitboxCardLabel.Position = UDim2.new(0, 12, 0, 8)
hitboxCardLabel.BackgroundTransparency = 1
hitboxCardLabel.Text = "📦  Hitbox"
hitboxCardLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
hitboxCardLabel.TextSize = 14
hitboxCardLabel.Font = Enum.Font.GothamBold
hitboxCardLabel.TextXAlignment = Enum.TextXAlignment.Left
hitboxCardLabel.ZIndex = 14
hitboxCardLabel.Parent = hitboxCard

local hitboxCardSub = Instance.new("TextLabel")
hitboxCardSub.Size = UDim2.new(0, 160, 0, 16)
hitboxCardSub.Position = UDim2.new(0, 12, 0, 32)
hitboxCardSub.BackgroundTransparency = 1
hitboxCardSub.Text = "Expand enemy hitboxes"
hitboxCardSub.TextColor3 = Color3.fromRGB(110, 110, 150)
hitboxCardSub.TextSize = 11
hitboxCardSub.Font = Enum.Font.Gotham
hitboxCardSub.TextXAlignment = Enum.TextXAlignment.Left
hitboxCardSub.ZIndex = 14
hitboxCardSub.Parent = hitboxCard

local hitboxInput = Instance.new("TextBox")
hitboxInput.Size = UDim2.new(0, 60, 0, 28)
hitboxInput.Position = UDim2.new(1, -140, 0.5, -14)
hitboxInput.BackgroundColor3 = Color3.fromRGB(28, 28, 46)
hitboxInput.BorderSizePixel = 0
hitboxInput.Text = "5"
hitboxInput.PlaceholderText = "Size"
hitboxInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 120)
hitboxInput.TextColor3 = Color3.fromRGB(200, 200, 255)
hitboxInput.TextSize = 13
hitboxInput.Font = Enum.Font.GothamMedium
hitboxInput.ZIndex = 15
hitboxInput.Parent = hitboxCard
Instance.new("UICorner", hitboxInput).CornerRadius = UDim.new(0, 6)

local hitboxInputStroke = Instance.new("UIStroke")
hitboxInputStroke.Color = Color3.fromRGB(60, 60, 110)
hitboxInputStroke.Thickness = 1
hitboxInputStroke.Parent = hitboxInput

local hitboxToggle = Instance.new("TextButton")
hitboxToggle.Size = UDim2.new(0, 58, 0, 28)
hitboxToggle.Position = UDim2.new(1, -70, 0.5, -14)
hitboxToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
hitboxToggle.BorderSizePixel = 0
hitboxToggle.Text = "OFF"
hitboxToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
hitboxToggle.TextSize = 12
hitboxToggle.Font = Enum.Font.GothamBold
hitboxToggle.ZIndex = 15
hitboxToggle.Parent = hitboxCard
Instance.new("UICorner", hitboxToggle).CornerRadius = UDim.new(0, 6)

local hitboxEnabled = false
local hitboxSize = 5

local function applyHitbox(plr)
    if plr == Players.LocalPlayer then return end
    if not hitboxEnabled then return end
    local char = plr.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root and root:IsA("BasePart") then
        root.CanCollide = false
        root.Size = hitboxSize == 1 and Vector3.new(2,1,1) or Vector3.new(hitboxSize,hitboxSize,hitboxSize)
        root.Transparency = 0.4
    end
end

local function resetHitbox(plr)
    if plr == Players.LocalPlayer then return end
    local char = plr.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        root.Size = Vector3.new(2, 2, 1)
        root.Transparency = 1
        root.CanCollide = true
    end
end

local function applyAllHitboxes()
    for _, plr in pairs(Players:GetPlayers()) do applyHitbox(plr) end
end

local function resetAllHitboxes()
    for _, plr in pairs(Players:GetPlayers()) do resetHitbox(plr) end
end

local function setHitboxToggle(state)
    hitboxEnabled = state
    settings.hitboxEnabled = state
    saveSettings()
    if state then
        hitboxToggle.Text = "ON"
        hitboxToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        hitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        hitboxCardStroke.Color = Color3.fromRGB(40, 160, 70)
        applyAllHitboxes()
    else
        hitboxToggle.Text = "OFF"
        hitboxToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        hitboxToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
        hitboxCardStroke.Color = Color3.fromRGB(55, 55, 100)
        resetAllHitboxes()
    end
end

hitboxToggle.Activated:Connect(function()
    setHitboxToggle(not hitboxEnabled)
end)

hitboxInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(hitboxInput.Text)
        if num then
            hitboxSize = math.clamp(num, 1, 50)
            hitboxInput.Text = tostring(hitboxSize)
            settings.hitboxSizeVal = hitboxSize
            saveSettings()
            if hitboxEnabled then applyAllHitboxes() end
        else
            hitboxInput.Text = tostring(hitboxSize)
        end
    end
end)

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

-- ── WalkFling card ──────────────────────────────
local flingCard = Instance.new("Frame")
flingCard.Size = UDim2.new(1, 0, 0, 60)
flingCard.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
flingCard.BorderSizePixel = 0
flingCard.ZIndex = 13
flingCard.LayoutOrder = 11
flingCard.Parent = featPage
Instance.new("UICorner", flingCard).CornerRadius = UDim.new(0, 8)

local flingCardStroke = Instance.new("UIStroke")
flingCardStroke.Color = Color3.fromRGB(55, 55, 100)
flingCardStroke.Thickness = 1.2
flingCardStroke.Parent = flingCard

local flingCardLabel = Instance.new("TextLabel")
flingCardLabel.Size = UDim2.new(1, -80, 1, 0)
flingCardLabel.Position = UDim2.new(0, 12, 0, 0)
flingCardLabel.BackgroundTransparency = 1
flingCardLabel.Text = "💥  WalkFling"
flingCardLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
flingCardLabel.TextSize = 14
flingCardLabel.Font = Enum.Font.GothamBold
flingCardLabel.TextXAlignment = Enum.TextXAlignment.Left
flingCardLabel.ZIndex = 14
flingCardLabel.Parent = flingCard

local flingCardSub = Instance.new("TextLabel")
flingCardSub.Size = UDim2.new(1, -80, 0, 16)
flingCardSub.Position = UDim2.new(0, 12, 0, 30)
flingCardSub.BackgroundTransparency = 1
flingCardSub.Text = "Fling nearby players while walking"
flingCardSub.TextColor3 = Color3.fromRGB(110, 110, 150)
flingCardSub.TextSize = 11
flingCardSub.Font = Enum.Font.Gotham
flingCardSub.TextXAlignment = Enum.TextXAlignment.Left
flingCardSub.ZIndex = 14
flingCardSub.Parent = flingCard

local flingToggle = Instance.new("TextButton")
flingToggle.Size = UDim2.new(0, 58, 0, 28)
flingToggle.Position = UDim2.new(1, -70, 0.5, -14)
flingToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
flingToggle.BorderSizePixel = 0
flingToggle.Text = "OFF"
flingToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
flingToggle.TextSize = 12
flingToggle.Font = Enum.Font.GothamBold
flingToggle.ZIndex = 15
flingToggle.Parent = flingCard
Instance.new("UICorner", flingToggle).CornerRadius = UDim.new(0, 6)

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
            game:GetService("RunService").Heartbeat:Wait()
            char = Players.LocalPlayer.Character
            local root = getFlingRoot()
            while not (char and char.Parent and root and root.Parent) do
                game:GetService("RunService").Heartbeat:Wait()
                char = Players.LocalPlayer.Character
                root = getFlingRoot()
                if not walkflinging then return end
            end
            local vel = root.Velocity
            root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            game:GetService("RunService").RenderStepped:Wait()
            if char and char.Parent and root and root.Parent then
                root.Velocity = vel
            end
            game:GetService("RunService").Stepped:Wait()
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
    if state then
        flingToggle.Text = "ON"
        flingToggle.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        flingToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        flingCardStroke.Color = Color3.fromRGB(40, 160, 70)
        startWalkFling()
    else
        flingToggle.Text = "OFF"
        flingToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        flingToggle.TextColor3 = Color3.fromRGB(160, 160, 200)
        flingCardStroke.Color = Color3.fromRGB(55, 55, 100)
        stopWalkFling()
    end
end

flingToggle.Activated:Connect(function()
    setFlingToggle(not walkflinging)
end)

Players.LocalPlayer.CharacterAdded:Connect(function()
    if walkflinging then
        task.wait(1)
        startWalkFling()
    end
end)

-- ── Restore all saved feature settings on startup ──────────────────────────────
speedInput.Text = tostring(settings.speedVal)
currentWalkSpeed = settings.speedVal
applyWalkSpeed()

spinInput.Text = tostring(settings.spinSpeedVal)
spinSpeed = settings.spinSpeedVal
if settings.spinEnabled then setSpinToggle(true) end

if settings.noclipEnabled then setNoclipToggle(true) end

flyInput.Text = tostring(settings.flySpeedVal)
flySpeed = settings.flySpeedVal
if settings.flyEnabled then setFlyToggle(true) end

if settings.espEnabled then setESPToggle(true) end

hitboxInput.Text = tostring(settings.hitboxSizeVal)
hitboxSize = settings.hitboxSizeVal
if settings.hitboxEnabled then setHitboxToggle(true) end

if settings.flingEnabled then setFlingToggle(true) end

-- ──────────────────────────────────────────────
-- Default Tab
-- ──────────────────────────────────────────────
setActiveTab("Home")

-- ──────────────────────────────────────────────
-- Dragging
-- ──────────────────────────────────────────────
local dragging, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MenuFrame.Position
    end
end)

local dragChangedConn = UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MenuFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

local dragEndedConn = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ──────────────────────────────────────────────
-- Open / Close / Minimize
-- ──────────────────────────────────────────────
menuOpen = false

openMenu = function()
    menuOpen = true
    MenuFrame.Visible = true
end

hideMenu = function(showNotif)
    menuOpen = false
    MenuFrame.Visible = false
    if showNotif ~= false then
        showNotification()
    end
end

local keyBindConn
local teleportConn
local pingMonitorRunning = true

local function destroyAll()
    -- Stop monitors
    pingMonitorRunning = false
    -- Disconnect all external connections
    dragChangedConn:Disconnect()
    dragEndedConn:Disconnect()
    if keyBindConn    then keyBindConn:Disconnect()    end
    if ijConnection   then ijConnection:Disconnect()   end
    if mkKeyConn      then mkKeyConn:Disconnect()      end
    if teleportConn   then teleportConn:Disconnect()   end
    -- Destroy the entire GUI
    ScreenGui:Destroy()
end

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmDialog.Visible = true
end)

DialogYes.MouseButton1Click:Connect(function()
    destroyAll()
end)

DialogNo.MouseButton1Click:Connect(function()
    ConfirmDialog.Visible = false
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    hideMenu()
end)

keyBindConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == menuKey then
        if menuOpen then
            hideMenu()
        else
            openMenu()
        end
    end
end)

openMenu()

-- ──────────────────────────────────────────────
-- Auto re-execute on teleport
-- ──────────────────────────────────────────────
local LOADER_URL = "https://raw.githubusercontent.com/naitikthakur8273-alt/my_script/refs/heads/main/loader.lua"

teleportConn = Players.LocalPlayer.OnTeleport:Connect(function(state, placeId, spawnName)
    if state == Enum.TeleportState.Started then
        task.delay(4, function()
            pcall(function()
                local fn = loadstring(game:HttpGet(LOADER_URL))
                if fn then fn() end
            end)
        end)
    elseif state == Enum.TeleportState.Failed then
        ExecToastLabel.Text = "⚠  Teleport failed — retrying..."
        ExecToastLabel.TextColor3 = Color3.fromRGB(255, 160, 60)
        TweenService:Create(ExecToast, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -140, 1, -56)
        }):Play()
        task.delay(2, function()
            TweenService:Create(ExecToast, TweenInfo.new(0.3), {
                Position = UDim2.new(0.5, -140, 1, 10)
            }):Play()
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
    while pingMonitorRunning do
        task.wait(6)
        if not pingMonitorRunning then break end
        local ok, ping = pcall(function() return Players:GetNetworkPing() end)
        if ok and ping and ping > 5 and not warned then
            warned = true
            ExecToastLabel.Text = "📡  Connection lost — rejoining..."
            ExecToastLabel.TextColor3 = Color3.fromRGB(255, 120, 60)
            TweenService:Create(ExecToast, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, -140, 1, -56)
            }):Play()
            task.delay(2.5, function()
                pcall(function()
                    game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
                end)
            end)
        end
    end
end)
