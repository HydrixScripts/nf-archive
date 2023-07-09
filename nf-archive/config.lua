Config = {}

Config.coreExport = 'qb-core';
Config.inputExport = 'qb-input';
Config.targetExport = 'qb-target';

Config.inventoryTypes = { -- wrap the inventoryTypes table in curly braces
    ['stash'] = {
        label = 'Stash',
        slots = 300,
        weight = 4000000,
        canRemove = function(inventory, slot, count) return true end,
        onOpen = function(inventory)
            TriggerClientEvent('ox_inventory:client:openInventory', inventory.owner, inventory.type, inventory.name, inventory.data)
        end,
        onClose = function(inventory)
            TriggerClientEvent('ox_inventory:client:closeInventory', inventory.owner, inventory.type, inventory.name)
        end
    },
}

Config.BoxZones = {
    {
        coords = vec3(472.59, -991.19, 26.27),
        a = 3.0,
        b = 3.0,
        heading = 272.17,
        debugPoly = false,
        minZ = 23.27,
        maxZ = 27.36,
        job = 'police',
        distance = 5.0
    },
}