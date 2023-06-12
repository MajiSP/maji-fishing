local QBCore = exports['qb-core']:GetCoreObject()


--==========================================================================--
--======== IF YOU ADD OR CHANGE BAIT NAMES, MAKE SURE TO ADD HERE ==========--
--==========================================================================--
local allowedBaits = {
    "worm",
    "stink",
    "wiggle",
    "fly",
}

local allowedFish = {}

local function isAllowedBait(bait)
    for _, allowedBait in ipairs(allowedBaits) do
        if bait == allowedBait then
            return true
        end
    end
    return false
end

for k, v in pairs(Config) do
    if k ~= "FishingZones" and k ~= "Debug" and k ~= "RareFishChance" and k ~= "FishChance" and k ~= "SuccessUseBaitChance" and k ~= "WaitTimeBeforeCatching" then
        for _, fish in pairs(v) do
            table.insert(allowedFish, fish)
        end
    end
end

local function isAllowedFish(randomFish)
    for _, v in pairs(allowedFish) do
        if v == randomFish then
            return true
        end
    end
    return false
end

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('crp-userod', src, item.name)
end)


QBCore.Functions.CreateCallback('hasWorm', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return cb(false)
    end

    local wormItem = Player.Functions.GetItemByName("worm")
    if wormItem and wormItem.amount > 0 then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('hasWiggle', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return cb(false)
    end

    local wiggleItem = Player.Functions.GetItemByName("wiggle")
    if wiggleItem and wiggleItem.amount > 0 then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('hasFly', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return cb(false)
    end

    local flyItem = Player.Functions.GetItemByName("fly")
    if flyItem and flyItem.amount > 0 then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('hasStink', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return cb(false)
    end

    local stinkItem = Player.Functions.GetItemByName("stink")
    if stinkItem and stinkItem.amount > 0 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('removebait', function(bait)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.RemoveItem(bait, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[bait], "remove")
        TriggerEvent('qb-log:server:CreateLog', 'fishing', 'Received Fish', 'red', "**"..Player.PlayerData.name .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** removed 1x "..QBCore.Shared.Items[bait].label)
    end
end)

RegisterServerEvent('givebait', function(bait)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if not isAllowedBait(bait) then
            TriggerEvent('qb-log:server:CreateLog', 'fishing', 'CHEATER DETECTED', 'red', "**"..Player.PlayerData.name .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** attempted to spawn: "..QBCore.Shared.Items[bait].label)
            return
        end
        Player.Functions.AddItem(bait, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[bait], "add")
        TriggerEvent('qb-log:server:CreateLog', 'fishing', 'Received Fish', 'blue', "**"..Player.PlayerData.name .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** received 1x "..QBCore.Shared.Items[bait].label)
    end
end)

RegisterServerEvent('givefish', function(randomFish)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if not isAllowedFish(randomFish) then
            TriggerEvent('qb-log:server:CreateLog', 'fishing', 'CHEATER DETECTED', 'red', "**"..Player.PlayerData.name .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** attempted to spawn: "..QBCore.Shared.Items[randomFish].label)
            return
        end
        Player.Functions.AddItem(randomFish, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomFish], "add")
        TriggerEvent('qb-log:server:CreateLog', 'fishing', 'Received Fish', 'blue', "**"..Player.PlayerData.name .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** received 1x "..QBCore.Shared.Items[randomFish].label)
    end
end)