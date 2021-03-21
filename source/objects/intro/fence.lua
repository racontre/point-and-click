anim8 = require 'source.lib.anim8.anim8'

grid = anim8.newGrid(32, 32, 580, 121)
fenceObject =		
{
	name = 'wall',
	colides = true,
	destructible = false,
	colImg = 'img/fenceCol.png',
	image = 'img/keycol.png',
	animation = anim8.newAnimation(grid('1-8',1), 0.1),
	comment = 'We can\'t go any further. '
}

