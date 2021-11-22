local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-vape:server:effects", function(entity, coords)
	for _, player in pairs(QBCore.Functions.GetPlayers()) do
		TriggerClientEvent("qb-vape:client:effects", player, entity, coords)
    end
end)

QBCore.Functions.CreateUseableItem("vape", function(source, item)
    TriggerClientEvent("qb-vape:client:use", source)
end)
