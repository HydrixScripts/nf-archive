local QBCore = exports[Config.coreExport]:GetCoreObject()

local function dothisShit()
    for k, v in pairs(Config.BoxZones) do
        exports[Config.targetExport]:AddBoxZone('nawaf-archive-'..v.job..'-'..k, v.coords, v.a, v.b, {
            name = 'nawaf-archive-'..v.job..'-'..k,
            heading = v.heading,
            debugPoly = v.debugPoly,
            minZ = v.minZ,
            maxZ = v.maxZ
        }, {
            options = {
                {
                    event = 'nawaf:client:openArchive',
                    icon = 'fa fa-archive',
                    label = 'Search on files',
                    params = {
                        jobArchive = v.job
                    }
                }
            },
            job = {v.job},
            distance = v.distance
        })
    end
end

local function archiveList(data, job)
    local array = {
        {
            header = 'Police Archive',
            text = 'File #'..tostring(data),
            isMenuHeader = true
        },
        {
            header = 'Open Archive',
            params = {
                event = 'nawaf:client:openArchiveByNumber',
                args = {
                    num = tostring(data),
                    jobArchive = job
                }
            }
        },
        {
            header = 'Change Archive',
            params = {
                event = 'nawaf:client:openArchive',
                args = {
                    menu = true,
                    job = job
                }
            }
        }
    }
    exports['qb-menu']:openMenu(array)
end

local function chooseArchive(job)
    local dialog = exports[Config.inputExport]:ShowInput({
        header = 'Archive Number',
        submitText = 'Submit',
        inputs = {
            {
                text = 'Amount',
                name = 'archive',
                type = 'number',
                isRequired = true
            }
        }
    })
    if not dialog then return false end
    for k, v in pairs(dialog) do
        archiveList(v, job)
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    dothisShit()
end)

AddEventHandler('nawaf:client:openArchive', function(data)
    if not data.menu then
        chooseArchive(data.params.jobArchive)
    else
        chooseArchive(data.job)
    end
end)

AddEventHandler('nawaf:client:openArchiveByNumber', function(data)
    local inventoryName = data.jobArchive..'_archive_'..tostring(data.num)
    local inventoryData = {
        maxWeight = 4000000,
        maxSlots = 300,
        owner = inventoryName
    }
    exports.ox_inventory:openInventory('stash', 'evidence-'..data.num)
    TriggerEvent('ox_inventory:setCurrentStash', data.num)
end)