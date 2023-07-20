--[[
	Description: This file is part of castle-24h
	Author: Lyu
	Discord: lyu07
]]

local config = require('castle-24h/config')
local dominantGuild = require('castle-24h/lib/dominant_guild')

local functions = {}

function functions:kickPlayer(player)
	local guild = player:getGuild()
	if guild and guild:getId() ~= dominantGuild:getId() then
		player:teleportTo(config.exitPosition)
		player:sendTextMessage(MESSAGE_INFO_DESCR, '[Castle 24 horas]: Outra guild tomou posse do castelo, portanto você foi expulso.')
	end
end 

function functions:kickUnauthorizedPlayerByZoneId(player, zoneId)
	local zone = player:getZone()
	if zone and zone:getId() == zoneId then
		self:kickPlayer(player)
	end
end

function functions:kickUnauthorizedPlayersByZoneId(zoneId)
	local zone = Zone(zoneId)
	if zone then
		for _, player in ipairs(zone:getPlayers()) do
			self:kickPlayer(player)
		end
	end
	return true
end

return functions
