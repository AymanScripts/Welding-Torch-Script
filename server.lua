
local QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('hackcar:reduceDurability', function(source, vehicle)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local weldingtorch = exports.ox_inventory:Search(source, 'slots', 'welding_torch')
        local divinggear = exports.ox_inventory:Search(source, 'slots', 'welding_gas')

        if weldingtorch[1] then
            local currentDurability = weldingtorch[1].metadata.durability or 100
            local newDurability = currentDurability - 10

            if newDurability > 0 then
                exports.ox_inventory:SetDurability(source, weldingtorch[1].slot, newDurability)
            else
                exports.ox_inventory:RemoveItem(source, 'welding_torch', 1, nil, weldingtorch[1].slot)
            end
        end

        if divinggear[1] then
            local currentDurability = divinggear[1].metadata.durability or 100
            local newDurability = currentDurability - 20

            if newDurability > 0 then
                exports.ox_inventory:SetDurability(source, divinggear[1].slot, newDurability)
            else
                exports.ox_inventory:RemoveItem(source, 'welding_gas', 1, nil, divinggear[1].slot)
            end
        end
    end
end)