RegisterNetEvent("qb-vape:client:use", function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local ad = "mp_player_inteat@burger"
	local anim = "mp_player_int_eat_burger"
	if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
		while (not HasAnimDictLoaded(ad)) do
			RequestAnimDict(ad)
			Wait(1)
		end
		vape = CreateObject(GetHashKey("ba_prop_battle_vape_01"), coords.x, coords.y, coords.z+0.2,  true,  true, true)
		AttachEntityToEntity(vape, ped, GetPedBoneIndex(ped, 18905), 0.08, -0.00, 0.03, -150.0, 90.0, -10.0, true, true, false, true, 1, true)
		TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
		PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
		Wait(950)
		TriggerServerEvent("qb-vape:server:effects", PedToNet(ped), coords)
		Wait(950)
		DeleteObject(vape)
		ClearPedTasksImmediately(ped)
		ClearPedSecondaryTask(ped)
	end
end)
p_smoke_location = {
	20279,
}
p_smoke_particle = "exp_grd_bzgas_smoke"
p_smoke_particle_asset = "core" 
RegisterNetEvent("qb-vape:client:effects", function(c_ped, coords)
	local distance = #(GetEntityCoords(PlayerPedId()) - coords)
	if distance <= 300 then
		for _,bones in pairs(p_smoke_location) do
			if DoesEntityExist(NetToPed(c_ped)) and not IsEntityDead(NetToPed(c_ped)) then
				createdSmoke = UseParticleFxAssetNextCall(p_smoke_particle_asset)
				createdPart = StartParticleFxLoopedOnEntityBone(p_smoke_particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), bones), Config.SmokeSize, 0.0, 0.0, 0.0)
				Wait(Config.SmokeTime)
				--Wait(250)
				while DoesParticleFxLoopedExist(createdSmoke) do
					StopParticleFxLooped(createdSmoke, 1)
				Wait(0)
				end
				while DoesParticleFxLoopedExist(createdPart) do
					StopParticleFxLooped(createdPart, 1)
				Wait(0)
				end
				while DoesParticleFxLoopedExist(p_smoke_particle) do
					StopParticleFxLooped(p_smoke_particle, 1)
				Wait(0)
				end
				while DoesParticleFxLoopedExist(p_smoke_particle_asset) do
					StopParticleFxLooped(p_smoke_particle_asset, 1)
				Wait(0)
				end
				Wait(Config.SmokeTime*3)
				RemoveParticleFxFromEntity(NetToPed(c_ped))
				break
			end
		end
	end
end)