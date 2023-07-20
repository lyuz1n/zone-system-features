--[[
	Description: This file is part of castle-24h
	Author: Lyu
	Discord: lyu07
]]

local config = require('castle-24h/config')
local dominantGuild = require('castle-24h/lib/dominant_guild')
local zoneHunt = require('castle-24h/lib/zone_hunt')
local zoneInterior = require('castle-24h/lib/zone_interior')
local zoneBattle = require('castle-24h/lib/zone_battle')
local throne = require('castle-24h/lib/throne')

local creatureevent = CreatureEvent('castle24h-login')
function creatureevent.onLogin(player)
	zoneHunt:onLogin(player)
	zoneInterior:onLogin(player)
	return true
end

creatureevent:register()

local globalevent = GlobalEvent('castle24h-startup')
function globalevent.onStartup()
	dominantGuild:onStartup()
	return true
end

globalevent:register()

local moveevent = MoveEvent()
function moveevent.onStepIn(creature, item, position, fromPosition)
	throne:onStepIn(creature, item, position, fromPosition)
	return true
end

moveevent:uid(config.throneUid)
moveevent:register()

local zoneEvent = ZoneEvent(config.zones.battle)
function zoneEvent.onPlayerEnter(player, zone)
	return zoneBattle:onPlayerEnter(player, zone)
end

zoneEvent:register()

zoneEvent = ZoneEvent(config.zones.interior)
function zoneEvent.onPlayerEnter(player, zone)
	return zoneInterior:onPlayerEnter(player, zone)
end

zoneEvent:register()

zoneEvent = ZoneEvent(config.zones.hunt)
function zoneEvent.onPlayerEnter(player, zone)
	return zoneHunt:onPlayerEnter(player, zone)
end

zoneEvent:register()
