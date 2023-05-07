-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

local currentRegister = 0
local currentSafe = 0
local copsCalled = false
local currentCops = 0
local PlayerJob = {}
local usingAdvanced = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  PlayerData = nil
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
  PlayerData = val
end)

CreateThread(function()
    while true do
        Wait(1000 * 60 * 5)
        if copsCalled then
            copsCalled = false
        end
    end
end)

CreateThread(function()
    Wait(1000)
    setupRegister()
    setupSafes()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        for k in pairs(Config.Registers) do
            local dist = #(pos - Config.Registers[k][1].xyz)
            if dist <= 1 and Config.Registers[k].robbed then
                inRange = true
                DrawText3Ds(Config.Registers[k][1].xyz, Lang:t("text.the_cash_register_is_empty"))
            end
        end
        if not inRange then
            Wait(2000)
        end
        Wait(3)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        local inRange = false
        if QBCore ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            for safe,_ in pairs(Config.Safes) do
                local dist = #(pos - Config.Safes[safe][1].xyz)
                if dist < 3 then
                    inRange = true
                    if dist < 1.0 then
                        if not Config.Safes[safe].robbed then
                            DrawText3Ds(Config.Safes[safe][1].xyz, Lang:t("text.try_combination"))
                            if IsControlJustPressed(0, 38) then
                              -- Job check
                              if PlayerData.job.type == "leo" or PlayerData.job.type == "fire" then
                                QBCore.Functions.Notify(Lang:t("error.job_check"), "error")
                              else
                                if currentCops >= Config.MinimumStoreRobberyPolice then
                                    currentSafe = safe
                                    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                    end
                                    if math.random(100) <= 50 then
                                        TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                                    end
                                    if Config.Safes[safe].type == "keypad" then
                                        SendNUIMessage({
                                            action = "openKeypad",
                                        })
                                        SetNuiFocus(true, true)
                                    else
                                        QBCore.Functions.TriggerCallback('qb-storerobbery:server:getPadlockCombination', function(combination)
                                            TriggerEvent("SafeCracker:StartMinigame", combination)
                                        end, safe)
                                    end

                                    if not copsCalled then
                                        pos = GetEntityCoords(PlayerPedId())
                                        TriggerServerEvent("qb-storerobbery:server:callCops", pos)
                                        copsCalled = true
                                    end
                                else
                                    QBCore.Functions.Notify(Lang:t("error.minimum_store_robbery_police", { MinimumStoreRobberyPolice = Config.MinimumStoreRobberyPolice}), "error")
                                end
                              end
                            end
                        else
                            DrawText3Ds(Config.Safes[safe][1].xyz, Lang:t("text.safe_opened"))
                        end
                    end
                end
            end
        end

        if not inRange then
            Wait(2000)
        end
    end
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    currentCops = amount
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
  -- Job check
  if PlayerData.job.type == "leo" or PlayerData.job.type == "fire" then
    QBCore.Functions.Notify(Lang:t("error.job_check"), "error")
  else
    usingAdvanced = isAdvanced
    for k in pairs(Config.Registers) do
      local ped = PlayerPedId()
      local pos = GetEntityCoords(ped)
      local dist = #(pos - Config.Registers[k][1].xyz)
      if dist <= 1 and not Config.Registers[k].robbed then
        if currentCops >= Config.MinimumStoreRobberyPolice then
          if usingAdvanced then lockpick(true) currentRegister = k else lockpick(true) currentRegister = k end
          if not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
          end
          if not copsCalled then
            TriggerServerEvent("qb-storerobbery:server:callCops", pos)
            copsCalled = true
          end
        else
          QBCore.Functions.Notify(Lang:t("error.minimum_store_robbery_police", { MinimumStoreRobberyPolice = Config.MinimumStoreRobberyPolice}), "error")
        end
      end
    end
  end
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true

    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

function setupRegister()
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getRegisterStatus', function(Registers)
        for k in pairs(Registers) do
            Config.Registers[k].robbed = Registers[k].robbed
        end
    end)
end

function setupSafes()
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:getSafeStatus', function(Safes)
        for k in pairs(Safes) do
            Config.Safes[k].robbed = Safes[k].robbed
        end
    end)
end

DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function lockpick(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    SetCursorLocation(0.5, 0.2)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(100)
    end
end

function takeAnim()
    local ped = PlayerPedId()
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Wait(100)
    end
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end

local openingDoor = false

RegisterNUICallback('success', function(_, cb)
    if currentRegister ~= 0 then
        lockpick(false)
        TriggerServerEvent('qb-storerobbery:server:setRegisterStatus', currentRegister)
        local lockpickTime = 25000
        LockpickDoorAnim(lockpickTime)
        QBCore.Functions.Progressbar("search_register", Lang:t("text.emptying_the_register"), lockpickTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "veh@break_in@0h@p_m_one@",
            anim = "low_force_entry_ds",
            flags = 16,
        }, {}, {}, function() -- Done
            openingDoor = false
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('qb-storerobbery:server:takeMoney', currentRegister, true)
        end, function() -- Cancel
            openingDoor = false
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify(Lang:t("error.process_canceled"), "error")
            currentRegister = 0
        end)
        CreateThread(function()
            while openingDoor do
                TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                Wait(10000)
            end
        end)
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
    cb('ok')
end)

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            TriggerServerEvent('qb-storerobbery:server:takeMoney', currentRegister, false)
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
        currentRegister = 0
    end)
end

RegisterNUICallback('callcops', function(_, cb)
    TriggerEvent("police:SetCopAlert")
    cb('ok')
end)

RegisterNetEvent('SafeCracker:EndMinigame', function(won)
    if currentSafe ~= 0 then
        if won then
            if currentSafe ~= 0 then
                if not Config.Safes[currentSafe].robbed then
                    SetNuiFocus(false, false)
                    TriggerServerEvent("qb-storerobbery:server:SafeReward", currentSafe)
                    TriggerServerEvent("qb-storerobbery:server:setSafeStatus", currentSafe)
                    currentSafe = 0
                    takeAnim()
                end
            else
                SendNUIMessage({
                    action = "kekw",
                })
            end
        end
    end
    copsCalled = false
end)

RegisterNUICallback('PadLockSuccess', function(_, cb)
    if currentSafe ~= 0 then
        if not Config.Safes[currentSafe].robbed then
            SendNUIMessage({
                action = "kekw",
            })
        end
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
    cb('ok')
end)

RegisterNUICallback('PadLockClose', function(_, cb)
    SetNuiFocus(false, false)
    --copsCalled = false
    cb('ok')
end)

RegisterNUICallback("CombinationFail", function(_, cb)
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    cb("ok")
end)

RegisterNUICallback('fail', function(_ ,cb)
    if usingAdvanced then
        if math.random(1, 100) < 20 then
            TriggerServerEvent("qb-storerobbery:server:removeAdvancedLockpick")
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["advancedlockpick"], "remove")
        end
    else
        if math.random(1, 100) < 40 then
            TriggerServerEvent("qb-storerobbery:server:removeLockpick")
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick"], "remove")
        end
    end
    if (IsWearingHandshoes() and math.random(1, 100) <= 25) then
        local pos = GetEntityCoords(PlayerPedId())
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        QBCore.Functions.Notify(Lang:t("error.you_broke_the_lock_pick"))
    end
    lockpick(false)
    cb('ok')
end)

RegisterNUICallback('exit', function(_, cb)
    lockpick(false)
    cb('ok')
end)

RegisterNUICallback('TryCombination', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-storerobbery:server:isCombinationRight', function(combination)
        if tonumber(data.combination) ~= nil then
            if tonumber(data.combination) == combination then
                TriggerServerEvent("qb-storerobbery:server:SafeReward", currentSafe)
                TriggerServerEvent("qb-storerobbery:server:setSafeStatus", currentSafe)
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = false,
                })
                currentSafe = 0
                takeAnim()
            else
                TriggerEvent("police:SetCopAlert")
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = true,
                })
                currentSafe = 0
            end
        end
        cb('ok')
    end, currentSafe)
end)

RegisterNetEvent('qb-storerobbery:client:setRegisterStatus', function(batch, val)
    -- Has to be a better way maybe like adding a unique id to identify the register
    if(type(batch) ~= "table") then
        Config.Registers[batch] = val
    else
        for k in pairs(batch) do
            Config.Registers[k] = batch[k]
        end
    end
end)

RegisterNetEvent('qb-storerobbery:client:setSafeStatus', function(safe, bool)
    Config.Safes[safe].robbed = bool
end)

RegisterNetEvent('qb-storerobbery:client:robberyCall', function(coords)
  if PlayerData.job.type == "leo" then
    local address = exports['sq5-hud']:GetPostalAddress(coords, 1)
    PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    TriggerServerEvent('police:client:policeAlert', coords, Lang:t("notification.storerobbery_progress"))
    QBCore.Functions.Notify(Lang:t("notification.someone_is_trying_to_rob_a_store", {street = address}), 'police', 8000)

    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
    local blipText = Lang:t('notification.store_robbery')
    SetBlipSprite(blip, 60)
    SetBlipSprite(blip2, 161)
    SetBlipColour(blip, 1)
    SetBlipColour(blip2, 1)
    SetBlipDisplay(blip, 4)
    SetBlipDisplay(blip2, 8)
    SetBlipAlpha(blip, transG)
    SetBlipAlpha(blip2, transG)
    SetBlipScale(blip, 0.8)
    SetBlipScale(blip2, 2.0)
    SetBlipAsShortRange(blip, false)
    SetBlipAsShortRange(blip2, false)
    PulseBlip(blip2)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Lang:t('notification.store_robbery'))
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
      Wait(180 * 4)
      transG = transG - 1
      SetBlipAlpha(blip, transG)
      SetBlipAlpha(blip2, transG)
      if transG == 0 then
        RemoveBlip(blip)
        return
      end
    end
  end
end)
