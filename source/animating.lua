local anim8 = require 'source.lib.anim8.anim8'
require 'source.objects.key'
local image, animation
adachi = {}

-- this is mostly about the sprite's movement
  
function adachi.load()  
	log('In adachi.load: adachi loaded\n')
	image = love.graphics.newImage('img/spritesheetP.png')
	g = anim8.newGrid(99, 203, image:getWidth(), image:getHeight())
	animation = anim8.newAnimation(g('1-1',1), 0.2)
	adachi.y = 0	--what 		--!! bad commenting !!
	adachi.x = 0
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

function adachi.update(dt)  --!! bad: player code is named adachi and it's in animating lua and not player lua !!
	adachi.movement(dt)
	adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)		--!! Important: make gamestate a part of
	for shape, delta in pairs(HC.collisions(adachi.hitbox)) do				--animating.lua or change it to something !!
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
end

function adachi.movement(dt)									--!! what if we dont hardcode 
	wDown = false
	sDown = false													--the keys but define them somewhere in the setting
	aDown = false
	dDown = false													--&use vars instead !!
	if love.keyboard.isDown("w") then 
		wDown = true
   		gameState.player.y  = gameState.player.y  - 100 * dt
 		for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
			if shape:collidesWith(adachi.hitbox) then	
				gameState.player.y  = gameState.player.y + 100 * dt
			end
		end
	end

	if love.keyboard.isDown("s") then
		sDown = true
		gameState.player.y  = gameState.player.y + 100 * dt
		adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
		for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
			if shape:collidesWith(adachi.hitbox) then	
				gameState.player.y  = gameState.player.y - 100 * dt
			end
		end
		adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
	end 

	if love.keyboard.isDown("a") then 
		gameState.player.x  = gameState.player.x - 100 * dt
		for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
			if shape:collidesWith(adachi.hitbox) then	
				gameState.player.x  = gameState.player.x + 100 * dt
			end
		end
		aDown = true
	end
  
  
	if love.keyboard.isDown("d") then 
		dDown = true
		gameState.player.x  = gameState.player.x + 100 * dt
		for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
			if shape:collidesWith(adachi.hitbox) then	
				adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
			end
		end
	end
	
	
	if wDown == true then								--!! cases instead of if !!
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