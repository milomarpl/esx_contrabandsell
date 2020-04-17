ESX 						   = nil
local cenaweed = 25
local cenameta = 25
local cenakoka = 25
local cenaopium = 25



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('milomarSprzedaz:sprzedajnarko')
AddEventHandler('milomarSprzedaz:sprzedajnarko', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local iloscWeed = xPlayer.getInventoryItem('weed').count
	local iloscMeta = xPlayer.getInventoryItem('meth_pooch').count
	local iloscKoka = xPlayer.getInventoryItem('coke_pooch').count
    local iloscOpium = xPlayer.getInventoryItem('opium').count

	if xPlayer.job.name == 'police' then
	if iloscWeed > 0 then
		xPlayer.removeInventoryItem('weed', iloscWeed)
		xPlayer.addMoney(iloscWeed * cenaweed)
		TriggerClientEvent('milomarSprzedaz:animacja', source)
		TriggerClientEvent('esx:showNotification', source, '~g~Sprzedałeś' .. iloscWeed .. ' marihuany')
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Nie masz marihuany')
	end
	if iloscMeta > 0 then
		xPlayer.removeInventoryItem('meth_pooch', iloscMeta)
		xPlayer.addMoney(iloscMeta * cenameta)
		TriggerClientEvent('milomarSprzedaz:animacja', source)
		TriggerClientEvent('esx:showNotification', source, '~g~Sprzedałeś ' .. iloscMeta .. ' paczek metamfetaminy')
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Nie masz paczek metamfetaminy')
	end
	if iloscKoka > 0 then
		xPlayer.removeInventoryItem('coke_pooch', iloscKoka)
		xPlayer.addMoney(iloscKoka * cenakoka)
		TriggerClientEvent('milomarSprzedaz:animacja', source)
		TriggerClientEvent('esx:showNotification', source, '~g~Sprzedałeś ' .. iloscKoka .. ' paczek kokainy')
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Nie masz paczek kokainy')
	end
	if iloscOpium > 0 then
		xPlayer.removeInventoryItem('opium_pooch', iloscKoka)
		xPlayer.addMoney(iloscOpium * cenaopium)
		TriggerClientEvent('milomarSprzedaz:animacja', source)
		TriggerClientEvent('esx:showNotification', source, '~g~Sprzedałeś ' .. iloscOpium .. ' paczek opium')
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Nie masz paczek kokainy')
	end
	if iloscWeed > 0 or iloscMeta > 0 or iloscKoka > 0 or iloscOpium > 0 then
	TriggerEvent('esx_joblogs:AddInLog', 'sprzedawanie', 'sprzedaz', xPlayer.name, iloscWeed, iloscMeta, iloscKoka)
end
end
end)

