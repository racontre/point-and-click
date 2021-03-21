require "source.global.gameState"
require "source.rooms.title"
require "source.rooms.intro"
require "source.rooms.street"
game={}
game.ui = {}
game.loaded = false
local Room = 
{	
	[ROOM_TITLE] = title,
	[ROOM_INTRO] = intro,
	[ROOM_STREET] = street,
}

function game.changeRoom(param)
	param = param or nil
	if (gameState.room ~= ROOM_NULL) then
		Room[gameState.room].unload()
		Room[gameState.room].loaded = nil
	end
	gameState.room = param
	if (gameState.room ~= ROOM_NULL) then
		Room[gameState.room].load()
		log("\nIn game.changeRoom: Unloading room " .. tostring(gameState.room) .. "\n")
	end
end

function game.load(param)
	game.loaded = true
	if (param == nil) then
		log ('In game.load: param is nil \n')
	else 
		log ('In game.load: param is ' .. param .. '\n')
	end
	if (param == GAME_NEWGAME) then	
		adachi.load()
		log ('In game.load: gameState.state ' .. gameState.state .. '\n')
		intro.unload()
		intro.load()
		intro.set()	
		log('In game.load: game.lua param=GAME_NEWGAME reached \n')
		game.changeRoom(ROOM_INTRO)
	end
	game.ui = ui:create()
	game.ui:CreateButton(100, 100, 50, 50, 22, "adachi kill", SharedResources.mainButtons)
end

function game.unload()
	game.loaded = false
	adachi.unload()
end

function game.draw()
	love.graphics.setColor(1, 1, 1)
	Room[gameState.room].draw()
	love.graphics.setColor(255,255,255,255)
	adachi.draw()
	game.ui:draw()
	dialogue.draw()
	return
end

function game.update(dt)
	game.ui:update(dt)
	adachi.update(dt)
	 dialogue.update(dt)
	if (love.keyboard.isDown("escape")) then
		ChangeGameState(GAMESTATE_PAUSE, false)
	end
end