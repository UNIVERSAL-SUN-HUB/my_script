-- Loader UI Script
-- Place in StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ──────────────────────────────────────────────
-- Embedded Scripts
-- ──────────────────────────────────────────────
local SCRIPTS = {
    [1] = {
        display = "99 forset",
        code = "-- Script taken from https://xenoscripts.com website --\n\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/loader.lua\", true))()",
    },
    [2] = {
        display = "AAA-BLUE X HUM BLOX FRUIT SCRIPT",
        code = "_G.AutoTranslate = true\n_G.SaveConfig = true\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua\"))()",
    },
    [3] = {
        display = "AUTO EASTER EGG XENO DELTA 100+ STACKING AUTO V4",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/GRAVITY-Blox-Fruits-BEST-SCRIPT-SOLARA-AND-XENO-AUTO-V4-AUTO-LEVEL-AUTO-RAID-37566\"))()",
    },
    [4] = {
        display = "Admin panel Universal KEYLESS",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Universal-Script-Admin-Panel-Universal-KEYLESS-171955\"))()",
    },
    [5] = {
        display = "Auto Win Money Farm Kill All Aimbot",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Bite-By-Night-Auto-win-Money-Farm-Kill-All-Aimbot-and-70-features-202018\"))()",
    },
    [6] = {
        display = "MOLYN HUB KEYLESS",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Universal-Script-MOLYN-DEVELOPMENT-201480\"))()",
    },
    [7] = {
        display = "Real Cryptic Free",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/OnlyCryptic/Cryptic/hm/main.lua\"))()",
    },
    [8] = {
        display = "ZeScript Godmode speed bypass",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/DOORS-ZeScript-67246\"))()",
    },
    [9] = {
        display = "a gravity v2",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua\"))()",
    },
    [10] = {
        display = "bite by night",
        code = "loadstring(game:HttpGet(\"https://rawscripts.net/raw/Bite-By-Night-Auto-win-Money-Farm-Kill-All-Aimbot-and-70-features-202018\"))()",
    },
    [11] = {
        display = "blox fruits master hop",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/HopScript.luau\"))()",
    },
    [12] = {
        display = "blue x hub",
        code = "repeat wait() until game:IsLoaded() and game.Players.LocalPlayer\ngetgenv().Team = \"Marines\"\n_G.AutoTranslate = true\n_G.SaveConfig = true\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua\"))()",
    },
    [13] = {
        display = "bluexhum",
        code = "repeat wait() until game:IsLoaded() and game.Players.LocalPlayer\ngetgenv().Team = \"Marines\"\n_G.AutoTranslate = true\n_G.SaveConfig = true\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua\"))()",
    },
    [14] = {
        display = "break in 2",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/RScriptz/RobloxScripts/main/BreakIn2.lua\"))()",
    },
    [15] = {
        display = "crashed gravity",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua\"))()",
    },
    [16] = {
        display = "forsaken",
        code = "loadstring(game:HttpGet(\"https://pastebin.com/raw/zH9Extzk\"))()",
    },
    [17] = {
        display = "fruit find",
        code = "getgenv().Team = \"Marines\"\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/FindFruit.lua\"))()",
    },
    [18] = {
        display = "hop bounty hunt",
        code = "getgenv().Config = {\n    Team = \"Pirates\",\n    HideUI = true,\n    HuntConfig = {\n        [\"Earned Notification Enabled\"] = false,\n        [\"Reset Farm (New)\"] = true,\n        [\"Chat\"] = false,\n        [\"Farm Delay\"] = 0.22,\n        [\"Webhook\"] = { Enabled = false, Url = \"\" }\n    }\n}\nloadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/2ffcdb62773f587bfb9eb0d52bb35b0c.lua\"))()",
    },
    [19] = {
        display = "hop master blox fruit",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/HopScript.luau\"))()",
    },
    [20] = {
        display = "inf jump",
        code = "local InfiniteJumpEnabled = true\ngame:GetService(\"UserInputService\").JumpRequest:connect(function()\n\tif InfiniteJumpEnabled then\n\t\tgame:GetService(\"Players\").LocalPlayer.Character:FindFirstChildOfClass(\"Humanoid\"):ChangeState(\"Jumping\")\n\tend\nend)",
    },
    [21] = {
        display = "ink",
        code = "script_key=\"KEY_HERE\";\nloadstring(game:HttpGet(\"https://officialaxscripts.vercel.app/scripts/AX-Loader.lua\"))()",
    },
    [22] = {
        display = "ink game",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/eikikrkr-ux/bypasok/refs/heads/main/ok\"))()",
    },
    [23] = {
        display = "main (Ronix)",
        code = "--[[ Welcome to Ronix! ]]",
    },
    [24] = {
        display = "nullfire doors",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/TeamNullFire/NullFire/main/loader.lua\"))()",
    },
    [25] = {
        display = "orange",
        code = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/HieuDepTrai-Z/Dev_Orange/refs/heads/main/OrangeHub.lua\"))()",
    },
    [26] = {
        display = "untitled-6",
        code = "script_key = \"false\"\nloadstring(game:HttpGet(\"https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/BF-Beta.lua\"))()",
    },
    [27] = {
        display = "untitled-7 (AutoBounty)",
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
NotifLabel.Text = "🔑  Tap here or LControl to open"
NotifLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
NotifLabel.TextSize = 14
NotifLabel.Font = Enum.Font.GothamMedium
NotifLabel.ZIndex = 21
NotifLabel.AutoButtonColor = false
NotifLabel.Parent = Notification

NotifLabel.MouseButton1Click:Connect(function()
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
    { name = "Home",   icon = "🏠", order = 1 },
    { name = "Script", icon = "📜", order = 2 },
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

local homeDesc = Instance.new("TextLabel")
homeDesc.Size = UDim2.new(1, 0, 0, 60)
homeDesc.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
homeDesc.BorderSizePixel = 0
homeDesc.Text = "Use the sidebar to navigate between tabs.\nPress LControl to hide / show this menu."
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

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MenuFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
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

hideMenu = function()
    menuOpen = false
    MenuFrame.Visible = false
    showNotification()
end

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmDialog.Visible = true
end)

DialogYes.MouseButton1Click:Connect(function()
    ConfirmDialog.Visible = false
    hideMenu()
end)

DialogNo.MouseButton1Click:Connect(function()
    ConfirmDialog.Visible = false
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    hideMenu()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        if menuOpen then
            hideMenu()
        else
            openMenu()
        end
    end
end)

openMenu()
