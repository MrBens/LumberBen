ESX = nil

PlayersHarvesting  = {}
PlayersCrafting    = {}
PlayersCrafting2    = {}
PlayersReselling   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'lumberjack', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'lumberjack', _U('lumberjack_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'lumberjack', 'Bûcheron', 'society_lumberjack', 'society_lumberjack', 'society_lumberjack', {type = 'private'})

RegisterServerEvent('esx_lumberjackjob:washMoney')
AddEventHandler('esx_lumberjackjob:washMoney', function(amount)
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')
	local _percent		= Config.Percentage

	if amount > 0 and account.money >= amount then

		local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
		local washedMoney = math.floor(amount / 100 * (_percent + bonus))

		xPlayer.removeAccountMoney('black_money', amount)
		xPlayer.addMoney(washedMoney)

		TriggerClientEvent("esx_lumberjackjob:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('cash') .. washedMoney .. _U('cash1'))

	else
		TriggerClientEvent("esx_lumberjackjob:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('invalid_amount'))
	end

end)

RegisterServerEvent('esx_lumberjackjob:getStockItem')
AddEventHandler('esx_lumberjackjob:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lumberjack', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_lumberjackjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lumberjack', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_lumberjackjob:putStockItems')
AddEventHandler('esx_lumberjackjob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lumberjack', function(inventory)

    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_lumberjackjob:getVaultWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_lumberjack', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_lumberjackjob:addVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_lumberjack', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_lumberjackjob:removeVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_lumberjack', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

------------------------------------------
-------------- Récolte Bois -------------
local function Harvest(source)

	SetTimeout(4000, function()

		if PlayersHarvesting[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)
			local WoodQuantity = xPlayer.getInventoryItem('wood').count

			if WoodQuantity >= 20 then
				TriggerClientEvent('esx:showNotification', source, '~r~Vous ne pouvez pas porter plus de bois')
			else
                xPlayer.addInventoryItem('wood', 1)

				Harvest(source)
			end
		end
	end)
end

RegisterServerEvent('esx_lumberjackjob:startHarvest')
AddEventHandler('esx_lumberjackjob:startHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Récolte de ~b~Bois~s~...')
	Harvest(source)
end)

RegisterServerEvent('esx_lumberjackjob:stopHarvest')
AddEventHandler('esx_lumberjackjob:stopHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = false
end)

----------------- 		Craft Bois Coupé		-------------------------------------
local function Craft(source)

	SetTimeout(5000, function()

		if PlayersCrafting[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)
			local WoodQuantity = xPlayer.getInventoryItem('wood').count
			local CuttedWoodQuantity = xPlayer.getInventoryItem('cutted_wood').count
            if WoodQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de Bois')
			elseif CuttedWoodQuantity >= 20 then
				TriggerClientEvent('esx:showNotification', source, 'Vous ne ~r~pouvez pas~s~ porter plus de Bois coupé')
			else
                xPlayer.removeInventoryItem('wood', 1)
                xPlayer.addInventoryItem('cutted_wood', 1)

				Craft(source)
			end
		end
	end)
end

RegisterServerEvent('esx_lumberjackjob:startCraft')
AddEventHandler('esx_lumberjackjob:startCraft', function()
	local _source = source
	PlayersCrafting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Fabrication de ~b~Bois coupé~s~...')
	Craft(_source)
end)

RegisterServerEvent('esx_lumberjackjob:stopCraft')
AddEventHandler('esx_lumberjackjob:stopCraft', function()
	local _source = source
	PlayersCrafting[_source] = false
end)

----------------- 		Craft Paquet de Planches		-------------------------------------
local function Craft2(source)

	SetTimeout(5000, function()

		if PlayersCrafting2[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)
			local CuttedWoodQuantity = xPlayer.getInventoryItem('cutted_wood').count
			local PackagedPlankQuantity = xPlayer.getInventoryItem('packaged_plank').count
            if CuttedWoodQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de Bois coupé')
			elseif PackagedPlankQuantity >= 20 then
				TriggerClientEvent('esx:showNotification', source, 'Vous ne ~r~pouvez pas~s~ porter plus de Paquets de planches')			
			else
                xPlayer.removeInventoryItem('cutted_wood', 1)
                xPlayer.addInventoryItem('packaged_plank', 1)

				Craft2(source)
			end
		end
	end)
end

RegisterServerEvent('esx_lumberjackjob:startCraft2')
AddEventHandler('esx_lumberjackjob:startCraft2', function()
	local _source = source
	PlayersCrafting2[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Fabrication de ~b~Paquet de planches~s~...')
	Craft2(_source)
end)

RegisterServerEvent('esx_lumberjackjob:stopCraft2')
AddEventHandler('esx_lumberjackjob:stopCraft2', function()
	local _source = source
	PlayersCrafting2[_source] = false
end)

---------------- Revente Paquet de planches -----------------------
local function Resell(source)

	SetTimeout(1000, function()

		if PlayersReselling[source] == true then

			   local xPlayer  = ESX.GetPlayerFromId(source)
			   local PackagedPlankQuantity = xPlayer.getInventoryItem('packaged_plank').count

			    if PackagedPlankQuantity <= 0 then
					TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de Paquet de planches à vendre')
			    else

					xPlayer.removeInventoryItem('packaged_plank', 1)
					xPlayer.addMoney(50)
					  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_lumberjack', function(account)
				      account.addMoney(25)
			          end)

					Resell(source)
				end
		end
	end)
end

RegisterServerEvent('esx_lumberjackjob:startResell')
AddEventHandler('esx_lumberjackjob:startResell', function()
	local _source = source
	PlayersReselling[source] = true
	TriggerClientEvent('esx:showNotification', source, 'Vente de ~b~Paquet de planches~s~ en cours...')
	Resell(source)
end)

RegisterServerEvent('esx_lumberjackjob:stopResell')
AddEventHandler('esx_lumberjackjob:stopResell', function()
	local _source = source
	PlayersReselling[source] = false
end)
---------------------

ESX.RegisterServerCallback('esx_lumberjackjob:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)