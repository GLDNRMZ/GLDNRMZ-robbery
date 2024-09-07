local QBCore = exports['qb-core']:GetCoreObject() 
local Cooldown = false

RegisterServerEvent('GLDNRMZ-robbery:server:startr', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Config.NeedCash then
        if Player.PlayerData.money['cash'] >= Config.RunCost then
            Player.Functions.RemoveMoney('cash', Config.RunCost)
            Player.Functions.AddItem("casekey", 1)
            
            if Config.RemoveItem then
                Player.Functions.RemoveItem(Config.NeedItem, 1)
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[Config.NeedItem], "remove")
            end

            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "add")
            TriggerClientEvent("GLDNRMZ-robbery:server:runactivate", src)
            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.you_dont_have_enough_money"), 'error')
        end
    else
        Player.Functions.AddItem("casekey", 1)
        
        if Config.RemoveItem then
            Player.Functions.RemoveItem(Config.NeedItem, 1)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[Config.NeedItem], "remove")
        end

        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "add")
        TriggerClientEvent("GLDNRMZ-robbery:server:runactivate", src)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
    end
end)

RegisterServerEvent('GLDNRMZ-robbery:server:coolout', function()
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

QBCore.Functions.CreateCallback("GLDNRMZ-robbery:server:coolc", function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false) 
    end
end)

RegisterServerEvent('GLDNRMZ-robbery:server:unlock', function ()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem("securitycase", 1)
    Player.Functions.RemoveItem("casekey", 1)
    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items["securitycase"], "add")
    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "remove")
end)

RegisterServerEvent('GLDNRMZ-robbery:server:rewardpayout', function ()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("securitycase", 1)
    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items["securitycase"], "remove")
    
    Player.Functions.AddMoney('cash', Config.Payout)

    local methChance = math.random(1, 100)
    if methChance <= Config.ItemChance then
        Player.Functions.AddItem(Config.Item, Config.ItemAmount)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Item], "add")
    end

    local specialChance = math.random(1, 100)
    if specialChance <= Config.SpecialItemChance then
        Player.Functions.AddItem(Config.SpecialItem, Config.SpecialItemAmount)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[Config.SpecialItem], "add")
    end
end)
