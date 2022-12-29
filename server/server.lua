ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

RegisterServerEvent("maxi_dispatch:sendAlert")
AddEventHandler("maxi_dispatch:sendAlert", function(text, coords, id)
    TriggerClientEvent("maxi_dispatch:alertToClient", -1, text, coords, id)
end)

RegisterServerEvent("maxi_dispatch:sendAmbuAlert")
AddEventHandler("maxi_dispatch:sendAmbuAlert", function(text, coords, id)
    TriggerClientEvent("maxi_dispatch:auxToClient", -1, text, coords, id)
end)

RegisterServerEvent("maxi_dispatch:sendMecaAlert")
AddEventHandler("maxi_dispatch:sendMecaAlert", function(text, coords, id)
    TriggerClientEvent("maxi_dispatch:mecaToClient", -1, text, coords, id)
end)

RegisterServerEvent("maxi_dispatch:sendVehRob")
AddEventHandler("maxi_dispatch:sendVehRob", function(coords, model, color, id)
    TriggerClientEvent("maxi_dispatch:vehToClient", -1, coords, model, color, id)
end)

RegisterServerEvent("maxi_dispatch:sendTaxiaAlert")
AddEventHandler("maxi_dispatch:sendTaxiaAlert", function(text, coords, id)
    TriggerClientEvent("maxi_dispatch:taxiToClient", -1, text, coords, id)
end)

RegisterServerEvent("maxi_dispatch:sendRobaAlert")
AddEventHandler("maxi_dispatch:sendRobaAlert", function(type, coords, id)
    TriggerClientEvent("maxi_dispatch:robberyToClient", -1, type, coords, id)
end)
