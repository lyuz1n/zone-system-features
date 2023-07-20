--[[
	Description: This file is part of castle-24h
	Author: Lyu
	Discord: lyu07
]]

local config = require('castle-24h/config')

local database = {}

function database:getLastDominantGuildId()
	local resultId = db.storeQuery('SELECT * FROM castle24h_dominate_history ORDER BY created_at DESC LIMIT 1')
	local guildId = 0

	if resultId then
		guildId = result.getNumber(resultId, 'guild_id')
		result.free(resultId)
	end
	return guildId
end

function database:insertDominantGuildId(guildId, playerGuid)
	db.asyncQuery(('INSERT INTO castle24h_dominate_history (guild_id, player_id) VALUES (%d, %d)'):format(
		guildId,
		playerGuid
	))
end

function database:getGuildNameById(guildId)
	local resultId = db.storeQuery(('SELECT name FROM guilds WHERE id = %d'):format(guildId))
	local guildName = ''
	
	if resultId then
		guildName = result.getString(resultId, 'name')
		result.free(resultId)
	end
	return guildName
end

return database
