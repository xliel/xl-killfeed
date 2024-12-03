RegisterNetEvent('xl-killfeed:client:addFeedEntry')
AddEventHandler('xl-killfeed:client:addFeedEntry', function(data)
    SendNUIMessage({
        action = 'addFeedEntry',
        data = {killerName = data.killerName, victimName = data.victimName}
    })
end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event ~= 'CEventNetworkEntityDamage' then return end

    local victim, victimDied = data[1], data[4]
    if not IsPedAPlayer(victim) then return end

    local playerId = PlayerId()
    local playerPed = PlayerPedId()

    if victimDied and NetworkGetPlayerIndexFromPed(victim) == playerId and (IsPedDeadOrDying(victim, true) or IsPedFatallyInjured(victim)) then
        local killerEntity, deathCause = GetPedSourceOfDeath(playerPed), GetPedCauseOfDeath(playerPed)
        local killerClientId = NetworkGetPlayerIndexFromPed(killerEntity)
        if killerEntity ~= playerPed and killerClientId and
            NetworkIsPlayerActive(killerClientId) then
            local killerServerId = GetPlayerServerId(killerClientId)
            TriggerServerEvent('xl-killfeed:server:playerDied', {
                killedByPlayer = true,
                killerServerId = killerServerId,
                killerClientId = killerClientId,
                deathCause = deathCause
            })
        else
            TriggerServerEvent('xl-killfeed:server:playerDied', {
                killedByPlayer = false,
                deathCause = deathCause
            })
        end
    end
end)