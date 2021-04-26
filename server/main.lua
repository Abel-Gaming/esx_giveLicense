ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('giveLicense:GetInformation')
AddEventHandler('giveLicense:GetInformation', function(closestPlayer, licenseStatus)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerId = source
    local xPlayerName = xPlayer.getName()
    local yPlayer = ESX.GetPlayerFromId(closestPlayer)
    xPlayer.triggerEvent('giveLicense:ShowLicense', xPlayerId, xPlayerName, licenseStatus)
    yPlayer.triggerEvent('giveLicense:ShowLicense', xPlayerId, xPlayerName, licenseStatus)
end)

RegisterServerEvent('giveLicense:ViewLicense')
AddEventHandler('giveLicense:ViewLicense', function(licenseStatus)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerId = source
    local xPlayerName = xPlayer.getName()
    xPlayer.triggerEvent('giveLicense:ShowLicenseLocal', xPlayerId, xPlayerName, licenseStatus)
end)