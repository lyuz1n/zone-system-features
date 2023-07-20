--[[
	Description: This file is part of castle-24h
	Author: Lyu
	Discord: lyu07
]]

local config = require('castle-24h/config')
local dominantGuild = require('castle-24h/lib/dominant_guild')
local functions = require('castle-24h/lib/functions')

local zoneInterior = {}
local interiorZoneId = config.zones.interior

function zoneInterior:kickUnauthorizedPlayers()
	return functions:kickUnauthorizedPlayersByZoneId(interiorZoneId)
end

function zoneInterior:onPlayerEnter(player, zone)
	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage('Para acessar o interior do castelo, você precisa fazer parte de uma guild.')
		return false
	end

	if guild:getId() ~= dominantGuild:getId() then
		player:sendCancelMessage('Para acessar o interior do castelo, sua guild precisa ser dominante.')
		return false
	end
	return true
end

function zoneInterior:onLogin(player)
	local zone = player:getZone()
	if zone and zone:getId() == interiorZoneId then
		functions:kickUnauthorizedPlayerByZoneId(player, interiorZoneId)
	end
end

return zoneInterior
