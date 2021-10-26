require "objects.Player"
require "objects.field"
require "create_field"
require "objects.Ball"



PLAYER1 = Player(1, 1, "OrelSan")
PLAYER2 = Player(2, 2, "Hajime Isayama")
BALL = Ball(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, BALL_RADIUS, {red=0, green=1, blue=0}, "fill")
GAME_STATE = 0
--0 -> ball at center
--1 -> ball moving


function love.load()
    FIELD = Field(FIELD_SHAPES)
end

function love.update(dt)
    PLAYER1:update(dt)
    PLAYER2:update(dt)
    BALL:update(dt)
end


function love.draw()
    FIELD:draw()
    PLAYER1:draw()
    PLAYER2:draw()
    BALL:draw()
end
