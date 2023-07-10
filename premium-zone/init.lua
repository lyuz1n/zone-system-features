--[[
	Description: This file is part of premium-zone
	Author: Lyu
	Discord: lyu07
]]

local zoneId = 4422
local exitPosition = Position(992, 1006, 7)

local creatureEvent = CreatureEvent('premiumzone-login')
function creatureEvent.onLogin(player)
	local zone = player:getZone()
	if zone and zone:getId() == zoneId and not player:isPremium() then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Your premium account has expired.')
		player:teleportTo(exitPosition)
		exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

creatureEvent:register()

local zoneEvent = ZoneEvent(zoneId)
function zoneEvent.onPlayerEnter(player, zone)
	if not player:isPremium() then
		player:sendCancelMessage(RETURNVALUE_YOUNEEDPREMIUMACCOUNT)
		return false
	end
	return true
end

zoneEvent:register()
