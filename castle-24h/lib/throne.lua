--[[
	Description: This file is part of castle-24h
	Author: Lyu
	Discord: lyu07
]]

local dominantGuild = require('castle-24h/lib/dominant_guild')
local database = require('castle-24h/lib/database')
local zoneHunt = require('castle-24h/lib/zone_hunt')
local zoneInterior = require('castle-24h/lib/zone_interior')
local zoneBattle = require('castle-24h/lib/zone_battle')

local throne = {}

function throne:onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local guild = player:getGuild()
	if not guild then
		player:teleportTo(fromPosition, true)
		return
	end
	
	local guildId = guild:getId()
	local guildName = guild:getName()

	if guildId == dominantGuild:getId() then
		player:teleportTo(fromPosition, true)
		player:sendCancelMessage('Sua guild já é dona do castelo.')
		return
	end

	dominantGuild:update(guildId, guildName)
	database:insertDominantGuildId(guildId, player:getGuid())
	
	zoneHunt:kickUnauthorizedPlayers()
	zoneInterior:kickUnauthorizedPlayers()
	zoneBattle:clearBroadcastIntervals()

	local ss = stringstream()
	ss:append('[Castle 24 horas]: O jogador %s acabou de conquistar o castelo para a guild %s.', player:getName(), guildName)
	Game.broadcastMessage(ss:str(), MESSAGE_EVENT_ADVANCE)
	position:sendMagicEffect(7)
	player:teleportTo(fromPosition, true)
end

return throne
