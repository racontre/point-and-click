require 'source.rooms.intro'
gameState = {}
gameState.player = {}
gameState.pickups = {}

GAMESTATE_NULL, GAMESTATE_MAINMENU, GAMESTATE_GAME, GAMESTATE_PAUSE, GAMESTATE_CREDITS = 0, 1, 2, 3, 4 --"""""enum"""""
ROOM_NULL, ROOM_TITLE, ROOM_INTRO, ROOM_STREET = 0, 1, 2, 3
GAME_NEWGAME, GAME_CONTINUE = 1, 2

function gameStateInit()			--reset through this

  -- Number of times the game has been saved.
  gameState.saveCount = 0

  -- State stores if update functions should occur
  GameState = 
	{
	[GAMESTATE_MAINMENU] = title,
	[GAMESTATE_GAME] = game,
	[GAMESTATE_PAUSE] = pause,
	}
  
  -- Stores the current room
  gameState.state = GAMESTATE_NULL
  gameState.room = ROOM_NULL

  -- Player information
  gameState.player.x = 0
  gameState.player.y = 0
  gameState.player.maxHealth = 20
  gameState.player.weapon = 0
end

function ChangeGameState(staet, unload, param)  --!! staet? !!
	if (unload == nil) then unload = true end
	log("In ChangeGameState: Unloading gamestate " .. tostring(staet) .. " unload = " .. tostring(unload) .. "\n")
	if (gameState.state ~= GAMESTATE_NULL and unload == true) then
		GameState[gameState.state].unload()
	end
	gameState.state = staet
	if (gameState.state ~= GAMESTATE_NULL and GameState[gameState.state].loaded == false) then
		GameState[gameState.state].load(param)		
	end
	
	if (gameState.state == GAMESTATE_MAINMENU and GameState[gameState.state].loaded == true) then
		log ('In ChangeGameState: Main Menu gamestate reached' .. tostring(gameState.room) ..' \n')	
	end --reset all 
	game.load(param)
end