# RealitySucks-HUD
> Lightweight QBCore HUD — Player ID, Cash, Bank, Job & built-in Security Engine

![License](https://img.shields.io/badge/license-GPL--3.0-red) ![Framework](https://img.shields.io/badge/framework-QBCore-blue) ![Version](https://img.shields.io/badge/version-1.0.0-green)

## Features
- Displays Server ID, Citizen ID, Cash, Bank balance, Job & Grade
- Auto-hides when pause menu is open
- `/hudid` command to toggle HUD on/off
- Logo pulse animation on data update
- Built-in Security Engine (Discord webhook logging, 3-strike command watchdog, event rate limiter, session ban system)
- Fully customizable via config values in `client/main.lua`

## Preview
> Screenshot coming soon

## Dependencies
- [QBCore Framework](https://github.com/qbcore-framework/qb-core)

## Installation
1. Download and extract into your `resources` folder
2. Add `ensure RealitySucks-HUD` to your `server.cfg`
3. Open `server/logs.lua` and add your Discord webhook URL
4. Replace `html/logo.png` with your own server logo
5. Restart your server

## Configuration
| Option | Default | Description |
|---|---|---|
| `enabled` | `true` | HUD visible on spawn |
| `update_interval` | `500` | Data refresh rate in ms |

## Security Engine
The included `server/logs.lua` runs a passive security watchdog:
- Logs unauthorized command attempts to Discord
- 3-strike system before session ban
- Event rate limiter blocks spam/exploit triggers
- Auto-cleanup on player disconnect

Add your Discord webhook to `server/logs.lua`:
```lua
local discordWebhook = "YOUR_WEBHOOK_HERE"
```

## License
GPL-3.0 — Free to use, modify, and redistribute with credit.

---
Made by [RealitySucksRP](https://github.com/RealitySucksRP) — built for the community, not for profit.
