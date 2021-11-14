ESX              = nil
local playerAlreadyConnected = false
local ConnectedHydrantID = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
end)

-- Check the distance from the connected hydrant
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end

	while true do
		Citizen.Wait(1)
		if playerAlreadyConnected then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local hydrantCoords = GetEntityCoords(ConnectedHydrantID)
			if #(playerCoords - hydrantCoords) >= Config.MaxDistance then
				-- Show Notification
				ESX.ShowNotification('~y~[WARNING]~w~ You have been auto-disconnected from the hydrant due to distance')
				
				-- Print to log
				if Config.EnableDebug then
					print('Disconnected from hydrant ID: ' .. ConnectedHydrantID)
				end
				
				-- Toggle hose
				TriggerEvent('dubCase-HoseFix:Toggle')
				
				-- Update information
				playerAlreadyConnected = false
				ConnectedHydrantID = nil
			end
		end
	end
end)

-- Give the option to disconnect from hydrant
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end

	while true do
		Citizen.Wait(1)
		if playerAlreadyConnected then
			while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ConnectedHydrantID)) <= 2.0 do
				Citizen.Wait(0)
				if playerAlreadyConnected then
					ESX.Game.Utils.DrawText3D(GetEntityCoords(ConnectedHydrantID) + 1, "Press ~y~[E]~s~ to disconnect from hydrant")
					if IsControlJustReleased(0, 51) then
						-- Toggle Hose
						TriggerEvent('dubCase-HoseFix:Toggle')

						-- Update information
						playerAlreadyConnected = false
						ConnectedHydrantID = nil

						-- Show notification
						ESX.ShowNotification('~g~[SUCCESS]~w~ You have disconnected from the hydrant')
					end
				end
			end
		end
	end
end)

RegisterNetEvent('esx_FireHydrant:Connect')
AddEventHandler('esx_FireHydrant:Connect', function()
	if playerAlreadyConnected then
		ESX.ShowNotification('~r~[ERROR]~w~ You are already connected to a hydrant!')
	else
		-- Get the hydrant object
		local hydrant = ESX.Game.GetClosestObject(GetEntityCoords(PlayerPedId()))
	
		-- Get the hydrant model
		local hydrantModel = GetEntityModel(hydrant)

		-- Get the network ID from the hydrant
		local hydrantNetworkID = NetworkGetNetworkIdFromEntity(hydrant)

		-- Print debug
		if Config.EnableDebug then
			print('Connected to hydrant ID: ' .. hydrantNetworkID)
			local hydrantCoords = GetEntityCoords(hydrantNetworkID)
			print('Coords: ' .. hydrantCoords)
		end

		-- Set our bool for the player having a connection
		playerAlreadyConnected = true
		ConnectedHydrantID = hydrantNetworkID

		-- Show notification
		ESX.ShowNotification('~g~[SUCCESS]~w~ You have connected to the hydrant')

		-- Toggle the event
		TriggerEvent('dubCase-HoseFix:Toggle')
	end
end)