local discordWebhook = ""    -- your discord webhook goes here brah
local playerStrikes = {} 
local bannedLicenses = {} 
local eventCounters = {}
local MAX_EVENTS_PER_SECOND = 10 -- Limits how many times per second a player can trigger any server event

-- Global Discord Logger
local function sendToDiscord(name, message, color)
    local embed = {
        {
            ["color"] = color or 16711680, 
            ["title"] = "[SECURITY] Reality Sucks Security Engine",
            ["description"] = message,
            ["footer"] = { ["text"] = "Reality Sucks RP Security | System Active" },
            ["author"] = { ["name"] = name or "System" },
            ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%SZ')
        }
    }
    PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Watchdog Security", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

-- 1. CONNECTION PROTECTOR (Block Session-Banned players)
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    local license = GetPlayerIdentifier(src, 0)
    if license and bannedLicenses[license] then
        deferrals.defer()
        Wait(500)
        deferrals.done("[X] You are temporarily blacklisted from this session due to multiple security violations. Appeal in Discord.")
    end
end)

-- 2. COMMAND WATCHDOG (Strike System for /np, /restart, etc.)
AddEventHandler('commandComplete', function(source, command)
    if source == 0 then return end -- Ignore console
    
    local sensitiveCommands = {
        ["np"] = true, 
        ["start"] = true, 
        ["stop"] = true,
        ["restart"] = true,
        ["ensure"] = true,
        ["refresh"] = true,
        ["kill"] = true,
        ["revive"] = true, 
        ["consumables"] = true,
        ["clearveh"] = true,
        ["admin"] = true,
        ["givemoney"] = true,
        ["setjob"] = true,
        ["admin"] = true,
        ["vmenu"] = true
    }

    if sensitiveCommands[command] then
        -- Check if player is NOT an admin
        if not IsPlayerAceAllowed(source, "command.restart") then
            local name = GetPlayerName(source)
            local license = GetPlayerIdentifier(source, 0)
            
            playerStrikes[license] = (playerStrikes[license] or 0) + 1
            local strikes = playerStrikes[license]

            if strikes >= 3 then
                bannedLicenses[license] = true
                sendToDiscord(name, string.format("[SECURITY] **PLAYER BANNED (SESSION)**\n\n**User:** %s\n**Final Strike Command:** `/%s`\n**Attempts:** 3/3\n**Action:** Session Blacklist Applied\n**Identifier:** `%s`", name, command, license), 16711680)
                DropPlayer(source, "[X] Security: Unauthorized access attempt detected (3/3). You have been banned for this session.")
            else
                sendToDiscord(name, string.format("[SECURITY] **Unauthorized Command Attempt**\n\n**User:** %s\n**Command:** `/%s`\n**Strike:** %s/3\n**Server ID:** %s\n*Player logged but not kicked yet.*", name, command, strikes, source), 16776960)
            end
        end
    end
end)

-- 3. EVENT RATE LIMITER (Anti-Spam/Anti-Cheat)
AddEventHandler('netEventMsg', function(eventName, source, ...)
    local src = source
    if src == 0 or not eventName then return end

    local license = GetPlayerIdentifier(src, 0)
    local currentTime = os.time()

    if not eventCounters[src] then
        eventCounters[src] = { lastTime = currentTime, count = 0 }
    end

    -- Reset counter every second
    if eventCounters[src].lastTime ~= currentTime then
        eventCounters[src].count = 0
        eventCounters[src].lastTime = currentTime
    end

    eventCounters[src].count = eventCounters[src].count + 1

    -- Check if they exceeded the limit (10 events per second)
    if eventCounters[src].count > MAX_EVENTS_PER_SECOND then
        CancelEvent() -- Blocks the malicious trigger
        
        if not bannedLicenses[license] then
            bannedLicenses[license] = true
            sendToDiscord(GetPlayerName(src), string.format("[SECURITY] **EVENT SPAM DETECTED (AUTO-BAN)**\n\n**Player:** %s\n**Event:** %s\n**Rate:** %s/sec\n**Action:** Session Blacklist Applied", GetPlayerName(src), eventName, eventCounters[src].count), 16711680)
            DropPlayer(src, "[X] Security: Excessive network traffic detected (Event Spam).")
        end
    end
end)

-- Cleanup on disconnect
AddEventHandler('playerDropped', function()
    local src = source
    local license = GetPlayerIdentifier(src, 0)
    if license then
        playerStrikes[license] = nil 
        eventCounters[src] = nil
    end
end)