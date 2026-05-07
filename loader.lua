local HttpService = game:GetService("HttpService")
local raw = "https://githubusercontent.com"

-- Load Server Logic
loadstring(HttpService:GetAsync(raw .. "server_logic.lua"))()

-- Load UI Client
loadstring(HttpService:GetAsync(raw .. "ui_client.lua"))()
