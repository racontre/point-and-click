local anim8 = require 'source.lib.anim8.anim8'
require 'source.objects.key'
local image, animation
adachi = {}

  
function adachi.load()
log('adachi loaded')
  image = love.graphics.newImage('img/spritesheetP.png')
  g = anim8.newGrid(99, 203, image:getWidth(), image:getHeight())
animation = anim8.newAnimation(g('1-1',1), 0.2)
adachi.y = 500	--what 
adachi.x = 500
adachi.vel = 100
adachi.hitbox = HC.circle(10,10,20)
adachi.animations = {
 idle = anim8.newAnimation(g('1-1',1), 0.2),
 up =  anim8.newAnimation(g('1-3',1), 0.2),	
 down = anim8.newAnimation(g('1-3',1),0.2),
 left = anim8.newAnimation(g('1-3',1),0.2),
 right = anim8.newAnimation(g('1-3',1),0.2),
 talk = anim8.newAnimation(g('1-3',2),0.2)
}
local keyDown 
adachi.animation = animation
end
gameState = {}
function adachi.unload()
image = nil
animation = nil
adachi = nil
end

function adachi.update(dt)

	adachi.movement(dt)
	adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)		--Important: make gamestate a part of
  for shape, delta in pairs(HC.collisions(adachi.hitbox)) do				--animating.lua or change it to something
    if shape:collidesWith(adachi.hitbox) then	
	adachi.keypressed(keyDown,dt)
    end
end

adachi.animation:update(dt)
end



function adachi.keypressed(key,dt)
   if keyDown == "escape" then
      love.event.quit()
   end

end
function adachi.draw()
adachi.hitbox:draw('fill')
  adachi.animation:draw(image, gameState.player.x, gameState.player.y)
 for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
shape:draw('fill')
end

--love.graphics.print( love.timer.getTime(), gameState.player.x, gameState.player.y)
--dialogue.draw(keyObject.comment, gameState.player.x, gameState.player.y)
end

function adachi.movement(dt)
wDown = false
sDown = false
aDown = false
dDown = false
if love.keyboard.isDown("w") then 
		wDown = true
   		gameState.player.y  = gameState.player.y  - 100 * dt
adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
 		for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
  		 if shape:collidesWith(adachi.hitbox) then	
			gameState.player.y  = gameState.player.y + 100 * dt
			adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
		 end
		end

end
  

if love.keyboard.isDown("s") then
		sDown = true
		gameState.player.y  = gameState.player.y + 100 * dt
adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
		adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
 		for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
   		 if shape:collidesWith(adachi.hitbox) then	
			gameState.player.y  = gameState.player.y - 100 * dt
			adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
		 end
		end
	        adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)

 
  end
  if love.keyboard.isDown("a") then 
	 gameState.player.x  = gameState.player.x - 100 * dt

adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
 	 for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
	  if shape:collidesWith(adachi.hitbox) then	
		gameState.player.x  = gameState.player.x + 100 * dt
		adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
	 end
	end
	aDown = true
  end
  if love.keyboard.isDown("d") then 
	dDown = true
   	gameState.player.x  = gameState.player.x + 100 * dt
adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
 	for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
   	 if shape:collidesWith(adachi.hitbox) then	
		gameState.player.x  = gameState.player.x - 100 * dt
		adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
	 end
	end

 end
	if wDown == true then
   		adachi.animation = adachi.animations.up;
	elseif sDown == true then
  		adachi.animation = adachi.animations.down;
	elseif aDown == true then
		adachi.animation = adachi.animations.left;
	elseif dDown == true then
		adachi.animation = adachi.animations.right;
	elseif dialogue.show == true then
		adachi.animation = adachi.animations.talk;
	else adachi.animation = adachi.animations.idle;
end
end