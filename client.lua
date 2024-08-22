


AddEventHandler('onApproachVehicle', function(vehicle)
    addUnlockCarTarget(vehicle)
end)


CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local vehicle = GetVehicleInDirection(playerPed)

        if vehicle then
            local lockStatus = GetVehicleDoorLockStatus(vehicle)
            if lockStatus > 1 then 
                addUnlockCarTarget(vehicle)
            else 
                exports.ox_target:removeLocalEntity(vehicle)
            end
        end

        Wait(1000) 
    end
end)

local QBCore = exports['qb-core']:GetCoreObject()


local function GetVehicleInDirection(playerPed)
    local coordFrom = GetEntityCoords(playerPed, 1)
    local coordTo = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    local rayHandle = StartShapeTestRay(coordFrom, coordTo, 10, playerPed, 0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end


local function unlockcar(vehicle)
    local playerPed = PlayerPedId()
    local weldingtorch = exports.ox_inventory:Search('slots', 'welding_torch')
    local divinggear = exports.ox_inventory:Search('slots', 'welding_gas')

    if IsPedSittingInAnyVehicle(playerPed) then
        lib.notify({
            title = 'Er zit iemand in het voertuig',
            type = 'error'
        })
        return
    end

    if weldingtorch[1] and divinggear[1] and DoesEntityExist(vehicle) then
        
        local propModel = GetHashKey('prop_weld_torch')
        RequestModel(propModel)
        while not HasModelLoaded(propModel) do
            Wait(10)
        end

        local prop = CreateObject(propModel, 0, 0, 0, true, true, true)
        AttachEntityToEntity(
            prop,
            playerPed,
            GetPedBoneIndex(playerPed, 57005),
            0.1, 0.02, -0.02, 
            -90.0, 0.0, 0.0,
            true, true, false, true, 1, true
        )

       
        local sparkEffect = "core"
        local particleName = "ent_sht_weld_sparks"
        UseParticleFxAssetNextCall(sparkEffect)
        local particleFx = StartParticleFxLoopedOnEntity(
            particleName,
            prop,
            0.0, 0.0, 0.0, 
            0.0, 0.0, 0.0, 
            1.0,
            false, false, false
        )

        
        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
        local success = lib.progressBar({
            duration = 10000,
            label = 'Voertuig aan het ontgrendelen',
            useWhileDead = false,
            canCancel = true,
            disable = {car = true, move = true, combat = true},
        })

       
        StopParticleFxLooped(particleFx, false)
        ClearPedTasksImmediately(playerPed)
        DeleteObject(prop)
        SetModelAsNoLongerNeeded(propModel)

        if success then
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            lib.notify({
                title = 'Voertuig succesvol ontgrendeld!',
                type = 'success'
            })

            
            lib.callback('hackcar:reduceDurability', false, function() end, vehicle)

           
            exports.ox_target:removeLocalEntity(vehicle)
        else
            lib.notify({
                title = 'Ontgrendeling geannuleerd!',
                type = 'inform'
            })
        end
    else
        lib.notify({
            title = 'Je hebt zowel een lasapparaat als duikuitrusting nodig of je bent te ver van de auto verwijderd',
            type = 'error'
        })
    end
end


local function addUnlockCarTarget(vehicle)
   
    if DoesEntityExist(vehicle) and GetVehicleDoorLockStatus(vehicle) > 1 then
        exports.ox_target:addLocalEntity(vehicle, {
            {
                name = 'unlockcar',
                label = 'Ontgrendel Voertuig',
                icon = 'wrench',
                items = { 'welding_torch', 'welding_gas' }, 
                distance = 2.5,
                onSelect = function(data)
                    unlockcar(data.entity)
                end
            }
        })
    end
end


AddEventHandler('onApproachVehicle', function(vehicle)
    addUnlockCarTarget(vehicle)
end)
