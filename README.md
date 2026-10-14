# RealitySucks-HUD

<!-- RS community links -->

Free lightweight QBCore HUD displaying player ID, cash, bank, job and grade, with pause-menu hiding and configurable branding. Separate from RS HUDLife.

[Website](https://realitysucksrp.github.io/) | [Tebex Store](https://reality-sucks-rp-webstore.tebex.io/) | [Free Scripts](https://reality-sucks-rp-webstore.tebex.io/category/free-scripts) | [Discord](https://discord.gg/e9V3rPHySx) | [YouTube](https://www.youtube.com/@RealitySucksRP)

<!-- /RS community links -->

> Lightweight QBCore HUD — Player ID, Cash, Bank, Job and built-in Security Engine

<p align="center">
  <a href="https://reality-sucks-rp-webstore.tebex.io/category/free-scripts"><img src="https://img.shields.io/badge/BROWSE-FREE%20SCRIPTS-ff6a00?style=for-the-badge" alt="Browse RealitySucksRP free scripts on Tebex"></a>
  <a href="https://reality-sucks-rp-webstore.tebex.io/"><img src="https://img.shields.io/badge/SHOP-FULL%20TEBEX%20STORE-111111?style=for-the-badge" alt="Browse RealitySucksRP Tebex Store"></a>
  <a href="https://realitysucksrp.github.io/"><img src="https://img.shields.io/badge/VISIT-WEBSITE-0f6fff?style=for-the-badge" alt="Visit RealitySucksRP website"></a>
  <a href="https://discord.gg/e9V3rPHySx"><img src="https://img.shields.io/badge/JOIN-DISCORD-5865F2?style=for-the-badge" alt="Join RealitySucksRP Discord"></a>
</p>

> I build my own FiveM scripts and complete server setups including HUDs, phones, shops, weapons, racing, customs, garages, dealerships, zombie systems, warfare and Phantom encounters.

![License](https://img.shields.io/badge/license-GPL--3.0-red) ![Framework](https://img.shields.io/badge/framework-QBCore-blue)

## Features
- Displays Server ID, Citizen ID, Cash, Bank balance, Job and Grade
- Auto-hides when pause menu is open
- `/hudid` command to toggle HUD on/off
- Logo pulse animation on data update
- Built-in Security Engine (Discord webhook logging, 3-strike command watchdog, event rate limiter, session ban system)
- Fully customizable via config values in `client/main.lua`

## Preview
![HUD Preview](PREVIEW%20HUD.png)

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

## Complete FiveM Servers For Sale

I love making scripts and running wild in GTA, but I also enjoy building complete servers. I use tested RealitySucksRP systems and configure the build around the owner's gameplay, framework, economy, theme and direction.

- **QBCore Shell — $500**
- **Zombie Server — $700**
- **Full RP Server — $850**
- **30 days of Discord setup/support included**

**Website:** https://realitysucksrp.github.io/

**Tebex:** https://reality-sucks-rp-webstore.tebex.io/

**Discord:** https://discord.gg/e9V3rPHySx

## License
GPL-3.0 — Free to use, modify, and redistribute with credit.

---
Made by [RealitySucksRP](https://github.com/RealitySucksRP).