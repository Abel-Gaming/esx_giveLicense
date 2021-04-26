ESX              = nil
local setLicenseStatus = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/give-license', 'Give license to closest player', {
		{ name="License Status", help="EX- Valid, Invalid, Suspended" }
	})
	TriggerEvent('chat:addSuggestion', '/view-license', 'View your license as it appears to others', {
		{ name="License Status", help="EX- Valid, Invalid, Suspended" }
	})
end)

-- Commands
RegisterCommand("give-license", function(source, args)
	local status = args[1]
	local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestPlayerDistance > 3.0 then
    	ESX.ShowNotification('There\'s no player near you to give your license to!')
	else
    	TriggerServerEvent('giveLicense:GetInformation', closestPlayer, status)
	end
end, false)

RegisterCommand("view-license", function(source, args)
	local status = args[1]
	TriggerServerEvent('giveLicense:ViewLicense', status)
end, false)

-- Events
RegisterNetEvent('giveLicense:ShowLicense')
AddEventHandler('giveLicense:ShowLicense', function(driverId, driverName, driverStatus)
	notification(driverId, driverName, driverStatus)
end)

RegisterNetEvent('giveLicense:ShowLicenseLocal')
AddEventHandler('giveLicense:ShowLicenseLocal', function(driverId, driverName, driverStatus)
	notification(driverId, driverName, driverStatus)
end)

-- Functions
function notification(driverId, driverName, driverStatus)
	local playerIdx = GetPlayerFromServerId(driverId)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(playerIdx))
    ESX.ShowAdvancedNotification('Driver License', '~b~' .. driverName, 'Status: ' .. driverStatus, mugshotStr, 1)
    UnregisterPedheadshot(mugshot)
end