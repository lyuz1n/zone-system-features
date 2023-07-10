--[[
	Description: This file is part of test-boss-room
	Author: Lyu
	Discord: lyu07
]]

local config = {
	zoneId = 6666,
	exitPosition = Position(1000, 1000, 7),
	bossPosition = Position(1268, 1023, 7),
	playerPosition = Position(1268, 1030, 7),
	bossName = 'Hydra'
}

local checkRoom = function(zone, playerId, timer)
	local player = Player(playerId)
	if not player then
		timer:cancel()
		return
	end

	local monstersCount = zone:getMonstersCount()
	player:sendTextMessage(MESSAGE_INFO_DESCR, ('%d monsters remaining..'):format(monstersCount))

	if monstersCount == 0 then
		player:teleportTo(config.exitPosition)
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Finish')
		timer:cancel()
	end
end

local talkAction = TalkAction('!bossroom')
function talkAction.onSay(player)
	local zone = Zone(config.zoneId)
	if not zone then
		return false
	end

	local playerId = player:getId()

	zone:removeMonsters()
	zone:clean()
	Game.createMonster(config.bossName, config.bossPosition)
	player:teleportTo(config.playerPosition)

	Timer:periodic {
		duration = Duration {seconds = 2},
		onTick = function(timer)
			checkRoom(zone, playerId, timer)
		end
	}
	return false
end

talkAction:register()
