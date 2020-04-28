require 'source.global.objects'
require 'source.text.dialogue'
require 'source.animating'
require ("source/objects/key")
require ("source/objects/intro/fence")
intro = {}

intro.loaded = false
function intro.set()
	
	gameState.player.x = 50
	gameState.player.у = 250
	
end

function introreceivepoly(_type, msg) --object monitoring function
	log("Received polygon message type " .. tostring(_type) .. " message " .. tostring(msg) .. "\n")
	if (_type == MESSAGE_CLICK) then
		if (msg == 11 or msg == 12 or msg == 13) then		
			introobjects:DestroyObject(msg)
			dialogue.set(5, keyObject.comment)
		end
		if (msg == 14) then
			dialogue.set(5, fenceObject.comment)
		end
		else dialogue.set(2, 'Nothing unusual.')
	end
end
function intro.load()
	dialogue.show = false
	adachi.animation = adachi.animations.idle;
	bg = love.graphics.newImage('img/bgforest.png')
	rect = HC.rectangle(200, 400, 400, 20)
	couch = HC.rectangle(150, 500, 300, 50)
	gameState.player.x = 50
	gameState.player.y = 200
	introobjects = objects:create()
	introobjects:subscribe(introreceivepoly) --esli s tochkoi to intro.receivepoly budet nil v object subscribers
		introobjects:CreateObject(14, fenceObject.colImg, fenceObject.image)
		
		introobjects:CreateObject(11, 'img/keycol.png', 'img/key.png')
		introobjects:MoveObject(11, 300, 100, 5)
		
		introobjects:CreateObject(12, 11, 11)
		introobjects:MoveObject(12, 475, 475, 1)
		
		introobjects:CreateObject(13, keyObject.colImg, keyObject.image)
		introobjects:MoveObject(13, 350, 450, 3)
		
		
		

end
function intro.unload()			--function is unused --apparently not
	--intro = nil				
	log('intro is nil!')
end
function intro.draw()
	love.graphics.draw(bg)
	rect:draw('fill')
	couch:draw('fill')
	introobjects:draw()
	love.graphics.print('timer '  .. result - love.timer.getTime(), 75, 0)
end	
function intro.update(dt)
	return
end
