----------------------------------------------------------------------
-- FRAMEWORK TUNNEL (NÃO MEXER)
----------------------------------------------------------------------
ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

----------------------------------------------------------------------
-- VARIAVEIS (NÃO MEXER)
----------------------------------------------------------------------
local service = false -- não mexer
local object = nil -- não mexer
local pickvehicle = false -- não mexer
local carrypizza = false -- não mexer
local readydelivery = false -- não mexer
local pizza = 0 -- não mexer
local selected = 0 -- não mexer
local nveh = nil -- Não mexer
-- CONFIGURAR O SCRIPT DE ACORDO COM SUA CIDADE, BOM USO MEU QUERIDO, QUALQUER COISA ME CHAMA DISCORD: </Caduh>#2543
local vehiclejobhash = 1602833228 -- CONFIGURAR O HASH DO VEICULO DE TRABALHO
local startservice = { 552.75,116.00,96.20 } -- ONDE INICIAR A ROTA
local garage = { 555.79,117.91,97.43 } -- BLIP PARA RETIRAR O VEICULO DE TRABALHO
local vehicleposition = { 555.68,122.40,97.65,67.11} -- LOCAL ONDE O VEICULO SPAWNA QUANDO UTILIZAR O BLIP DA GARAGEM
local spawnprop = { 545.97,116.4,97.55,152.46 } -- LOCAL ONDE SPAWNA O PROP DA PIZZA PARA PEGAR
-- # CONFIGURAR CASAS(Locais onde o jogador terá que entregar as pizzas)
local homes = { 
	[1] = { 511.5166015625, 232.07015991211, 104.74394989014, 139.20014953613 },
    [2] = { -831.12268066406, 115.07144927979, 55.629825592041, 98.513710021973 },
    [3] = { -1477.2071533203, -674.46179199219, 29.041679382324, 28.939851760864 },
    [4] = { -989.09228515625, -1575.7294921875, 5.1729297637939, 107.54333496094 },
    [5] = { -551.30572509766, -815.12280273438, 30.691381454468, 180.87902832031 },
    [6] = { -13.020709037781, -1442.1657714844, 31.100883483887, 152.09405517578 },
    [7] = { 320.27557373047, -2100.6162109375, 18.244291305542, 17.944011688232 },
    [8] = { 830.26086425781, -1310.6856689453, 28.251588821411, 241.81103515625 },
    [9] = { 960.77056884766, -669.52337646484, 58.449768066406, 298.95983886719 },
	[10] = { 225.25595092773, -161.04867553711, 58.908489227295, 253.11511230469 },
	[11] = { -1219.6175537109, 666.15045166016, 144.35580444336, 43.078922271729},
    [12] = { -1337.9702148438, 605.89306640625, 134.3797454834, 84.684356689453},
    [13] = { -1052.0222167969, 429.96530151367, 76.863807678223, 94.30396270752 },
    [14] = { -902.52160644531, 191.44007873535, 69.446014404297, 96.146919250488 },
    [15] = { -21.865245819092, -24.500461578369, 73.245429992676, 342.00650024414 },
    [16] = { -9.9166078567505, -14.713959693909, 71.145210266113, 64.600143432617 },
    [17] = { 227.53082275391, -284.10232543945, 49.720069885254, 72.807304382324 },
    [18] = { 4.6121616363525, -706.13806152344, 45.973041534424, 201.65132141113 },
    [19] = { 286.2490234375, -936.64996337891, 29.46787071228, 142.71501159668},
    [20] = { 412.19287109375, -1488.5498046875, 30.149076461792, 26.029340744019},
    [21] = { 84.79, -1959.17, 21.12, 342.02},
    [22] = { -222.67822265625, -1616.7150878906, 38.055057525635, 346.53018188477},
    [23] = { -1014.4932861328, -1514.5843505859, 6.5168037414551, 135.13150024414},
    [24] = { -1005.197265625, -1155.0050048828, 2.1587421894073, 307.78601074219},
    [25] = { -1113.8211669922, -1193.8208007813, 2.3773310184479, 36.828075408936},
    [26] = { -1076.1245117188, -1026.2940673828, 4.5451049804688, 19.938283920288},
    [27] = { -1056.0228271484, -1000.6213989258, 2.150191783905, 126.06118774414},
    [28] = { -1090.3458251953, -926.69598388672, 3.0976316928864, 30.346580505371},
    [29] = { -1053.9818115234, -1000.1361083984, 6.410484790802, 121.47948455811},
    [30] = { -1181.4466552734, -989.07305908203, 2.1501922607422, 193.98945617676},
    [31] = { -1151.5993652344, -990.37506103516, 2.1501932144165, 213.20317077637},
    [32] = { -1022.633605957, -896.77087402344, 5.4145436286926, 33.817184448242},
    [33] = { -1061.1673583984, -827.35473632813, 19.20809173584, 310.68978881836},
    [34] = { -968.75592041016, -1328.8243408203, 5.6561527252197, 196.52615356445},
    [35] = { -1186.0793457031, -1385.2722167969, 4.6228575706482, 318.98446655273},
    [36] = { -1132.9912109375, -1456.4095458984, 4.8984050750732, 302.74725341797},
    [37] = { -1125.6201171875, -1544.1402587891, 5.3666076660156, 302.74682617188},
    [38] = { -1084.7341308594, -1558.6149902344, 4.4984374046326, 31.542444229126},
    [39] = { -1098.2139892578, -1678.6365966797, 4.3543705940247, 129.51840209961},
    [40] = { -1156.1389160156, -1575.0798339844, 8.3457489013672, 217.16693115234},
    [41] = { -1122.6572265625, -1557.5260009766, 5.2682070732117, 217.1668548584},
    [42] = { -1108.4088134766, -1527.3199462891, 6.7795338630676, 187.52447509766},
    [43] = { -1273.7292480469, -1382.0900878906, 4.3244123458862, 204.68222045898},
    [44] = { -1342.6439208984, -1234.5777587891, 5.9385199546814, 115.25715637207},
    [45] = { -1350.8471679688, -1128.7054443359, 4.1625194549561, 60.466262817383},
    [46] = { -1343.5799560547, -1044.0362548828, 7.8250517845154, 309.54275512695},
    [47] = { -728.38684082031, -879.99035644531, 22.711109161377, 98.548095703125},
    [48] = { -831.44653320313, -862.63519287109, 20.689670562744, 357.28619384766},
    [49] = { -812.25726318359, -980.36517333984, 14.268705368042, 126.26629638672},
    [50] = { -661.44519042969, -907.63726806641, 24.605113983154, 264.47415161133},
    [51] = { -1031.2183837891, -903.01892089844, 3.6894221305847, 46.567573547363},
    [52] = { -1269.4405517578, -1096.6136474609, 7.7954125404358, 46.206398010254},
    [53] = { -1225.4429931641, -1208.1552734375, 8.2672061920166, 276.73580932617},
    [54] = { -1207.0596923828, -1263.9079589844, 6.9787216186523, 347.35485839844},
    [55] = { -1087.1882324219, -1277.4610595703, 5.8424043655396, 196.69776916504},
    [56] = { -886.1220703125, -1230.0577392578, 5.6555800437927, 351.13946533203},
    [57] = { -753.32409667969, -1511.6739501953, 5.0156078338623, 341.56109619141},
    [58] = { -41.147121429443, -58.188259124756, 63.659664154053, 44.665019989014},
    [59] = { -428.54064941406, -1728.126953125, 19.783840179443, 56.57434463501},
    [60] = { -43.474227905273, -1041.94921875, 28.343688964844, 75.74146270752},
    [61] = { -1339.5975341797, -1127.8061523438, 4.3337392807007, 5.7915329933167},
    [62] = { -1090.451171875, -926.66088867188, 3.1034564971924, 28.893989562988},
    [63] = { -827.37634277344, -698.24517822266, 28.056562423706, 90.395988464355},
    [64] = { -518.16296386719, -809.05407714844, 30.735492706299, 284.22305297852},
    [65] = { 126.67158508301, -126.01343536377, 54.834594726563, 58.317905426025},
    [66] = { -1894.1265869141, -567.88623046875, 11.812229156494, 356.55767822266},
    [67] = { -930.40191650391, 19.429258346558, 48.525764465332, 221.04759216309},
    [68] = { -53.987499237061, -144.27053833008, 57.464656829834, 3.3329885005951},
    [69] = { 435.65286254883, 214.79191589355, 103.16625213623, 344.62408447266},
    [70] = { 1266.8826904297, -457.81585693359, 70.516662597656, 271.6770324707},
    [71] = { -288.15570068359, -1062.7963867188, 27.205402374268, 251.79281616211},
    [72] = { 109.56089782715, -1090.640625, 29.302478790283, 340.09701538086},
    [73] = { 269.67495727539, -640.71447753906, 42.020336151123, 57.819110870361},
    [74] = {-1007.4428100586, -486.81164550781, 39.970050811768, 124.84921264648},
    [75] = { -696.34399414063, -1386.9460449219, 5.4952764511108, 70.589164733887}
}
local NPCNames	= {
	--Female Peds
	[1] = {name = 'a_f_o_salton_01'},
	[2] = {name = 'a_f_y_eastsa_03'},
	[3] = {name = 'a_f_y_tourist_02'},
	[4] = {name = 'a_f_y_bevhills_02'},
	[5] = {name = 'a_f_m_soucentmc_01'},
	--Male Peds
	[6] = {name = 'a_m_m_bevhills_01'},
	[7] = {name = 'a_m_m_afriamer_01'},
	[8] = {name = 'a_m_m_genfat_01'},
	[9] = {name = 'a_m_m_hillbilly_01'},
	[10] = {name = 'a_m_m_trampbeac_01'}
}
---------------------------------------------------------------------
-- FUNCTIONS (NÃO MEXER)
---------------------------------------------------------------------
function startRoute()
	selected = math.random(#homes)
	CreateBlip(selected)
	--spawnPed(selected)
end

function CreateBlip(route)
	blip = AddBlipForCoord(homes[route][1],homes[route][2],homes[route][3])
	SetBlipSprite(blip,162)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de pizza")
	EndTextCommandSetBlipName(blip)
	repeat
        currentPed = math.random(1, #NPCNames)
    until currentPed ~= lastPed
    RequestModel(NPCNames[currentPed].name)
    while not HasModelLoaded(NPCNames[currentPed].name) do
        Wait(1)
    end
    pedss = CreatePed(1, NPCNames[currentPed].name, homes[route][1],homes[route][2],homes[route][3] - 1.0, homes[route][4], false, true)
    SetBlockingOfNonTemporaryEvents(pedss, true)
    SetPedDiesWhenInjured(pedss, false)
    SetPedCanPlayAmbientAnims(pedss, false)
    SetPedCanRagdollFromPlayerImpact(pedss, false)
    SetEntityInvincible(pedss, true)
    FreezeEntityPosition(pedss, true)
    TaskStartScenarioInPlace(pedss, "amb@code_human_in_bus_passenger_idles@female@sit@base", 0, true);
end

function DrawText3D(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function spawnMotorcycle()
    local ped = PlayerPedId()
	local mhash = "YamahaAeroxPizza"

	if not nveh then
        while not HasModelLoaded(mhash) do
    	  	RequestModel(mhash)
    	    Citizen.Wait(10)
	    end

		nveh = CreateVehicle(mhash,vehicleposition[1],vehicleposition[2],vehicleposition[3]+0.5,68.04,true,false)
		SetVehicleExtra(nveh, 1)
		SetVehicleExtra(nveh, 2)
		SetVehicleIsStolen(nveh,false)
		SetVehicleOnGroundProperly(nveh)
		SetEntityInvincible(nveh,false)
		exports["np-fuel"]:SetFuel(nveh, 100)
		local plate = "PIZZA"..math.random(0,9)..math.random(0,9)
		SetVehicleNumberPlateText(nveh,plate)
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehicleDirtLevel(nveh,0.0)
		SetVehRadioStation(nveh,"OFF")
		--TriggerEvent('fuel:set', vehicle, 100)
		SetVehicleEngineOn(GetVehiclePedIsIn(ped,false),true)
		SetModelAsNoLongerNeeded(mhash)
		TriggerServerEvent("Mota:Caucao")
		BlipAnularMissao()
	end
end

function getMotorcyclePosition(radius)
	local ped = PlayerPedId()
	local coordsx = GetEntityCoords(ped, 1)
	local coordsy = GetOffsetFromEntityInWorldCoords(ped, 0.0, radius+0.00001, 0.0)
	local nearVehicle = GetMotorDirection(coordsx, coordsy)
	if IsEntityAVehicle(nearVehicle) then
	    return nearVehicle
	else
		local x,y,z = table.unpack(coordsx)
	    if IsPedSittingInAnyVehicle(ped) then
	        local veh = GetVehiclePedIsIn(ped,true)
	        return veh
	    else
	        local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,8192+4096+4+2+1) 
	        if not IsEntityAVehicle(veh) then 
	        	veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001,radius+0.0001,0,4+2+1) 
	        end 
	        return veh
	    end
	end
end

function GetMotorDirection(coordFrom,coordTo)
	local position = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a,b,c,d,vehicle = GetRaycastResult(position)
	return vehicle
end

function spawnPizza()
	object = CreateObject(GetHashKey("prop_pizza_box_02"),spawnprop[1],spawnprop[2],spawnprop[3]-0.95,false,true,false)
	SetEntityAsMissionEntity(object)
	TriggerEvent("Notify","inform",'Há uma nova <span style="color:black;">entrega</span>, retire no <b>balcão</b> da <span style="color:yellow;">pizzaria</span>', 5000)
end

function deletepropspawn()	
	DeleteObject(object)
end

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end


function pickPizza()
    local player = GetPlayerPed(-1)
    if not IsPedInAnyVehicle(player, false) then
        local ad = "anim@heists@box_carry@"
        local prop_name = 'prop_pizza_box_02'
        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
            loadAnimDict( ad )
            if carrypizza then
                TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
                DetachEntity(prop, 1, 1)
                DeleteObject(prop)
                Wait(1000)
                ClearPedSecondaryTask(PlayerPedId())
                carrypizza = false
            else
                local x,y,z = table.unpack(GetEntityCoords(player))
                prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
                AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.2, 0.08, 0.2, -45.0, 290.0, 0.0, true, true, false, true, 1, true)
                TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				carrypizza = true
				deletepropspawn()	
            end
        end
    end
end

function putPizza()
	carrypizza = false
	MaPaczke = false 
	ClearPedTasksImmediately(ped)
	ClearPedSecondaryTask(ped)
	DetachEntity(prop, 1, 1)
    DeleteObject(prop)
    Wait(1000)
    ClearPedSecondaryTask(PlayerPedId())
end
---------------------------------------------------------------------
-- NÃO CORRER COM A PIZZA NA MÃO (NÃO MEXER)
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
	    local sleep = 1000

		if carrypizza then
			sleep = 5
			DisableControlAction(0,22,true)
			DisableControlAction(0,21,true)
		end

	    Citizen.Wait(sleep)
	end
end)
---------------------------------------------------------------------
-- SAIR DE SERVIÇO (NÃO MEXER)
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
    	local sleep = 1000
		local ped = PlayerPedId()
		local Posic = GetEntityCoords(ped)
		local Distance = GetDistanceBetweenCoords(Posic, 563.92, 119.38, 98.04, true)

        if service and Distance <= 4.0 then
			sleep = 5
			ESX.ShowFloatingHelpNotification("ℹ️ ~r~terminar ~s~o trabalho", vector3(563.92, 119.38, 98.04 +0.50))
			--DrawText3D(563.92, 119.38, 98.04 +0.50, "[ℹ️] ~r~terminar ~s~o trabalho")
    		if IsControlJustPressed(0,38) then
                local veh = getMotorcyclePosition(2)
                local model = GetEntityModel(veh)

				if IsPedInAnyVehicle(ped) and model == vehiclejobhash then
        			TriggerEvent("Notify","inform",'Você <span style="color:red;">terminou</span> o serviço',4000)
        			DeleteObject(object)
					TriggerEvent("AdvancedParking:enable", false)
					TaskLeaveVehicle(ped, nveh)
                    SetVehicleDoorsLockedForAllPlayers(nveh, true)
					Citizen.Wait(4000)
					DeleteVehicle(nveh)
					TriggerEvent("AdvancedParking:enable", true)
					RemoveBlip(blip)
					RemoveBlip(blips)
        			nveh = nil
        			service = false
        			object = nil
        			pickvehicle = false
        			carrypizza = false
        			readydelivery = false
        			pizza = 0
					selected = 0
					TriggerServerEvent("Mota:Delvolver", 'comMOTA')
					DestruirBlipAnular()
				else
					RemoveBlip(blip)
					RemoveBlip(blips)
        			nveh = nil
        			service = false
        			object = nil
        			pickvehicle = false
        			carrypizza = false
        			readydelivery = false
        			pizza = 0
					selected = 0
					TriggerServerEvent("Mota:Delvolver2", 'semMOTA')
					DestruirBlipAnular()
                end
    		end	
    	end
        Citizen.Wait(sleep)
	end
end)

function BlipAnularMissao()
	blips = AddBlipForCoord(563.92, 119.38, 98.04)
	SetBlipSprite(blips,162)
	SetBlipColour(blips,59)
	SetBlipScale(blips,0.8)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blips,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Cancelar pedidos")
	EndTextCommandSetBlipName(blips)
end

function DestruirBlipAnular()
    RemoveBlip(Blips)
end
---------------------------------------------------------------------
-- ENTREGAR A PIZZA NA CASA (NÃO MEXER)
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local coords = vector3(GetEntityCoords(ped))
		--local peds = CreatePed('PED_TYPE_CIVMALE', 0x867639D1, #(coords - vector3(homes[selected][1],homes[selected][2],homes[selected][3])))

		if readydelivery then
			local distance = #(coords - vector3(homes[selected][1],homes[selected][2],homes[selected][3]))
			if distance <= 8 then
				sleep = 5
				ESX.ShowFloatingHelpNotification("ENTREGAR ~g~PI~w~ZZ~r~A🍕", vector3(homes[selected][1],homes[selected][2],homes[selected][3]+0.9))
				--DrawMarker(37,homes[selected][1],homes[selected][2],homes[selected][3]-0.8,0,0,0,0.0,0,0,0.6,0.6,0.5,209,185,72,100,0,0,0,1)
				if IsControlJustPressed(0,38) and carrypizza then
					if pizza ~= 0 then
						TaskPlayAnim(pedss,"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
                        local coords = GetOffsetFromEntityInWorldCoords(pedss,0.0,0.0,-5.0)
                        object = CreateObject(GetHashKey("prop_pizza_box_02"),coords.x,coords.y,coords.z,true,true,true)
                        SetEntityCollision(object,false,false)
                        AttachEntityToEntity(object,pedss,GetPedBoneIndex(pedss,11816),-0.05,0.38,-0.045,15.0,285.0,270.0,true,false,false,true,1,true)
                        SetEntityAsMissionEntity(object,true,true)
						SetEntityAsMissionEntity(object,true,true)
						FreezeEntityPosition(pedss, false)
                        RemovePedElegantly(pedss)
						RemoveBlip(blip)
						startRoute()
						putPizza()
						TriggerServerEvent("unity_pizzadelivery:payment")
					else
						TaskPlayAnim(pedss,"anim@heists@box_carry@","idle",3.0,3.0,-1,50,0,0,0,0)
                        local coords = GetOffsetFromEntityInWorldCoords(pedss,0.0,0.0,-5.0)
                        object = CreateObject(GetHashKey("prop_pizza_box_02"),coords.x,coords.y,coords.z,true,true,true)
                        SetEntityCollision(object,false,false)
                        AttachEntityToEntity(object,pedss,GetPedBoneIndex(pedss,11816),-0.05,0.38,-0.050,15.0,285.0,270.0,true,false,false,true,1,true)
                        SetEntityAsMissionEntity(object,true,true)
						SetEntityAsMissionEntity(object,true,true)
						FreezeEntityPosition(pedss, false)
                        RemovePedElegantly(pedss)
						RemoveBlip(blip)
						putPizza()
						readydelivery = false
						spawnPizza()
                        TriggerServerEvent("unity_pizzadelivery:payment")
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
---------------------------------------------------------------------
-- PEGAR SERVIÇO (NÃO MEXER)
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local coords = vector3(GetEntityCoords(ped))
		if not service then
            local distance = #(coords - vector3(startservice[1],startservice[2],startservice[3]))
			if distance <= 1.5 then
				sleep = 5
				ESX.ShowFloatingHelpNotification("Entregador de 🍕~g~PI~w~ZZ~r~AS ~w~de 🛵", vector3(startservice[1],startservice[2],startservice[3]+1.0))
				--DrawText3D(startservice[1],startservice[2],startservice[3]+0.5, "Entregador de 🍕~g~PI~w~ZZ~r~AS ~w~de 🛵")
				if IsControlJustPressed(0,38) then
					service = true
					TriggerEvent("Notify","sucess",'Trabalho iniciado com <b>sucesso</b> retire a <span style="color:black;"><b>mota</b></span>', 4000)
				end
			end
		else
			local distance = #(coords - vector3(garage[1],garage[2],garage[3]))

			if distance <= 2.0 and not pickvehicle then
				sleep = 5
				DrawMarker(37,garage[1],garage[2],garage[3]+0.1,0,0,0,0.0,0,0,0.6,0.6,0.5,209,185,72,100,0,0,0,1)

				if IsControlJustPressed(0,38) then
					pickvehicle = true
					spawnPizza()
					spawnMotorcycle()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
---------------------------------------------------------------------
-- PEGAR A PIZZA DO BALCAO (NÃO MEXER)
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local coords = vector3(GetEntityCoords(ped))

		if pickvehicle and not carrypizza then
            local distance = #(coords - vector3(spawnprop[1],spawnprop[2],spawnprop[3]))

			if distance <= 2.0 then
				if pizza < 5 and not readydelivery then
					sleep = 5
					ESX.ShowFloatingHelpNotification("ℹ️ ~g~PEGAR 🍕", vector3(spawnprop[1],spawnprop[2],spawnprop[3]-0.6))
					--DrawText3D(spawnprop[1],spawnprop[2],spawnprop[3]-0.6, "[ℹ️] pegar a 🍕")	

					if IsControlJustPressed(0,38) then
						TriggerEvent("Notify","pizza",'Coloque a <span style="color:green;">pi</span><span style="color:withe;">zz</span><span style="color:red;">a</span> na <span style="color:black;"><b>mota</b></span>', 4000)
						pickPizza()
						deletepropspawn()
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
---------------------------------------------------------------------
-- COLOCAR OU TIRAR PIZZA DA CAIXA (NÃO MEXER)
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local coords = vector3(GetEntityCoords(ped))

		if pickvehicle then
			local veh = getMotorcyclePosition(2)
			local PositionMotorcycle = GetOffsetFromEntityInWorldCoords(veh,0.0,-1.1,0.0)
            local distance = #(coords - vector3(PositionMotorcycle.x,PositionMotorcycle.y,PositionMotorcycle.z))

			if not IsPedInAnyVehicle(ped) and distance <= 2.5 then
				if carrypizza then
					sleep = 5 
					ESX.ShowFloatingHelpNotification("ℹ️ ~r~GUARDAR 🍕~w~  "..pizza.."/5", vector3(PositionMotorcycle.x,PositionMotorcycle.y-0.2,PositionMotorcycle.z+0.80))
					--DrawText3D(PositionMotorcycle.x,PositionMotorcycle.y,PositionMotorcycle.z+0.80,"[ℹ️] Guardar a 🍕  "..pizza.."/5")
					if IsControlJustPressed(0,38) and GetEntityModel(veh) == vehiclejobhash then
						putPizza()
						pizza = pizza + 1
						if pizza == 5 and not readydelivery then
							TriggerEvent("Notify","bike",'Suba na <b>moto</b> para realizar as <span style="color:green;">entregas</span>!', 8000)
							readydelivery = true
							startRoute()
						end
						if not readydelivery then
							spawnPizza()
						end
					end
				elseif pizza > 0 then
					sleep = 5
					ESX.ShowFloatingHelpNotification("ℹ️ ~g~PEGAR 🍕~w~ "..pizza.."/5", vector3(PositionMotorcycle.x,PositionMotorcycle.y-0.2,PositionMotorcycle.z+0.80))
					--DrawText3D(PositionMotorcycle.x,PositionMotorcycle.y,PositionMotorcycle.z+0.80,"[ℹ️] pegar a 🍕 "..pizza.."/5")
					if IsControlJustPressed(0,38) then
						pickPizza()
						pizza = pizza - 1
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)