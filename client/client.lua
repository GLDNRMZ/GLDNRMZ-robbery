local QBCore = exports['qb-core']:GetCoreObject() 
local VehicleCoords = nil
local CurrentCops = 0

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        StartJobPed()
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    StartJobPed()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

function loadAnimDict(dict) while (not HasAnimDictLoaded(dict)) do RequestAnimDict(dict) Wait(0) end end

-------------
--START PED--
-------------
function StartJobPed()

    if not DoesEntityExist(startboss) then

        RequestModel(Config.StartModel) while not HasModelLoaded(Config.StartModel) do Wait(0) end

        startboss = CreatePed(0, Config.StartModel, Config.StartCoords, false, false)
        
        SetEntityAsMissionEntity(startboss)
        SetPedFleeAttributes(startboss, 0, 0)
        SetBlockingOfNonTemporaryEvents(startboss, true)
        SetEntityInvincible(startboss, true)
        FreezeEntityPosition(startboss, true)
        loadAnimDict("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a")        
        TaskPlayAnim(startboss, "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", 8.0, 1.0, -1, 01, 0, 0, 0, 0)

        exports['qb-target']:AddTargetEntity(startboss, { 
            options = {
                { 
                    type = "client",
                    event = "lb-robbery:client:start",
                    icon = "fas fa-circle",
                    label = "Get Job",
                    item = Config.NeedItem,
                },
            }, 
            distance = 1.5, 
        })
    end
end

--[[CreateThread(function()
    local npc = exports['rep-talkNPC']:CreateNPC({
        npc = 'a_m_y_mexthug_01',
        coords = vector3(-947.07, 329.255, 70.339),
        heading = 271.414,
        name = 'Hector',
        animName = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a",
        animDist = "idle_a",
        startMSG = 'Pssst!!'
    }, {
        {label = "Hey...", value = 1},
        {label = "Maybe.. what kind of job?", value = 2},
        {label = "I'M IN!", value = 3},
        {label = "I'm good, thanks.", value = 4},
    }, function(ped, data, menu)
        Boss = ped -- To delete the ped when the source stops
        if data then
            if data.value == 1 then
                Wait(1000)
                menu.addMessage({msg = "What's up?", from = "npc"})
                Wait(1000)
                menu.addMessage({msg = "Wanna do a job for me?", from = "npc"})
            elseif data.value == 2 then
                Wait(1000)
                menu.addMessage({msg = "Don't worry about it.", from = "npc"})
                Wait(1000)
                menu.addMessage({msg = "You in or out?", from = "npc"})
            elseif data.value == 3 then
                Wait(1000)
                menu.addMessage({msg = "Good. I'll send you the details", from = "npc"})
                Wait(1000)
                TriggerEvent('lb-robbery:client:start')
                menu.close()
            elseif data.value == 4 then
                Wait(1000)
                menu.addMessage({msg = "Bounce then homie!!", from = "npc"})
                Wait(1000)
                menu.close()
            end
        end
    end)
end)--]]

-------------
--Finish PED--
-------------
local finishbossSpawned = false
local finishboss = nil

function FinishJobPed()
    if not DoesEntityExist(finishboss) then
        RequestModel(Config.FinishModel)
        while not HasModelLoaded(Config.FinishModel) do
            Wait(0)
        end

        finishboss = CreatePed(0, Config.FinishModel, Config.FinishCoords, false, false)

        if DoesEntityExist(finishboss) then
            NetworkRegisterEntityAsNetworked(finishboss)
            SetEntityAsMissionEntity(finishboss)
            SetPedFleeAttributes(finishboss, 0, 0)
            SetBlockingOfNonTemporaryEvents(finishboss, true)
            SetEntityInvincible(finishboss, true)
            FreezeEntityPosition(finishboss, false)
            loadAnimDict("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a")
            TaskPlayAnim(finishboss, "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", 8.0, 1.0, -1, 01, 0, 0, 0, 0)

            exports['qb-target']:AddTargetEntity(finishboss, {
                options = {
                    {
                        type = "client",
                        event = "lb-robbery:client:reward",
                        icon = "fas fa-circle",
                        label = "Check Product",
                        item = 'meth_cured',
                    },
                },
                distance = 1.5,
            })

            local blip = AddBlipForEntity(finishboss)
            SetBlipSprite(blip, 457)
            SetBlipColour(blip, 39)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Finish Boss")
            EndTextCommandSetBlipName(blip)
        end
    end
end


-------------
--START JOB--
-------------
RegisterNetEvent('lb-robbery:client:start', function ()
    if CurrentCops >= Config.MinimumMethJobPolice then
        QBCore.Functions.TriggerCallback("lb-robbery:server:coolc",function(isCooldown)
            if not isCooldown then
                TriggerEvent('animations:client:EmoteCommandStart', {"idle11"})
                QBCore.Functions.Progressbar("start_job", Lang:t('info.talking_to_boss'), 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('lb-robbery:server:startr')
                    TriggerServerEvent('lb-robbery:server:coolout')
                end, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.someone_recently_did_this"), 'error')
            end
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.cannot_do_this_right_now"), 'error')
    end
end)

----------
--EMAILS--
----------
function RunStart()
	Citizen.Wait(2000)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
	sender = Lang:t('mailstart.sender'),
	subject = Lang:t('mailstart.subject'),
	message = Lang:t('mailstart.message'),
	})
	Citizen.Wait(3000)
end

function Itemtimemsg()
    Citizen.Wait(2000)

	TriggerServerEvent('qb-phone:server:sendNewMail', {
    sender = Lang:t('mail.sender'),
	subject = Lang:t('mail.subject'),
	message = Lang:t('mail.message'),
	})
    Citizen.Wait(Config.Itemtime)
    TriggerServerEvent('lb-robbery:server:givecaseitems')
    QBCore.Functions.Notify(Lang:t("success.case_has_been_unlocked"), 'success')
end

-------------
--CAR SPAWN--
-------------
RegisterNetEvent('lb-robbery:server:runactivate', function()
    RunStart()

    local VehicleCoords1 = Config.Carspawn1
    RequestModel(`tornado`)
    while not HasModelLoaded(`tornado`) do
        Citizen.Wait(0)
    end
    SetNewWaypoint(VehicleCoords1.x, VehicleCoords1.y)
    ClearAreaOfVehicles(VehicleCoords1.x, VehicleCoords1.y, VehicleCoords1.z, 15.0, false, false, false, false, false)
    local transport1 = CreateVehicle(`tornado`, VehicleCoords1.x, VehicleCoords1.y, VehicleCoords1.z, 293.46, true, true)
    SetVehicleCustomPrimaryColour(transport1, 255, 255, 0)
    SpawnGuards()
    spawncase()
    spawnwood()

    local VehicleCoords2 = Config.Carspawn2
    RequestModel(`voodoo`)
    while not HasModelLoaded(`voodoo`) do
        Citizen.Wait(0)
    end
    ClearAreaOfVehicles(VehicleCoords2.x, VehicleCoords2.y, VehicleCoords2.z, 15.0, false, false, false, false, false)
    local transport2 = CreateVehicle(`voodoo`, VehicleCoords2.x, VehicleCoords2.y, VehicleCoords2.z, 33.298, true, true)
    SetVehicleCustomPrimaryColour(transport2, 128, 0, 128)
end)

---------------
--PROPS SPAWN--
---------------
function spawncase()
    local case = CreateObject(`hei_prop_hei_drug_case`, 99.62, -2196.52, 6.21, true,  true, true)
    CreateObject(case)
    SetEntityHeading(case, 181.07)
    FreezeEntityPosition(case, true)
    SetEntityAsMissionEntity(case)
    case = AddBlipForEntity(case)
    SetBlipSprite(case, 586)
    SetBlipColour(case, 2)
    SetBlipFlashes(case, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Case')
    EndTextCommandSetBlipName(case)
end

CreateThread(function()
    exports['qb-target']:AddTargetModel('hei_prop_hei_drug_case', {
        options = {
            {
                type = 'client',
                event = "lb-robbery:client:items",
                icon = "fas fa-circle",
                label = "Grab Goods",
                item = 'casekey',            
            },
        },
        distance = 2.5
    })
end)

function spawnwood()
    local wood = CreateObject(`prop_woodpile_01b`, 99.55, -2196.97, 5.18, true,  true, true)
    CreateObject(wood)
    SetEntityHeading(wood, 270.12)
    FreezeEntityPosition(wood, true)
end

----------------
--Guards Spawn--
----------------
methguards = {
    ['npcguards'] = {}
}

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function SpawnGuards()
    local ped = PlayerPedId()

    SetPedRelationshipGroupHash(ped, `PLAYER`)
    AddRelationshipGroup('npcguards')

    for k, v in pairs(Config['methguards']['npcguards']) do
        loadModel(v['model'])
        methguards['npcguards'][k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(methguards['npcguards'][k])
        networkID = NetworkGetNetworkIdFromEntity(methguards['npcguards'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetPedRandomComponentVariation(methguards['npcguards'][k], 0)
        SetPedRandomProps(methguards['npcguards'][k])
        SetEntityAsMissionEntity(methguards['npcguards'][k])
        SetEntityVisible(methguards['npcguards'][k], true)
        SetPedRelationshipGroupHash(methguards['npcguards'][k], `npcguards`)
        SetPedAccuracy(methguards['npcguards'][k], 75)
        SetPedArmour(methguards['npcguards'][k], 100)
        SetPedCanSwitchWeapon(methguards['npcguards'][k], true)
        SetPedDropsWeaponsWhenDead(methguards['npcguards'][k], false)
        SetPedFleeAttributes(methguards['npcguards'][k], 0, false)
        GiveWeaponToPed(methguards['npcguards'][k], `WEAPON_PISTOL`, 255, false, false)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(methguards['npcguards'][k], 2.0, 2.0, -1)
        end
    end

    SetRelationshipBetweenGroups(0, `npcguards`, `npcguards`)
    SetRelationshipBetweenGroups(5, `npcguards`, `PLAYER`)
    SetRelationshipBetweenGroups(5, `PLAYER`, `npcguards`)
end

function PoliceAlert()
    if math.random(1,100) >= Config.AlertChance then return end
    exports["ps-dispatch"]:CustomAlert({
        coords = GetEntityCoords(PlayerPedId()),
        message = Lang:t('police.message'),
        dispatchCode = Lang:t('police.code'),
        description = Lang:t('police.bliptitle'),
        radius = 0,
        sprite = 437,
        color = 5,
        scale = 0.75,
        length = 3,
    })
end

-------------
--OPEN CASE--
-------------
RegisterNetEvent('lb-robbery:client:items', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            PoliceAlert()
            exports["memorygame"]:thermiteminigame(1, 3, 2, 20,
            function() -- Success
                TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
                QBCore.Functions.Progressbar("grab_case", Lang:t('info.unlocking_case'), 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                }, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    RemoveBlip(case)
                    TriggerServerEvent('lb-robbery:server:unlock')

                    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
                    local case = GetClosestObjectOfType(playerPedPos, 10.0, `hei_prop_hei_drug_case`, false, false, false)
                    if (IsPedActiveInScenario(PlayerPedId()) == false) then
                    SetEntityAsMissionEntity(case, 1, 1)
                    DeleteEntity(case)
                    QBCore.Functions.Notify(Lang:t("success.you_removed_first_security_case"), 'success')
                    FinishJobPed()
                    SetNewWaypoint(Config.FinishCoords.x, Config.FinishCoords.y)
                    Itemtimemsg() 
                end
                end, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            end,
            function()
                QBCore.Functions.Notify(Lang:t("error.you_failed"), 'error')
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.you_cannot_do_this"), 'error')
        end

    end, "casekey")
end)

----------
--PAYOUT--
----------
RegisterNetEvent('lb-robbery:client:reward', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerEvent('animations:client:EmoteCommandStart', {"suitcase"})
            QBCore.Functions.Progressbar("product_check", Lang:t('info.checking_quality'), 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
            }, {}, {}, function()
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('lb-robbery:server:rewardpayout')

                QBCore.Functions.Notify(Lang:t("success.you_got_paid"), 'success')

                Citizen.CreateThread(function()
                    RemoveBlip(finishboss)
                    TaskGoToCoordAnyMeans(finishboss, -2280.708, 322.311, 174.602, 1.0, 0, 0, 786603, 0xbf800000)
                                    
                    local propHash = GetHashKey("prop_ld_suitcase_01")
                    RequestModel(propHash)
                    while not HasModelLoaded(propHash) do
                        Citizen.Wait(0)
                    end
                
                    local prop = CreateObject(propHash, 0.0, 0.0, 0.0, true, true, false)
                    local boneIndex = GetPedBoneIndex(finishboss, 60309)
                
                    AttachEntityToEntity(prop, finishboss, boneIndex, 0.3323, 0.0079, 0.0, -5.6272, -82.2274, 135.2101, true, true, false, true, 1, true)
                
                    Citizen.Wait(60000)
                    DeleteEntity(prop)
                    DeleteEntity(finishboss)
                    finishbossSpawned = false
                end)
                
                
            end, function()
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.you_cannot_do_this"), 'error')
        end
    end, "meth_cured", 20)
end)
