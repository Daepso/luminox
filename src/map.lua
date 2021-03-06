map = {}
map.grid = {}
map.width = 0
map.height = 0
map.spawn_x = 0
map.spawn_y = 0

map.exit_x = 0
map.exit_y = 0

map._cubeColor = {255,255,255}
map._spawnColor = {50,50,200}
map._exitColor = {200,50,50}

function map.generate(width, height, seed)
	math.randomseed(seed)
	map.width = width
	map.height = height
	for y=0, width do
		map.grid[y] = {}
		for x=0, height do
			if y == 0 or x ==0 or x == map.height or y == map.width then 
				map.grid[y][x] = 1
			else
				map.grid[y][x] = math.random(10)
				if map.grid[y][x] ~= 1 then
					map.grid[y][x] = 0
				end
			end
		end
	end
	map.spawn_x = math.random(map.height-1)
	map.spawn_y = math.random(map.width-1)
	map.grid[map.spawn_y][map.spawn_x] = 0
	
	map.exit_x = math.random(map.height-1)
	map.exit_y = math.random(map.width-1)
	map.grid[map.exit_y][map.exit_x] = 0
end


function map.draw(posX, posY)
	minX = math.max(0,math.floor((posX-love.graphics.getWidth()/2)/32))
	maxX = math.min(map.width,math.floor((posX+love.graphics.getWidth()/2)/32)+1)
	minY = math.max(0,math.floor((posY-love.graphics.getHeight()/2)/32))
	maxY = math.min(map.height,math.floor((posY+love.graphics.getHeight()/2)/32)+1)
	for y=minY, maxY do
		for x=minX, maxX do
			if map.grid[y][x] == 1 then
				love.graphics.setColor(map._cubeColor)
				love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
			end
		end
	end
	
	love.graphics.setColor(map._exitColor)
	love.graphics.rectangle("fill", map.exit_x * 32, map.exit_y * 32, 32, 32)
	
	love.graphics.setColor(map._spawnColor)
	love.graphics.rectangle("fill", map.spawn_x * 32, map.spawn_y * 32, 32, 32)
end

function map.testCollision(x, y)
	x_grid = math.floor(x/32)
	y_grid = math.floor(y/32)
	if x_grid < 0 or y_grid < 0 or x_grid > map.height or y_grid > map.width or map.grid[y_grid][x_grid] == 1 then
        return true
    end
    return false
end

function map.testExit(x,y)
	x_grid = math.floor(x/32)
	y_grid = math.floor(y/32)
	if y_grid == map.exit_y and x_grid == map.exit_x then
        return true
    end
    return false
end