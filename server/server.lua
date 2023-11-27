local QBCore = exports['qb-core']:GetCoreObject() 

local Cooldown = false

RegisterServerEvent('lb-robbery:server:startr', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Config.NeedCash then
        if Player.PlayerData.money['cash'] >= Config.RunCost then
            Player.Functions.RemoveMoney('cash', Config.RunCost)
            Player.Functions.AddItem("casekey", 1)
            Player.Functions.RemoveItem(Config.NeedItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "add")
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.NeedItem], "remove")
            TriggerClientEvent("lb-robbery:server:runactivate", src)
            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.you_dont_have_enough_money"), 'error')
        end
    else
        Player.Functions.AddItem("casekey", 1)
        Player.Functions.RemoveItem(Config.NeedItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "add")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.NeedItem], "remove")
        TriggerClientEvent("lb-robbery:server:runactivate", src)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
    end
end)

-- cool down for job
RegisterServerEvent('lb-robbery:server:coolout', function()
    Cooldown = true
    local timer = Config.Cooldown * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

QBCore.Functions.CreateCallback("lb-robbery:server:coolc",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false) 
    end
end)

RegisterServerEvent('lb-robbery:server:unlock', function ()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem("securitycase", 1)
    Player.Functions.RemoveItem("casekey", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["securitycase"], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "remove")
end)

RegisterServerEvent('lb-robbery:server:rewardpayout', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("meth_cured", 20)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth_cured"], "remove")
    

    Player.Functions.AddMoney('cash', Config.Payout)

    local chance = math.random(1, 100)

    if chance >= 85 then
        Player.Functions.AddItem(Config.Item, Config.MethAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Item], "add")
    end

    if chance >= 95 then
        Player.Functions.AddItem(Config.SpecialItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.SpecialItem], "add")
    end
end)

RegisterServerEvent('lb-robbery:server:givecaseitems', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("meth_cured", 20)
    Player.Functions.RemoveItem("securitycase", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth_cured"], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["securitycase"], "remove")
end)
