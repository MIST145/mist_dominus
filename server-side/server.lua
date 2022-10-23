----------------------------------------------------------------------
-- FRAMEWORK TUNNEL
----------------------------------------------------------------------
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

----------------------------------------------------------------------
-- PAYMENT METHOD
----------------------------------------------------------------------
RegisterServerEvent("unity_pizzadelivery:payment")
AddEventHandler("unity_pizzadelivery:payment",function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = math.random(25,30)
    xPlayer.addMoney(amount)
    TriggerClientEvent("Notify", source, 'money', 'Recebes-te ' ..amount.. '€ pela entrega', 5000)
end)

RegisterServerEvent('Mota:Caucao')
AddEventHandler('Mota:Caucao', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(100)
    TriggerClientEvent('Notify', source, 'bill', 'Foi cobrado um depósito de <span style="color:black;"><b>100</b></span><span style="color:green;"><b>€</b></span> pelo empréstimo de um veículo. No final do turno será te devolvido', 5000)
end)

RegisterServerEvent('Mota:Delvolver2')
AddEventHandler('Mota:Delvolver2', function(info)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if info == 'semMOTA' then
     xPlayer.addMoney(75)
     TriggerClientEvent('Notify', source, 'bill', 'Ficamos com <span style="color:black;"><b>25</b></span><span style="color:green;"><b>€</b></span> do depósito pelo empréstimo para compensar o cancelamento de pedidos.', 5000)
    end
end)

RegisterServerEvent('Mota:Delvolver')
AddEventHandler('Mota:Delvolver', function(info)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if info == 'comMOTA' then
        xPlayer.addMoney(100)
        TriggerClientEvent('Notify', source, 'money', 'Recebes-te de voltas os <span style="color:green;"><b>100€</b></span> cobrados pelo empréstimo de um veículo!', 5000)
    end
end)