-- Loader UI Script
-- Place in StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ──────────────────────────────────────────────
-- ScreenGui Setup
-- ──────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoaderGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- ──────────────────────────────────────────────
-- Notification
-- ──────────────────────────────────────────────
local Notification = Instance.new("Frame")
Notification.Name = "Notification"
Notification.Size = UDim2.new(0, 260, 0, 40)
Notification.Position = UDim2.new(0.5, -130, 0, -50)
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

local NotifLabel = Instance.new("TextLabel")
NotifLabel.Size = UDim2.new(1, 0, 1, 0)
NotifLabel.BackgroundTransparency = 1
NotifLabel.Text = "🔑  Press LControl to open menu"
NotifLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
NotifLabel.TextSize = 14
NotifLabel.Font = Enum.Font.GothamMedium
NotifLabel.ZIndex = 21
NotifLabel.Parent = Notification

-- Slide notification in, wait 2s, slide out
local function showNotification()
	TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, -130, 0, 16)
	}):Play()

	task.delay(2, function()
		TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(0.5, -130, 0, -50)
		}):Play()
	end)
end

showNotification()

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

-- Yes button
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

-- No button
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
MenuFrame.Size = UDim2.new(0, 460, 0, 320)
MenuFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
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

-- Fill bottom corners of title bar so it blends
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

-- Minimize button
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

-- Close button
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

-- ── Sidebar (Tab Navigation) ──
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
local activeTab = nil

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
	pagePad.PaddingTop = UDim.new(0, 10)
	pagePad.PaddingLeft = UDim.new(0, 10)
	pagePad.PaddingRight = UDim.new(0, 10)
	pagePad.Parent = page

	local pageLayout = Instance.new("UIListLayout")
	pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	pageLayout.Padding = UDim.new(0, 8)
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
	activeTab = name
end

-- ── Register Tabs ──
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
-- Home Page Content
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

local homeWelcomeCorner = Instance.new("UICorner")
homeWelcomeCorner.CornerRadius = UDim.new(0, 8)
homeWelcomeCorner.Parent = homeWelcome

local homeDesc = Instance.new("TextLabel")
homeDesc.Size = UDim2.new(1, 0, 0, 60)
homeDesc.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
homeDesc.BorderSizePixel = 0
homeDesc.Text = "Use the sidebar to navigate.\nPress LControl to hide / show this menu."
homeDesc.TextColor3 = Color3.fromRGB(160, 160, 200)
homeDesc.TextSize = 13
homeDesc.Font = Enum.Font.Gotham
homeDesc.TextWrapped = true
homeDesc.ZIndex = 13
homeDesc.LayoutOrder = 2
homeDesc.Parent = homePage

local homeDescCorner = Instance.new("UICorner")
homeDescCorner.CornerRadius = UDim.new(0, 8)
homeDescCorner.Parent = homeDesc

-- ──────────────────────────────────────────────
-- Script Page Content
-- ──────────────────────────────────────────────
local scriptPage = tabs["Script"].page

local scriptHeader = Instance.new("TextLabel")
scriptHeader.Size = UDim2.new(1, 0, 0, 36)
scriptHeader.BackgroundColor3 = Color3.fromRGB(20, 20, 36)
scriptHeader.BorderSizePixel = 0
scriptHeader.Text = "📜  Scripts"
scriptHeader.TextColor3 = Color3.fromRGB(200, 200, 255)
scriptHeader.TextSize = 15
scriptHeader.Font = Enum.Font.GothamBold
scriptHeader.ZIndex = 13
scriptHeader.LayoutOrder = 1
scriptHeader.Parent = scriptPage

local scriptHeaderCorner = Instance.new("UICorner")
scriptHeaderCorner.CornerRadius = UDim.new(0, 8)
scriptHeaderCorner.Parent = scriptHeader

local scriptPlaceholder = Instance.new("TextLabel")
scriptPlaceholder.Size = UDim2.new(1, 0, 0, 50)
scriptPlaceholder.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
scriptPlaceholder.BorderSizePixel = 0
scriptPlaceholder.Text = "No scripts loaded yet."
scriptPlaceholder.TextColor3 = Color3.fromRGB(120, 120, 160)
scriptPlaceholder.TextSize = 13
scriptPlaceholder.Font = Enum.Font.Gotham
scriptPlaceholder.ZIndex = 13
scriptPlaceholder.LayoutOrder = 2
scriptPlaceholder.Parent = scriptPage

local scriptPlaceholderCorner = Instance.new("UICorner")
scriptPlaceholderCorner.CornerRadius = UDim.new(0, 8)
scriptPlaceholderCorner.Parent = scriptPlaceholder

-- ──────────────────────────────────────────────
-- Default Active Tab
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
-- Open / Close / Minimize Logic
-- ──────────────────────────────────────────────
local menuOpen = false

local function openMenu()
	menuOpen = true
	MenuFrame.Visible = true
end

local function hideMenu()
	menuOpen = false
	MenuFrame.Visible = false
	-- Show notification hint
	showNotification()
end

-- Close button → confirm dialog
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

-- Minimize button
MinimizeBtn.MouseButton1Click:Connect(function()
	hideMenu()
end)

-- LControl toggles menu
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

-- Show menu initially
openMenu()
