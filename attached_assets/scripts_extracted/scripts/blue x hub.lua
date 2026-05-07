repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Team = "Marines" -- Set to "Marines" to join the Marine team
_G.AutoTranslate = true
_G.SaveConfig = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()