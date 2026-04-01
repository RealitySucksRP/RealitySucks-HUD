local QBCore = exports['qb-core']:GetCoreObject()

local cfg = {
    enabled = true,
    update_interval = 500,
    isVisible = true -- Tracks current state
}

local function fetchData()
    local pd = QBCore.Functions.GetPlayerData()
    if not pd then return end

    SendNUIMessage({
        action = "update",
        sid = GetPlayerServerId(PlayerId()),
        cid = pd.citizenid or "",
        cash = tonumber(pd.money and pd.money["cash"] or 0),
        bank = tonumber(pd.money and pd.money["bank"] or 0),
        job = (pd.job and (pd.job.label or pd.job.name)) or "Unemployed",
        grade = (pd.job and pd.job.grade and pd.job.grade.name) or ""
    })
end

CreateThread(function()
    while true do
        local isPaused = IsPauseMenuActive()
        
        -- If paused OR toggled off, hide the HUD
        if isPaused or not cfg.enabled then
            if cfg.isVisible then
                SendNUIMessage({action = "toggle", show = false})
                cfg.isVisible = false
            end
        else
            -- If not paused AND toggled on, show HUD and update data
            if not cfg.isVisible then
                SendNUIMessage({action = "toggle", show = true})
                cfg.isVisible = true
            end
            fetchData()
        end
        Wait(cfg.update_interval)
    end
end)

RegisterCommand("hudid", function()
    cfg.enabled = not cfg.enabled
end, false)