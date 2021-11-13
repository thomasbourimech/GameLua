require "objects.Shape"

Ball = Shape:extend()


function Ball:new(x, y, radius, color, fill_mode)

    Ball.super.new(self, x, y)
    self.radius = radius
    self.color = color
    self.fill_mode = fill_mode
    self.ball_x_dir = 1
    self.ball_y_dir = 1
    self.x_previous = SCREEN_WIDTH/2
    self.iter_nb = 0
    self.speed_x = 0
    self.speed_y = 0

end

function Ball:compute_velocity(pos2, pos1, dt)
    print("dt:"..dt.." abs diff:"..math.abs(pos2-pos1))
    return math.abs(pos2-pos1) / dt
end

function Ball:compute_potential_next_x_pos(dt)
    return self.x + self.ball_x_dir * dt * self.speed_x
end
function Ball:compute_potential_next_y_pos(dt)
    return self.y + self.ball_y_dir * dt * self.speed_y
end

function Ball:no_overflow_speed_decrease_left(dt)
    return (PAD_WIDTH - self.x - self.ball_x_dir) / dt
end

function Ball:no_overflow_reset_position(dt, side, next_x, next_y)

    if side == "L" then
        if self:is_coliding_with_on_y(next_y, PLAYER1) then
            print("RESETTING from "..self.x.." to "..PAD_WIDTH.." BECAUSE collision with PLAYER1 detected")
            self.x = PAD_WIDTH + 1
            return
        end
    elseif side == "R" then
        if self:is_coliding_with_on_y(next_y, PLAYER2) then
            print("RESETTING from "..self.x.." to "..SCREEN_WIDTH - PAD_WIDTH.." BECAUSE collision with PLAYER1 detected")
            self.x = SCREEN_WIDTH - PAD_WIDTH
            return
        end
    end

    GAME_STATE = 0


end

function Ball:update(dt)

    print("velocity x: "..self.speed_x.."x: "..self.x..", y: "..self.y)
    if GAME_STATE == 0 then
        self.ball_x_dir = - self.ball_x_dir --Change ball direction @each point
        self.x = SCREEN_WIDTH / 2
        self.y = SCREEN_HEIGHT / 2
        self.speed_x = 0
        self.speed_y = 0
        BALL_X_SPEED = 400
        BALL_Y_SPEED = 400
    end

    if GAME_STATE == 1 then
        self.speed_x = BALL_X_SPEED
        self.speed_y = BALL_Y_SPEED
        self.x = self.x + self.speed_x * dt * self.ball_x_dir
        --self.y = self.y + self.speed_y * dt * self.ball_y_dir
    end

    if self.speed_up then

        if BALL_X_SPEED < 6000 then
            BALL_X_SPEED = BALL_X_SPEED + 30
        end
        self.speed_up = false
    end


    next_x = self:compute_potential_next_x_pos(dt)
    next_y = self:compute_potential_next_y_pos(dt)

    if (next_x < PAD_WIDTH) then
        print("LEFT OVERFLOW DETECTED! next x,y:"..next_x..", "..next_y)
        self:no_overflow_reset_position(dt,"L",  next_x, next_y)
    end
    if (next_x > SCREEN_WIDTH - PAD_WIDTH) then
        print("RIGHT OVERFLOW DETECTED! next x,y:"..next_x..", "..next_y)
        self:no_overflow_reset_position(dt,"R", next_x, next_y)
    end

    if Ball:is_coliding_with(self, PLAYER1) then
        self.ball_x_dir = self.ball_x_dir * -1
        self.x = self.x + BALL_RADIUS
        self.speed_up = true
        print("PLAYER1" .. " colision")
        self.iter_nb=0
    end

    if Ball:is_coliding_with(self, PLAYER2) then
        self.ball_x_dir = self.ball_x_dir * -1
        self.x = self.x - BALL_RADIUS
        self.speed_up = true
        print("PLAYER2" .. " colision")
        self.iter_nb=0
    end


    for i, shape in ipairs(FIELD_SHAPES) do
        if Ball:is_coliding_with(self, shape.item) then
            print("collision" .. i)
            if shape.dir=="hor" then
                if self.y < 15 + BALL_RADIUS then
                    self.y = 15 + BALL_RADIUS
                end
                if self.y > SCREEN_HEIGHT - 15 - BALL_RADIUS then
                    self.y = SCREEN_HEIGHT - 15 - BALL_RADIUS
                end
                self.ball_y_dir = self.ball_y_dir * -1
            end
            if shape.dir=="vert" then
                self.ball_x_dir = self.ball_x_dir * -1
            end
        end
    end

    if self.x > SCREEN_WIDTH or self.x < 0 then  --Point
            self.ball_x_dir = self.ball_x_dir * -1

            self.x = SCREEN_WIDTH / 2
            self.y = SCREEN_HEIGHT / 2
            self.speed_x = 0
            self.speed_y = 0
            GAME_STATE = 0

            --os.exit()
    end

    self.x_previous = self.x
    self.iter_nb = self.iter_nb + 1
end

function Ball:draw()
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.circle(self.fill_mode, self.x, self.y, self.radius)
end

function Ball:is_coliding_with_on_y(y, object)
    if  y - BALL_RADIUS < object.y + object.height and
        BALL_RADIUS + y > object.y then
        print("collision with ball on y axis")
        return true
    end
    return false
end
function Ball:is_coliding_with(self, object)
    if self.x - BALL_RADIUS < object.x + object.width and
            self.x + BALL_RADIUS > object.x and
            self.y - BALL_RADIUS < object.y + object.height and
            BALL_RADIUS + self.y > object.y then
        print("collision with ball detected on x, y :"..self.x..", "..self.y)
        return true
    end
    return false
end



