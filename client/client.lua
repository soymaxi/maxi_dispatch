local calls = {}
local callnum = 0
local totalcalls = 0
local config = false
local showed = false
local PlayerData = {}
local bigrambo = {}
local nofilterquick = {}
local wackytequiero = {}
local activated = true

ESX = nil 

Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
    calls = {}
    callnum = 0
    totalcalls = 0
    SendNUIMessage({
        show = false;
        content = "No alerts";
        callnum = 0;
        totalcalls = 0;
        closeConfigMenu = true;
        newalert = false;
    })
    SetNuiFocus(false, false)
    showed = false
end)

RegisterCommand("alertas", function()
    if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'taxi' then
        if not showed then
            if checkTable(calls) then
                if calls[callnum]['model'] ~= nil then
                    SendNUIMessage({
                        show = true;
                        pic = true;
                        model = calls[callnum]['model'];
                    })
                    showed = true
                else
                    SendNUIMessage({
                        show = true;
                    })
                    showed = true
                end
            else
                SendNUIMessage({
                    show = true;
                })
                showed = true
            end
        else
            SendNUIMessage({
                show = false;
            })
            showed = false
        end
    else
        exports['mythic_notify']:DoHudText('error', 'No podes utilizar esto')
    end
end, false)

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        Citizen.Wait(2000)
        SendNUIMessage({
            callnum = 0;
        })
    end
end)

RegisterNetEvent("maxi_dispatch:alertToClient")
AddEventHandler("maxi_dispatch:alertToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == 'police' and activated then
        callnum = callnum + 1
        totalcalls = totalcalls + 1
        SendNUIMessage({
            content = text;
            callnum = callnum;
            totalcalls = totalcalls;
            newalert = true;
            id = id;
            
        })
        table.insert(calls, {text = text, coords = coords})
    end
end)

RegisterNetEvent("maxi_dispatch:vehToClient")
AddEventHandler("maxi_dispatch:vehToClient", function(coords, model, color, id)
    if PlayerData.job and PlayerData.job.name == 'police' and activated then
        callnum = callnum + 1
        totalcalls = totalcalls + 1
        local distanceToAlert = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords)
        local finalDistanceTo = ESX.Math.Round(ESX.Math.Round(distanceToAlert, 1) * 0.001, 1)
        if Config.enableVehiclePics then
            SendNUIMessage({
                content = "A man has stolen a vehicle model " ..model.. ",color "..color..", I got a photo of the vehicle. You meet " ..finalDistanceTo .. " km away";
                callnum = callnum;
                totalcalls = totalcalls;
                pic = true;
                model = model;
                newalert = true;
                id = id;
            })
            table.insert(calls, {text = "A man has stolen a vehicle model " ..model.. " de color "..color..", I got a photo of the vehicle. You meet " ..finalDistanceTo .. " km away", coords = coords, model = model})
        else
            SendNUIMessage({
                content = "A man has stolen a vehicle model " ..model.. " de color "..color..", I got a photo of the vehicle. You meet " ..finalDistanceTo .. " km away";
                callnum = callnum;
                totalcalls = totalcalls;
                newalert = true;
                id = id;
            })
            table.insert(calls, {text = "A man has stolen a vehicle model " ..model.. " de color "..color..", I got a photo of the vehicle. You meet " ..finalDistanceTo .. " km away", coords = coords})
        end
    end
end)

RegisterCommand("107", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("maxi_dispatch:sendAmbuAlert", text, coords, id)
end, false)

RegisterCommand("0800", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("maxi_dispatch:sendMecaAlert", text, coords, id)
end, false)

RegisterNetEvent("maxi_dispatch:auxToClient")
AddEventHandler("maxi_dispatch:auxToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == 'ambulance' and activated then
        callnum = callnum + 1
        totalcalls = totalcalls + 1
        SendNUIMessage({
            content = text;
            callnum = callnum;
            totalcalls = totalcalls;
            newambualert = true;
            newalert = true;
            id = id;
        })
        table.insert(calls, {text = text, coords = coords})
    end
    
end)
RegisterNetEvent("maxi_dispatch:taxiToClient")
AddEventHandler("maxi_dispatch:taxiToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == 'taxi' and activated then
        callnum = callnum + 1
        totalcalls = totalcalls + 1
        SendNUIMessage({
            content = text;
            callnum = callnum;
            totalcalls = totalcalls;
            newtaxialert = true;
            newalert = true;
            id = id;
        })
        table.insert(calls, {text = text, coords = coords})
    end
    
end)


RegisterNetEvent("maxi_dispatch:mecaToClient")
AddEventHandler("maxi_dispatch:mecaToClient", function(text, coords, id)
    if PlayerData.job and PlayerData.job.name == 'mechanic' and activated then
        callnum = callnum + 1
        totalcalls = totalcalls + 1
        SendNUIMessage({
            content = text;
            callnum = callnum;
            totalcalls = totalcalls;
            newmecaalert = true;
            newalert = true;
            id = id;
        })
        table.insert(calls, {text = text, coords = coords})
    end
    
end)


RegisterNetEvent("maxi_dispatch:robberyToClient")
AddEventHandler("maxi_dispatch:robberyToClient", function(type, coords, id)
    if PlayerData.job and PlayerData.job.name == 'police' and activated then
        callnum = callnum + 1
        totalcalls = totalcalls + 1
        if Config.enableRobberyPics then --------------------- Esto es por si queres activar las imagenes del robo pero no sirve por esta version (>>Proximamente Version 0.2<<)
            if type == "robo" then
                SendNUIMessage({
                    content = "(Sistema de Alarmas). ¡Alarma activada en un robo!.";
                    callnum = callnum;
                    totalcalls = totalcalls;
                    pic = false;
                    model = 247;
                    newalert = true;
                    id = id;

                })
                table.insert(calls, {text = "(Sistema de Alarmas). ¡Alarma activada en un robo!.", coords = coords, model = 247})
            end
        else
            if type == "robo" then
                SendNUIMessage({
                    content = "<span class='parpadea' style='color: red;'>(Sistema de Alarmas).</span> ¡Alarma activada en un robo!. <i class='fa-solid fa-location-dot'></i>";
                    callnum = callnum;
                    totalcalls = totalcalls;
                    newalert = true;
                    id = id;

                })
                table.insert(calls, {text = "(Sistema de Alarmas). ¡Alarma activada en un robo!. <i class='fa-solid fa-location-dot'></i>", coords = coords})
            end
        end
    end
end)

RegisterCommand("911", function(source, args)
    local text = table.concat(args, " ")
    local coords = GetEntityCoords(PlayerPedId())
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("maxi_dispatch:sendAlert", text, coords, id)
end, false)


RegisterCommand("right", function()
    if calls[callnum + 1] ~= nil then
        local num = callnum + 1
        if calls[callnum + 1]['model'] ~= nil then
            SendNUIMessage({
                content = calls[callnum + 1]['text'];
                callnum = num;
                right = true;
                pic = true;
                model = calls[callnum + 1]['model'];
            })
        else
            SendNUIMessage({
                content = calls[callnum + 1]['text'];
                callnum = num;
                right = true;
            })
        end
        callnum = callnum + 1 
    end
end, false)

RegisterCommand("left", function()
    if calls[callnum - 1] ~= nil then
        local num = callnum - 1
        if calls[callnum - 1]['model'] ~= nil then
            SendNUIMessage({
                content = calls[callnum - 1]['text'];
                callnum = num;
                left = true;
                pic = true;
                model = calls[callnum - 1]['model'];
            })
        else
            SendNUIMessage({
                content = calls[callnum - 1]['text'];
                callnum = num;
                left = true;
            })
        end
        callnum = callnum - 1 
    end
end, false)

RegisterCommand("mover", function(source, args)
    if showed then 
        SetNuiFocus(true, true)
        SendNUIMessage({
            inConfig = true;
        })
    end
end, false)

RegisterCommand("acceptentorno", function(source, args)
    if callnum ~= 0 then
        SetNewWaypoint(calls[callnum]['coords'])
        exports['mythic_notify']:DoHudText('success', 'Alerta Marcada en el GPS')
        SendNUIMessage({
            avkey = true;
        })
    end
end, false)

RegisterKeyMapping("mover", ("Configurar Dispatch"), 'keyboard', 'i')

RegisterKeyMapping("right", ("Pasar a la derecha"), 'keyboard', 'right')

RegisterKeyMapping("left", ("Pasar a la izquierad"), 'keyboard', 'left')

RegisterKeyMapping("alertas", ("Alertas"), 'keyboard', 'f4')

RegisterKeyMapping("acceptentorno", ("Got to the marker"), 'keyboard', 'o')

RegisterNUICallback("exit", function()
    SetNuiFocus(false, false)
    if checkTable(calls) then
        if calls[callnum]['model'] == nil then
            SendNUIMessage({
                content = calls[callnum]['text'];
                callnum = num;
            })
        else

            SendNUIMessage({
                content = calls[callnum]['text'];
                callnum = num;
                pic = true;
                model = calls[callnum]['model'];
            })
        end
    else
        if checkTable(calls) then
            SendNUIMessage({
                content = calls[callnum]['text'];
                callnum = num;
            })
        else
            SendNUIMessage({
                content = "No alerts received";
                callnum = num;
            })
        end
    end
end)

RegisterNUICallback("tooglepic", function()
    if Config.enableVehiclePics then
        Config.enableVehiclePics = false
        ESX.ShowNotification('Images have been disabled')
    else
        Config.enableVehiclePics = true
        ESX.ShowNotification('Images have been enabled')
    end
end)

RegisterNUICallback("deletealerts", function()
    callnum = 0
    totalcalls = 0
    calls = {}
    SendNUIMessage({
        content = "No alerts received";
        restart = true;
        newalert = false;
        
    })
    ESX.ShowNotification('All alerts deleted')
end)

RegisterNUICallback("showalerts", function()
    if activated then
        activated = false
        exports['mythic_notify']:DoHudText('success', 'Alertas Activadas')
    else
        activated = true
        exports['mythic_notify']:DoHudText('error', 'Alertas Desactivadas')
    end
end)

RegisterNUICallback("deletealert", function(cb)
    totalcalls = totalcalls - 1
    
    if (cb.selectedId + 1) == callnum then
        if checkTable(calls) then
            if calls[callnum]['model'] ~= nil then
                SendNUIMessage({
                    content = calls[callnum]['text'];
                    callnum = num;
                    totalcalls = totalcalls;
                    pic = true;
                    model = calls[callnum]['model'];
                })
                
            else
                if calls[callnum + 1] ~= nil then
                    SendNUIMessage({
                        content = calls[callnum + 1]['text'];
                        callnum = num;
                        totalcalls = totalcalls;
                    })
                    callnum = callnum + 1
                elseif calls[callnum - 1] ~= nil then
                    local num = callnum - 1
                    SendNUIMessage({
                        content = calls[callnum - 1]['text'];
                        callnum = num;
                        totalcalls = totalcalls;
                    })
                    callnum = callnum - 1
                else

                    callnum = 0
                    totalcalls = 0
                    calls = {}
                    SendNUIMessage({
                        content = "No alerts received";
                        restart = true;
                        newalert = false;
                        
                    })
                end
            end
        end
    else
        callnum = callnum - 1
        SendNUIMessage({
            callnum = callnum;
            totalcalls = totalcalls;
        })
    end
    table.remove(calls, cb.selectedId + 1)
    
end)

function checkTable(table)
    local init = false
    for k,v in pairs(table) do
        inIt = true
    end
    if inIt then
        return true
    else
        return false
    end
end