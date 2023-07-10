--[[
	Description: This file is part of required-storage-zone
	Author: Lyu
	Discord: lyu07
]]

local zoneId = 1050
local storageValue = 845000

local zoneEvent = ZoneEvent(zoneId)
function zoneEvent.onPlayerEnter(player, zone)
	if player:getStorageValue(storageValue) == -1 then
		player:sendCancelMessage('You cannot enter this zone.')
		return false
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, 'Welcome :)')
	return true
end

zoneEvent:register()
