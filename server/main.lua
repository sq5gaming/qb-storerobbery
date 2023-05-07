local QBCore = exports['qb-core']:GetCoreObject()
local SafeCodes = {}
local cashA = 60 				--<<how much minimum you can get from a robbery
local cashB = 755				--<< how much maximum you can get from a robbery

CreateThread(function()
    while true do
        SafeCodes = {
            [1] = math.random(1000, 9999),
            [2] = {math.random(1, 149), math.random(500.0, 600.0), math.random(360.0, 400), math.random(600.0, 900.0), math.random(100.0, 400.0)},
            [3] = math.random(1000, 9999),
            [4] = math.random(1000, 9999),
            [5] = math.random(1000, 9999),
            [6] = math.random(1000, 9999),
            [7] = math.random(1000, 9999),
            [8] = math.random(1000, 9999),
            [9] = math.random(1000, 9999),
            [10] = math.random(1000, 9999),
            [11] = math.random(1000, 9999),
            [12] = math.random(1000, 9999),
            [13] = math.random(1000, 9999),
            [14] = {math.random(1, 149), math.random(500.0, 600.0), math.random(360.0, 400), math.random(600.0, 900.0), math.random(100.0, 400.0)},
            [15] = {math.random(1, 149), math.random(500.0, 600.0), math.random(360.0, 400), math.random(600.0, 900.0), math.random(100.0, 400.0)},
        }
        Wait((1000 * 60) * 40)
    end
end)

RegisterNetEvent('qb-storerobbery:server:takeMoney', function(register, isDone)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    if #(playerCoords - Config.Registers[register][1].xyz) > 3.0 or (not Config.Registers[register].robbed and not isDone) or (Config.Registers[register].time <= 0 and not isDone) then
        return DropPlayer(src, "Attempted exploit abuse")
    end

    -- Add any additional code you want above this comment to do whilst robbing a register, everything above the if statement under this will be triggered every 2 seconds when a register is getting robbed.

    if isDone then
        local bags = math.random(1,3)
        local info = {
            worth = math.random(cashA, cashB)
        }
        payment = math.random(3) * (math.random(cashA, cashB))

        Player.Functions.AddMoney('cash', payment)
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('text.stolen_amount', {value = payment}))

        --print(tostring(Config.Registers[register].safeKey))

        if math.random(1, 100) <= 10 then
          if Config.Registers[register].safeKey ~= nil then
            local code = SafeCodes[Config.Registers[register].safeKey]
            if Config.Safes[Config.Registers[register].safeKey].type == "keypad" then
                info = {
                  label = Lang:t("text.safe_code")..tostring(code)
                }
                --print(tostring(Config.Registers[register].safeKey).." < assigned safe | code > "..tostring(code))
            else
                info = {
                    label = Lang:t("text.safe_code")..tostring(math.floor((code[1] % 360) / 3.60)).."-"..tostring(math.floor((code[2] % 360) / 3.60)).."-"..tostring(math.floor((code[3] % 360) / 3.60)).."-"..tostring(math.floor((code[4] % 360) / 3.60)).."-"..tostring(math.floor((code[5] % 360) / 3.60))
                }
            end
            Player.Functions.AddItem("stickynote", 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["stickynote"], "add")
          end
        --end
    end
end)

RegisterNetEvent('qb-storerobbery:server:setRegisterStatus', function(register)
    Config.Registers[register].robbed = true
    Config.Registers[register].time = Config.resetTime
    TriggerClientEvent('qb-storerobbery:client:setRegisterStatus', -1, register, Config.Registers[register])
end)

RegisterNetEvent('qb-storerobbery:server:setSafeStatus', function(safe)
    Config.Safes[safe].robbed = true
    TriggerClientEvent('qb-storerobbery:client:setSafeStatus', -1, safe, true)

    SetTimeout(math.random(40, 80) * (60 * 1000), function()
        Config.Safes[safe].robbed = false
        TriggerClientEvent('qb-storerobbery:client:setSafeStatus', -1, safe, false)
    end)
end)

RegisterNetEvent('qb-storerobbery:server:SafeReward', function(safe)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    if #(playerCoords - Config.Safes[safe][1].xyz) > 3.0 or Config.Safes[safe].robbed then
        return DropPlayer(src, "Attempted exploit abuse")
    end

	payment = math.random(3) * (math.random(cashA, cashB))

  Player.Functions.AddMoney('cash', payment)
  TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('text.stolen_amount', {value = payment}))
	--Player.Functions.AddItem('markedbills', bags, false, info)
	--TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")

    local luck = math.random(1, 100)
    local odd = math.random(1, 100)
    if luck <= 10 then
        Player.Functions.AddItem("rolex", math.random(3, 7))
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["rolex"], "add")
        if luck == odd then
            Wait(500)
            Player.Functions.AddItem("goldbar", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["goldbar"], "add")
        end
    end
end)

RegisterNetEvent('qb-storerobbery:server:callCops', function(type, safe, streetLabel, coords)
    local alertData = {
        title = "Store robbery",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = Lang:t("notification.someone_is_trying_to_rob_a_store",{street = streetLabel})
    }
    TriggerClientEvent("qb-storerobbery:client:robberyCall", -1, type, safe, streetLabel, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterNetEvent('qb-storerobbery:server:removeAdvancedLockpick', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return end

    Player.Functions.RemoveItem('advancedlockpick', 1)
end)

RegisterNetEvent('qb-storerobbery:server:removeLockpick', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return end

    Player.Functions.RemoveItem('lockpick', 1)
end)

CreateThread(function()
    while true do
        local toSend = {}
        for k in ipairs(Config.Registers) do

            if Config.Registers[k].time > 0 and (Config.Registers[k].time - Config.tickInterval) >= 0 then
                Config.Registers[k].time = Config.Registers[k].time - Config.tickInterval
            else
                if Config.Registers[k].robbed then
                    Config.Registers[k].time = 0
                    Config.Registers[k].robbed = false
                    toSend[#toSend+1] = Config.Registers[k]
                end
            end
        end

        if #toSend > 0 then
            --The false on the end of this is redundant
            TriggerClientEvent('qb-storerobbery:client:setRegisterStatus', -1, toSend, false)
        end

        Wait(Config.tickInterval)
    end
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:isCombinationRight', function(_, cb, safe)
    cb(SafeCodes[safe])
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getPadlockCombination', function(_, cb, safe)
    cb(SafeCodes[safe])
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getRegisterStatus', function(_, cb)
    cb(Config.Registers)
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getSafeStatus', function(_, cb)
    cb(Config.Safes)
end)
