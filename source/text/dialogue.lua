require 'source.animating'
 start = love.timer.getTime()
result = 0
current = " "
dialogue = {}

function dialogue.draw()			
	if type(current) ~= "string"  then
		error("In dialogue.draw: must be a string")
	end
	if dialogue.show then	--probably should do 1 line at a time?	
	--	love.graphics.setColor(255,255,255,255)
		love.graphics.print(current, gameState.player.x, gameState.player.y)
		
	end
end

function dialogue.update(dt)
	if  love.timer.getTime() > result then
		dialogue.show = false
	end
end

function dialogue.set(pass, text)
	if dialogue.show == false then
		result = love.timer.getTime() + pass
		dialogue.show = true
		current = text
	end
end