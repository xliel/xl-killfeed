RegisterNetEvent('xl-killfeed:server:playerDied')
AddEventHandler('xl-killfeed:server:playerDied', function(data)
    local src = source
    local killer = data.killedByPlayer and GetPlayerName(data.killerServerId) or data.deathCause
    if killer == -842959696 then
        killer = '(Suicide)'
    end
    
    TriggerClientEvent('xl-killfeed:client:addFeedEntry', -1, {
        killerName = killer,
        victimName = GetPlayerName(src)
    })
end)