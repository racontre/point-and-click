intro = {}
intro.loaded = false
function intro.load()
	intro = {}
	intro.bg = love.graphics.newImage('img/oz_screen6.jpg')
	intro.rect = HC.rectangle(200, 400, 400, 20)
	intro.couch = HC.rectangle(150, 500, 300, 50)
end
function intro.unload()
	intro = nil
end
function intro.draw()
	love.graphics.draw(intro.bg)
	intro.rect:draw('fill')
	intro.couch:draw('fill')
end
function intro.update(dt)
	return
end