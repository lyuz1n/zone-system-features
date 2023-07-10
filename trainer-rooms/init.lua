--[[
	Description: This file is part of trainer-rooms
	Author: Lyu
	Discord: lyu07
]]

local zoneId = 8000
local enterUniqueId = 8000

local function enterRoom(player)
	local zone = Zone(zoneId)
	if not zone or zone:getPlayersCount() >= zone:getTilesCount() then
		return false
	end

	for _, tile in ipairs(zone:getTiles()) do
		if not tile:getTopCreature() then
			local toPosition = tile:getPosition()

			player:teleportTo(toPosition)
			toPosition:sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end

	return false
end

local moveEvent = MoveEvent('trainer-rooms-stepin')
function moveEvent.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if not enterRoom(player) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'All trainers are busy.')
		player:teleportTo(fromPosition, true)
		fromPosition:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

moveEvent:uid(enterUniqueId)
moveEvent:register()
