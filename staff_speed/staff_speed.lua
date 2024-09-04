-- staff_speed.lua
-- Created by Purpsyrz

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Configuration
local STAFF_GROUPS = { 'admin', 'mod', 'superadmin' } -- Add your staff groups here
local SPEED_MULTIPLIER = 1.5 -- Adjust the multiplier for speed here

-- Register a command for staff to toggle speed
RegisterCommand('togglespeed', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer and isStaff(xPlayer.getGroup()) then
        local playerPed = GetPlayerPed(source)
        local currentSpeed = GetRunSpeed(playerPed)
        
        if currentSpeed == 1.0 then
            SetRunSpeed(playerPed, SPEED_MULTIPLIER)
            TriggerClientEvent('esx:showNotification', source, 'Speed boost activated.')
        else
            SetRunSpeed(playerPed, 1.0)
            TriggerClientEvent('esx:showNotification', source, 'Speed boost deactivated.')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'You do not have permission to use this command.')
    end
end, false)

function isStaff(group)
    for _, staffGroup in ipairs(STAFF_GROUPS) do
        if group == staffGroup then
            return true
        end
    end
    return false
end

function GetRunSpeed(playerPed)
    return GetPedConfigFlag(playerPed, 32, true) and SPEED_MULTIPLIER or 1.0
end

function SetRunSpeed(playerPed, speedMultiplier)
    SetPedConfigFlag(playerPed, 32, true)
    SetRunSprintMultiplierForPlayer(playerPed, speedMultiplier)
end
