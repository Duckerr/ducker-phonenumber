ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

function getIdentity(source, callback)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = identifier},
    function(result)
      if result[1]['firstname'] ~= nil and result[1]['lastname'] ~= nil and result[1]['twitter'] ~= nil then
        local data = {
          identifier    = result[1]['identifier'],
          firstname     = result[1]['firstname'],
          lastname      = result[1]['lastname'],
          twitter      = result[1]['twitter'],
          dateofbirth   = result[1]['dateofbirth'],
          sex           = result[1]['sex'],
          height        = result[1]['height']
        }
        callback(data)
      else
        local data = {
          identifier    = ' ',
          firstname     = ' ',
          lastname      = ' ',
          twitter      = ' ',
          dateofbirth   = ' ',
          sex           = ' ',
          height        = ' '
        }
        callback(data)
      end
    end)
  end

RegisterCommand('num', function(source, args, rawCommand)
    args = table.concat(args, ' ')
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = xPlayer.getName()
    local number = xPlayer.get("phoneNumber")
    getIdentity(source, function(data)
  
    TriggerClientEvent('sendProximityMessageNum', -1, source, data.firstname, number)
end)
end)