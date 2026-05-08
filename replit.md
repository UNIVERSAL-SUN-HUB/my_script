# Naitik Hub — Roblox Script Hub / Loader Menu

## Project Overview

This is a Roblox Script Hub system — a GUI-based menu that lets players browse and execute a curated collection of Lua scripts inside Roblox games. It is built entirely in Lua / Luau (the Roblox variant) and must be used inside the Roblox game engine via an executor.

## How It Works

### Entry Point: `main_loader.lua`
Paste this into your executor. It shows a styled confirmation dialog ("Do you want to execute the Loader?") and then:
1. Fetches `loader.lua` from GitHub (`naitikthakur8273-alt/my_script`)
2. Shows a progress bar with animated loading stages
3. Compiles and runs it, then destroys the boot screen

### Main Hub: `loader.lua`
The full script hub UI placed in `StarterPlayerScripts`. Features:
- **Tabbed menu** with Home, Script, Executor, and Features tabs
- **Sidebar navigation** for switching between tabs
- **27 embedded scripts** — each entry has a display name and a `loadstring` call to execute it
- **Confirm dialog** before closing the menu
- **Minimize / Close buttons** with tween animations
- **Notification bar** that slides in to tell you the toggle key (default: LControl)
- **Execution toast** — pops up at the bottom when a script is executed
- **Settings persistence** — saves `menuKey` and `ijEnabled` to a local file
- **Mobile detection** — auto-scales the UI for touch devices
- **Draggable window** — the menu can be repositioned by dragging the title bar

## Individual Scripts (`attached_assets/scripts_extracted/scripts/`)

These are the scripts embedded into the hub. They cover a variety of Roblox games:

| Script | Game / Purpose |
|--------|---------------|
| `blox fruits master hop.lua` | Blox Fruits — server hopper |
| `hop bounty hunt.lua` | Blox Fruits — auto bounty hunting |
| `hop master blox fruit.lua` | Blox Fruits — master hop |
| `blue x hub.lua` / `bluexhum.lua` | Blox Fruits — Blue X Hub |
| `crashed gravity.lua` / `99 forset.lua` | Blox Fruits — Gravity Hub |
| `untitled-7.lua` | Blox Fruits — AutoBounty (SeraHub) with full config |
| `untitled-6.lua` | Blox Fruits — WhiteX BF-Beta |
| `nullfire doors.lua` | DOORS — NullFire script |
| `ZeScript Godmode speed bypass.lua` | DOORS — ZeScript |
| `break in 2.lua` | Break In 2 |
| `forsaken.lua` | Forsaken |
| `bite by night.lua` | Bite By Night — auto win, money farm, aimbot |
| `Auto Win Money Farm Kill All Aimbot and 70 featur.lua` | Bite By Night (same) |
| `ink game.lua` | Ink game bypass |
| `Admin panel Universal KEYLESS.lua` | Universal admin panel |
| `MOLYN HUB KEYLESS.lua` | Universal — Molyn Development hub |
| `Real Cryptic Free.lua` | Cryptic script |
| `inf jump.lua` | Infinite jump utility |
| `main.lua` | Ronix placeholder |

## Usage

1. Copy `main_loader.lua` into your Roblox executor.
2. Execute it inside a Roblox game.
3. Click "Execute" in the confirmation dialog.
4. The loader fetches and runs `loader.lua` from GitHub, opening the hub menu.
5. Press **LControl** (or your configured key) to toggle the menu open/closed.
6. Browse the Script tab, pick a script, and click to execute it.

## Notes

- These scripts require a Roblox executor (e.g., Synapse X, KRNL, Fluxus, etc.)
- Cannot be run in the Replit environment — requires the Roblox game engine
- Language: Lua / Luau (Roblox variant)
- `loader.lua` is hosted on GitHub and fetched at runtime by `main_loader.lua`
