require "objects.Shape"

Ball = Shape:extend()


function Ball:new(x, y, radius, color, fill_mode)

    Ball.super.new(self, x, y)
    self.radius = radius
    self.color = color
    self.fill_mode = fill_mode
    self.ball_x_dir = 1
    self.ball_y_dir = 1

end

function Ball:update(dt)

    if GAME_STATE == 1 then
        self.x = self.x + BALL_X_SPEED * dt * self.ball_x_dir
        self.y = self.y + BALL_Y_SPEED * dt * self.ball_y_dir
    end

    if self.x_up then
        BALL_X_SPEED = BALL_X_SPEED + -
        BALL_Y_SPEED = BALL_Y_SPEED + math.random(20)
        self.x_up = false
    end

    if Ball:is_coliding_with(self, PLAYER1) then
        self.ball_x_dir = self.ball_x_dir * -1
        --self.ball_y_dir = self.ball_y_dir * -1
        self.x_up = true
        print("PLAYER1" .. " colision")
    end

    if Ball:is_coliding_with(self, PLAYER2) then
        self.ball_x_dir = self.ball_x_dir * -1
        --self.ball_y_dir = self.ball_y_dir * -1
        print("PLAYER2" .. " colision")
    end


    for i, shape in ipairs(FIELD_SHAPES) do
        if Ball:is_coliding_with(self, shape.item) then
            print("collision" .. i)
            if shape.dir=="hor" then
                self.ball_y_dir = self.ball_y_dir * -1
            end
            if shape.dir=="vert" then
                self.ball_x_dir = self.ball_x_dir * -1
            end
        end

    end

end

function Ball:draw()
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.circle(self.fill_mode, self.x, self.y, self.radius)
end

function Ball:is_coliding_with(self, object)
    --print("self.x " .. self.x)
    --print("object.x + object.width " .. object.x + object.width)
    --print("self.x + BALL_RADIUS " .. self.x + BALL_RADIUS )
    --print("object.x " .. object.x)
    --print("self.y " .. self.y)
    --print("object.y + object.height " .. object.y + object.height)
    --print("BALL_RADIUS + self.y " .. BALL_RADIUS + self.y)
    --print("object.y " .. object.y)
    --print(self.x < object.x + object.width)
    --print(self.x + BALL_RADIUS > object.x)
    --print(self.y < object.y + object.height)
    --print(BALL_RADIUS + self.y > object.y)
    --print("--------------------------------------")
    if self.x < object.x + object.width and
            self.x + BALL_RADIUS > object.x and
            self.y < object.y + object.height and
            BALL_RADIUS + self.y > object.y then
        return true
    end
    return false
end



