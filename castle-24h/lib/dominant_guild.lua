--[[
	Description: This file is part of castle-24h
	Author: Lyu
	Discord: lyu07
]]

local database = require('castle-24h/lib/database')

return {
	update = function(self, guildId, guildName)
		id = guildId
		name = guildName
	end,
	
	onStartup = function()
		id = database:getLastDominantGuildId()
		name = database:getGuildNameById(id)
	end,

	getId = function() return id end,
	getName = function() return name end
}
