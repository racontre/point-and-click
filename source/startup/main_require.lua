function getGlobals()
  require("source/animating")
  
  require ("source/debug/dbg")
  require("source/debug/helper")
  require("source/debug/logging")
  

  require("source/global/game")
  require("source/global/gameState")
  require("source/global/collision")
  require("source/global/message")
  require("source/global/objects")
  require("source/global/pause")
  require("source/global/PointWithinShape")
  gameStateInit()

  HC = require("source/lib/hardoncollider")
  updateGameplay = require("source/update")
  player = require("source/player")

  require("source/rooms/intro")
 -- require("source/maps/office")
  require("source/rooms/street")
  require("source/rooms/title")

  require("source/ui/ui")
  SharedResources.mainButtons = ui.ButtonImages('img/default.png','img/over.png','img/click.png')
  require ("source/objects/key")
end