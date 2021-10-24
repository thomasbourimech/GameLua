function love.load()
    rect_list={}
    nb=0
end

function love.update(dt)
    for i,v in  ipairs(rect_list) do
        if v.direction == 1 then
            v.x = v.x + v.speed * dt
        elseif v.direction == 2 then
            v.x = v.x - v.speed * dt
        elseif v.direction == 3 then
            v.y = v.y + v.speed * dt
        else
            v.y = v.y - v.speed * dt
        end


end

function love.draw()
    for i,v in ipairs(rect_list) do
        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
    end

end

function create_rect()
    rect = {}
    rect.x = 100
    rect.y = 100
    rect.width = 10
    rect.height = 10
    rect.speed = 200
    rect.nb = nb
    rect.direction = math.random(1,4)
    nb = nb+1
    table.insert(rect_list, rect)
end

function love.keypressed(key)

    if key == "space" then
        create_rect()
    end

end
    --if x < (599 + x_start) then
    --    if love.keyboard.isDown("right") then
    --        x = x + move_speed * dt
    --    end
    --end
    --
    --if x > 1  then
    --    if love.keyboard.isDown("left") then
    --        x = x - move_speed  * dt
    --    end
    --end
    --
    --if y < 499 then
    --    if love.keyboard.isDown("down") then
    --        y = y + move_speed * dt
    --    end
    --end
    --
    --if y > 1 then
    --    if love.keyboard.isDown("up") then
    --        y = y - move_speed * dt
    --    end
    --end


end