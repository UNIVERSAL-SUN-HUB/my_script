# Roblox Teleport Utility

## Project Overview

This is a collection of Roblox Lua (Luau) scripts that implement a player teleportation system with a smooth tween animation. The scripts are designed to run inside the Roblox game engine and cannot be executed as a standalone web or desktop application.

## Scripts

- **loader.lua** — Bootstrapper that fetches and executes `server_logic.lua` and `ui_client.lua` from a remote GitHub URL using `HttpService`.
- **ui_client.lua** — Client-side script that creates a ScreenGui with player name inputs and a confirm button, then fires a `RemoteEvent` to the server.
- **server_logic.lua** — Server-side script that listens for the `RemoteEvent` and tweens one player's `HumanoidRootPart` to another player's position.
- **ServerHandler.lua** — Alternative server-side implementation of the teleportation logic using `TweenService`.
- **main.lua** — Client-side script intended to be parented inside a GUI Frame, handling button clicks and firing `TeleportEvent`.

## Usage

These scripts must be placed inside a Roblox game (via Roblox Studio):
1. Place `server_logic.lua` or `ServerHandler.lua` in `ServerScriptService`.
2. Place `ui_client.lua` or `main.lua` in `StarterPlayerScripts` or inside a GUI object.
3. Use `loader.lua` as an alternative bootstrapper that fetches scripts remotely.

## Notes

- This project has no web frontend, backend server, or build system.
- It cannot be run directly in the Replit environment — it requires the Roblox engine.
- Language: Lua / Luau (Roblox variant)
