local QBCore = exports['qb-core']:GetCoreObject()
local rodInHand = 0

local baitSelected = nil

local inZone = false

local isFishing = false

local canFish = false

local src = source

local playerId = GetPlayerServerId(player)

RegisterNetEvent('crp-userod', function()
    if rodInHand == 1 then
        if Config.Debug == true then
            print(baitSelected)
        end
        DeleteObject(rod)
        rodInHand = 0
    else
        DeleteObject(rod)
        local playerPed = PlayerPedId()
        local lefthand = GetPedBoneIndex(playerPed, 18905)
        rod = CreateObject(GetHashKey("prop_fishing_rod_01"), 0, 0, 0, true, true, true)
        AttachEntityToEntity(rod, playerPed, lefthand, 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
        rodInHand = 1
        if rodInHand == 1 and baitSelected == nil then
            lib.showMenu('bait_menu')
        end
    end
end)

lib.registerMenu({
    id = 'bait_menu',
    title = 'Select Bait',
    position = 'top-right',
    onSideScroll = function(selected, scrollIndex, args)
    end,
    onSelected = function(selected, secondary, args)
        if not secondary then
        else
            if args.isCheck then
            end
            if args.isScroll then
            end
        end
    end,
    onCheck = function(selected, checked, args)
    end,
    onClose = function(keyPressed)
        if keyPressed then
            if baitSelected == nil then
                DeleteObject(rod)
                QBCore.Functions.Notify('You must select a bait!', 'error', 1500)
                rodInHand = 0
            end
        end
    end,
    options = {
        --1
        {label = 'Worm Bait', icon = 'fa-worm', description = 'Worm Bait for Freshwater Fish.'},
        --2
        {label = 'Fly Bait', icon = 'fa-mosquito', description = 'Fly Bait for Freshwater and Saltwater Fish.'},
        --3
        {label = 'Stink Bait', icon = 'fa-viruses', description = 'Stink Bait for Big Monsters.'},
        --4
        {label = 'Wiggle Bait', icon = 'fa-bugs', description = 'Wiggle Bait for Wiggly Fish.'},
        --5
        {label = 'Check Bait', icon = 'fa-magnifying-glass', description = 'Check which bait you have on your hook.'},
        --6
        {label = 'Remove Bait', icon = 'fa-x', description = 'Remove your bait from the rod.'},
    }
}, function(selected, scrollIndex, args)
    if selected == 1 then
        CheckForWorm()
    elseif selected == 2 then
        CheckForFly()
    elseif selected == 3 then
        CheckForStink()
    elseif selected == 4 then
        CheckForWiggle()
    elseif selected == 5 then
        TriggerEvent('checkbait')
    elseif selected == 6 then
        TriggerEvent('removebait')
    end
end)

RegisterNetEvent('checkbait', function()
    if baitSelected == nil then
        QBCore.Functions.Notify('You do not have any bait on the hook!', 'error', 1500)
        DeleteObject(rod)
        rodInHand = 0
    else
        QBCore.Functions.Notify('Your current bait is: ' .. baitSelected, 'success', 1500)
    end
end)

RegisterNetEvent('removebait', function()
    if baitSelected == nil then
        QBCore.Functions.Notify('You do not have any bait on the hook!', 'error', 1500)
        DeleteObject(rod)
        rodInHand = 0
    else
        QBCore.Functions.Progressbar('removebait', 'Removing Bait...', 10000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
            }, {}, {}, {}, function()
                QBCore.Functions.Notify('Bait Removed!', 'success', 1500)
                TriggerServerEvent('givebait', baitSelected)
                baitSelected = nil
                lib.showMenu('bait_menu')
                if Config.Debug == true then
                    print(baitSelected)
                end
            end, function()
            QBCore.Functions.Notify('You Stopped Removing Your Bait!', 'error', 1500)
        end)
    end
end)

RegisterNetEvent('attachwormbait', function()
    QBCore.Functions.Progressbar('attachbait', 'Attaching Worm Bait...', 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
        }, {}, {}, {}, function()
            QBCore.Functions.Notify('Worm Bait Applied', 'success', 1500)
            baitSelected = "worm"
            rodInHand = 1
            TriggerServerEvent('removebait', baitSelected)
            if Config.Debug == true then
                print(baitSelected)
            end
        end, function()
        QBCore.Functions.Notify('You Stopped Applying Bait!', 'error', 1500)
        DeleteObject(rod)
        rodInHand = 0
    end)
end)

RegisterNetEvent('attachflybait', function()
    QBCore.Functions.Progressbar('attachbait', 'Attaching Fly Bait...', 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
        }, {}, {}, {}, function()
            QBCore.Functions.Notify('Fly Bait Applied', 'success', 1500)
            baitSelected = "fly"
            rodInHand = 1
            TriggerServerEvent('removebait', baitSelected)
            if Config.Debug == true then
                print(baitSelected)
            end
        end, function()
        QBCore.Functions.Notify('You Stopped Applying Bait!', 'error', 1500)
        DeleteObject(rod)
        rodInHand = 0
    end)
end)

RegisterNetEvent('attachstinkbait', function()
    QBCore.Functions.Progressbar('attachbait', 'Attaching Stink Bait...', 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
        }, {}, {}, {}, function()
            QBCore.Functions.Notify('Stink Bait Applied', 'success', 1500)
            baitSelected = "stink"
            rodInHand = 1
            TriggerServerEvent('removebait', baitSelected)
            if Config.Debug == true then
                print(baitSelected)
            end
        end, function()
        QBCore.Functions.Notify('You Stopped Applying Bait!', 'error', 1500)
        DeleteObject(rod)
        rodInHand = 0
    end)
end)

RegisterNetEvent('attachwigglebait', function()
    QBCore.Functions.Progressbar('attachbait', 'Attaching Wiggle Bait...', 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
        }, {}, {}, {}, function()
            QBCore.Functions.Notify('Wiggle Bait Applied', 'success', 1500)
            baitSelected = "wiggle"
            rodInHand = 1
            TriggerServerEvent('removebait', baitSelected)
            if Config.Debug == true then
                print(baitSelected)
            end
        end, function()
        QBCore.Functions.Notify('You Stopped Applying Bait!', 'error', 1500)
        DeleteObject(rod)
        rodInHand = 0
    end)
end)

CreateThread(function()

    local FishSpot = {}

    for k, v in pairs(Config.FishingZones) do
        FishSpot[#FishSpot+1] = PolyZone:Create(v.PolyZone, {
            name = k,
            minZ = 	v.MinZ,
            maxZ = v.MaxZ,
            debugPoly = true,
        })
        zoneName = k
    end

    local fishCombo = ComboZone:Create(FishSpot, {
        name = "fishCombo",
        debugPoly = false
    })
    fishCombo:onPlayerInOut(function(isPointInside, point, zone)
        location = zone
        if isPointInside then
            lib.showTextUI('Fishing Zone', {
                position = "left-center",
            })
            canFish = true
        else
            lib.hideTextUI()
            canFish = false
        end
    end)
end)

RegisterCommand('+fish', function(zone)
    if canFish and rodInHand == 1 then
        if Config.Debug == true then
            if zone then
                print("Fishing in zone: " .. location.name)
            end
        end
        TriggerEvent('fish')
    elseif not canFish and rodInHand == 1 then
        QBCore.Functions.Notify("You can\'t fish over here...", 'error', 1500)
    end
end)

RegisterNetEvent('fish', function()
    if isFishing then return end

    if not canFish then
        QBCore.Functions.Notify("You can\'t fish over here...", 'error', 1500)
        return
    elseif canFish then
        if baitSelected == "worm" then
            isFishing = true

            local animDict = "amb@world_human_stand_fishing@idle_a"
            local animName = "idle_b"
            local playerPed = PlayerPedId()
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(0)
            end
            TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

            Wait(Config.WaitTimeBeforeCatching)

            exports['ps-ui']:Circle(function(success)
                if success then
                    isFishing = false
                    if math.random(1, 100) <= Config.RareFishChance then
                        TriggerEvent('giverarefish')
                        ClearPedTasks(playerPed)
                        if math.random(1, 100) <= Config.SuccessUseBaitChance then
                            baitSelected = nil
                            QBCore.Functions.Notify("Your bait was consumed!", 'error', 1500)
                            rodInHand = 0
                            DeleteObject(rod)
                        end
                    elseif math.random(1, 100) <= Config.FishChance then
                        TriggerEvent('givefish')
                        ClearPedTasks(playerPed)
                    else
                        QBCore.Functions.Notify("You caught no fish!", 'error', 1500)
                        ClearPedTasks(playerPed)
                    end
                else
                    isFishing = false
                    QBCore.Functions.Notify("The fish broke off the hook!", 'error', 1500)
                    baitSelected = nil
                    ClearPedTasks(playerPed)
                    DeleteObject(rod)
                    rodInHand = 0
                end
            end, 8, 40)
        elseif baitSelected == "stink" then
            if location.name == "pier" or location.name == "alamosea" then
                isFishing = false
                QBCore.Functions.Notify("Stink bait does not work in the ocean!", 'error', 1500)
            else
                isFishing = true
                local animDict = "amb@world_human_stand_fishing@idle_a"
                local animName = "idle_b"
                local playerPed = PlayerPedId()
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(0)
                end
                TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

                Wait(Config.WaitTimeBeforeCatching)

                exports['ps-ui']:Circle(function(success)
                    if success then
                        isFishing = false
                        if math.random(1, 100) <= Config.RareFishChance then
                            TriggerEvent('giverarefish')
                            ClearPedTasks(playerPed)
                            if math.random(1, 100) <= Config.SuccessUseBaitChance then
                                baitSelected = nil
                                QBCore.Functions.Notify("Your bait was consumed!", 'error', 1500)
                                rodInHand = 0
                                DeleteObject(rod)
                            end
                        elseif math.random(1, 100) <= Config.FishChance then
                            TriggerEvent('givefish')
                            ClearPedTasks(playerPed)
                        else
                            QBCore.Functions.Notify("You caught no fish!", 'error', 1500)
                            ClearPedTasks(playerPed)
                        end
                    else
                        isFishing = false
                        QBCore.Functions.Notify("The fish broke off the hook!", 'error', 1500)
                        baitSelected = nil
                        ClearPedTasks(playerPed)
                        rodInHand = 0
                        DeleteObject(rod)
                    end
                end, 8, 40)
            end
        elseif baitSelected == "fly" then
            isFishing = true
            local animDict = "amb@world_human_stand_fishing@idle_a"
            local animName = "idle_b"
            local playerPed = PlayerPedId()
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(0)
            end
            TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

            Wait(Config.WaitTimeBeforeCatching)

            exports['ps-ui']:Circle(function(success)
                if success then
                    isFishing = false
                    if math.random(1, 100) <= Config.RareFishChance then
                        TriggerEvent('giverarefish')
                        ClearPedTasks(playerPed)
                        if math.random(1, 100) <= Config.SuccessUseBaitChance then
                            baitSelected = nil
                            QBCore.Functions.Notify("Your bait was consumed!", 'error', 1500)
                            rodInHand = 0
                            DeleteObject(rod)
                        end
                    elseif math.random(1, 100) <= Config.FishChance then
                        TriggerEvent('givefish')
                        ClearPedTasks(playerPed)
                    else
                        QBCore.Functions.Notify("You caught no fish!", 'error', 1500)
                        ClearPedTasks(playerPed)
                    end
                else
                    isFishing = false
                    QBCore.Functions.Notify("The fish broke off the hook!", 'error', 1500)
                    baitSelected = nil
                    ClearPedTasks(playerPed)
                    rodInHand = 0
                    DeleteObject(rod)
                end
            end, 8, 40)
        elseif baitSelected == "wiggle" then
            isFishing = true
            local animDict = "amb@world_human_stand_fishing@idle_a"
            local animName = "idle_b"
            local playerPed = PlayerPedId()
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(0)
            end
            TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

            Wait(Config.WaitTimeBeforeCatching)

            exports['ps-ui']:Circle(function(success)
                if success then
                    isFishing = false
                    if math.random(1, 100) <= Config.RareFishChance then
                        TriggerEvent('giverarefish')
                        ClearPedTasks(playerPed)
                        if math.random(1, 100) <= Config.SuccessUseBaitChance then
                            baitSelected = nil
                            QBCore.Functions.Notify("Your bait was consumed!", 'error', 1500)
                            rodInHand = 0
                            DeleteObject(rod)
                        end
                    elseif math.random(1, 100) <= Config.FishChance then
                        TriggerEvent('givefish')
                        ClearPedTasks(playerPed)
                    else
                        QBCore.Functions.Notify("You caught no fish!", 'error', 1500)
                        ClearPedTasks(playerPed)
                    end
                else
                    isFishing = false
                    QBCore.Functions.Notify("The fish broke off the hook!", 'error', 1500)
                    baitSelected = nil
                    ClearPedTasks(playerPed)
                    rodInHand = 0
                    DeleteObject(rod)
                end
            end, 8, 40)
        end
    end
end)

RegisterNetEvent('givefish', function(zone)
    if Config.Debug == true then
        print("Regular fish given at location: " .. location.name)
    end
    if location.name == "pier" then
        if baitSelected == "worm" then
            local randomFishPier = math.random(1, #Config.SaltWaterWormBaitFish)
            local randomFish = Config.SaltWaterWormBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "fly" then
            local randomFishPier = math.random(1, #Config.SaltWaterFlyBaitFish)
            local randomFish = Config.SaltWaterFlyBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "stink" then
            local randomFishPier = math.random(1, #Config.SaltWaterStinkBaitFish)
            local randomFish = Config.SaltWaterStinkBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "wiggle" then
            local randomFishPier = math.random(1, #Config.SaltWaterWiggleBaitFish)
            local randomFish = Config.SaltWaterWiggleBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)
        end
    elseif location.name == "vinewoodhillspond" then
        if baitSelected == "worm" then
            local randomFishPier = math.random(1, #Config.FreshWaterWormBaitFish)
            local randomFish = Config.FreshWaterWormBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "fly" then
            local randomFishPier = math.random(1, #Config.FreshWaterFlyBaitFish)
            local randomFish = Config.FreshWaterFlyBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "stink" then
            local randomFishPier = math.random(1, #Config.FreshWaterStinkBaitFish)
            local randomFish = Config.FreshWaterStinkBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "wiggle" then
            local randomFishPier = math.random(1, #Config.FreshWaterWiggleBaitFish)
            local randomFish = Config.FreshWaterWiggleBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)
        end
    end
end)

RegisterNetEvent('giverarefish', function(zone)
    if Config.Debug == true then
        print("Rare fish given at location: " .. location.name)
    end
    if location.name == "pier" or location.name == "alamosea" then
        if baitSelected == "worm" then
            local randomFishPier = math.random(1, #Config.RareSaltWaterWormBaitFish)
            local randomFish = Config.RareSaltWaterWormBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random rare fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "fly" then
            local randomFishPier = math.random(1, #Config.RareSaltWaterFlyBaitFish)
            local randomFish = Config.RareSaltWaterFlyBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random rare fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "stink" then
            local randomFishPier = math.random(1, #Config.RareSaltWaterStinkBaitFish)
            local randomFish = Config.RareSaltWaterStinkBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random rare fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "wiggle" then
            local randomFishPier = math.random(1, #Config.RareSaltWaterWiggleBaitFish)
            local randomFish = Config.RareSaltWaterWiggleBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random rare fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)
        end
    elseif location.name == "vinewoodhillspond" then
        if baitSelected == "worm" then
            local randomFishPier = math.random(1, #Config.RareFreshWaterWormBaitFish)
            local randomFish = Config.RareFreshWaterWormBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random rare fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "fly" then
            local randomFishPier = math.random(1, #Config.RareFreshWaterFlyBaitFish)
            local randomFish = Config.RareFreshWaterFlyBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random rare fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "stink" then
            local randomFishPier = math.random(1, #Config.RareFreshWaterStinkBaitFish)
            local randomFish = Config.RareFreshWaterStinkBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random rare fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)

        elseif baitSelected == "wiggle" then
            local randomFishPier = math.random(1, #Config.RareFreshWaterWiggleBaitFish)
            local randomFish = Config.RareFreshWaterWiggleBaitFish[randomFishPier]
            if Config.Debug == true then
                print("random rare fish: " .. randomFish)
            end
            QBCore.Functions.Notify("You caught a " .. randomFish .. "!", 'success', 1500)
            TriggerServerEvent('givefish', randomFish)
        end
    end
end)

function CheckForWorm()
    QBCore.Functions.TriggerCallback('hasWorm', function(hasWorm)
        if hasWorm then
            TriggerEvent('attachwormbait')
        else
            QBCore.Functions.Notify('You do not have any worm bait!', 'error', 1500)
            DeleteObject(rod)
            rodInHand = 0
        end
    end)
end

function CheckForWiggle()
    QBCore.Functions.TriggerCallback('hasWiggle', function(hasWiggle)
        if hasWiggle then
            TriggerEvent('attachwigglebait')
        else
            QBCore.Functions.Notify('You do not have any wiggle bait!', 'error', 1500)
            DeleteObject(rod)
            rodInHand = 0
        end
    end)
end

function CheckForStink()
    QBCore.Functions.TriggerCallback('hasStink', function(hasStink)
        if hasStink then
            TriggerEvent('attachstinkbait')
        else
            QBCore.Functions.Notify('You do not have any stink bait!', 'error', 1500)
            DeleteObject(rod)
            rodInHand = 0
        end
    end)
end

function CheckForFly()
    QBCore.Functions.TriggerCallback('hasFly', function(hasFly)
        if hasFly then
            TriggerEvent('attachflybait')
        else
            QBCore.Functions.Notify('You do not have any fly bait!', 'error', 1500)
            DeleteObject(rod)
            rodInHand = 0
        end
    end)
end

RegisterKeyMapping('+changebait', 'Change Bait', 'keyboard', 'Y')
RegisterCommand('+changebait', function()
    if rodInHand == 1 and baitSelected ~= nil then
        lib.showMenu('bait_menu')
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        RegisterKeyMapping('+fish', 'Fish', 'keyboard', 'E')
    end
end)
