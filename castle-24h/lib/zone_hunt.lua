--[[
	Description: This file is part of castle-24h
	Author: Lyu
	Discord: lyu07
]]

local config = require('castle-24h/config')
local functions = require('castle-24h/lib/functions')

local huntZoneId = config.zones.hunt

local zoneHunt = {}

function zoneHunt:kickUnauthorizedPlayers()
	return functions:kickUnauthorizedPlayersByZoneId(huntZoneId)
end

function zoneHunt:onPlayerEnter(player, zone)
	return true
end

function zoneHunt:onLogin(player)
	local zone = player:getZone()
	if zone and zone:getId() == huntZoneId then
		functions:kickUnauthorizedPlayerByZoneId(player, huntZoneId)
	end
end

return zoneHunt
