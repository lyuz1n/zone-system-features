--[[
	Description: This file is part of castle-24h
	Author: Lyu
	Discord: lyu07
]]

local config = require('castle-24h/config')
local dominantGuild = require('castle-24h/lib/dominant_guild')

local zoneBattle = {}
local interval = {}

local function broadcastInvadeMessage(playerName, guildName, dominantId, dominantName)
	local ss = stringstream()
	ss:append('[Castle 24 horas]: %s da guild [%s] está invadindo o castelo.', playerName, guildName)
	if dominantId > 0 then
		ss:append(' Atualmente o castelo pertence à guild [%s]', dominantName)
	end

	Game.broadcastMessage(ss:str())
end

local function checkBroadcastInterval(guildId)
	local now = os.time()

	interval[guildId] = interval[guildId] or 0
	if interval[guildId] > now then
		return false
	end

	interval[guildId] = now + config.invadeAlertInterval:seconds()
	return true
end

function zoneBattle:onPlayerEnter(player, zone)
	local guild = player:getGuild()
	if not guild then
		player:sendCancelMessage('Para invadir o castelo, você precisa fazer parte de uma guild.')
		return false
	end

	local guildId = guild:getId()
	local dominantId = dominantGuild:getId()

	if checkBroadcastInterval(guildId) and guildId ~= dominantId then
		broadcastInvadeMessage(player:getName(), guild:getName(), dominantId, dominantGuild:getName())
	end
	return true
end

function zoneBattle:clearBroadcastIntervals()
	for guildId, seconds in pairs(interval) do
		interval[guildId] = 0
	end
end

return zoneBattle
