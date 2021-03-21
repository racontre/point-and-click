anim8 = require 'source.lib.anim8.anim8'

grid = anim8.newGrid(32, 32, 580, 121)
keyObject =		
{
	name = 'key',
	colides = true,
	destructible = true,
	colImg = 'img/keycol.png',
	image = 'img/key.png',
	animation = anim8.newAnimation(grid('1-8',1), 0.1),
	comment = 'haha epic'
}

