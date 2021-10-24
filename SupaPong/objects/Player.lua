Object = require "lib.classic"
require "objects.Pad"

Player =  Object:extend()

function Player:new(player_id, control_num, p_name)
    self.width = PAD_WIDTH
    self.height = PAD_HEIGHT
    if player_id == 1 then
        self.pad = Pad(0,SCREEN_HEIGHT/2 - self.height/2,
                       self.width,
                       self.height,
                       {red=0,green=255,blue=0},
                       "fill",
                       control_num)
    else
        self.pad = Pad(SCREEN_WIDTH - self.width,
                       SCREEN_HEIGHT/2 - self.height/2,
                      self.width,
                       self.height,
                       {red=255,green=0,blue=0},
                       "fill",
                       control_num)
    end

    self.p_name = p_name
end

function Player:draw()
    self.pad:draw()
end

function Player:update(dt)
    self.pad:update(dt)
    self.x = self.pad.x
    self.y = self.pad.y
end