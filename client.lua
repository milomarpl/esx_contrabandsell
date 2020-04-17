ESX 			    			= nil
local miejscesprzedazy          = { x = 458.2, y = -979.65, z = 30.69 }
local sprzedazzasieg = false --nie zmieniaj, w innym wypadku policjant będzie mógł sprzedać narko wszędzie
local przycisk  = 38 -- E
local jestpolicjantem = false --nie tykaj
local PlayerData	= {} --nie tykaj



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		jestpolicjantem = true
	end
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1000)
        local coords = GetEntityCoords(PlayerPedId())
            if(GetDistanceBetweenCoords(coords, miejscesprzedazy.x, miejscesprzedazy.y, miejscesprzedazy.z, true) < 2.0) then
                sprzedazzasieg = true
                --print('lashayy smierdzi')
            else
                sprzedazzasieg = false
            end
        end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	jestpolicjantem = (job.name == 'police') or false
end)

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
    	local coords      = GetEntityCoords(GetPlayerPed(-1))
			if sprzedazzasieg == true and jestpolicjantem == true then 
                DrawText3D(457.95, -979.08, 30.89, '~g~[E] ~w~Sprzedaj narkotyki', 0.5)
                if IsControlJustReleased(1, przycisk) then
                  TriggerServerEvent('milomarSprzedaz:sprzedajnarko')
                  Citizen.Wait(5000)
              end
            end
        end
end)

RegisterNetEvent('milomarSprzedaz:animacja')
AddEventHandler('milomarSprzedaz:animacja', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(500)
    StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)


