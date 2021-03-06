Object = require "lib.classic"
require ".objects.Textured_Pad"

Player =  Object:extend()

function Player:new(player_id, control_num, p_name)
    self.width = PAD_WIDTH
    self.height = PAD_HEIGHT
    self.player_id = player_id
    if self.player_id == 1 then
        self.pad = Textured_Pad(0,SCREEN_HEIGHT/2 - self.height/2,
                       self.width,
                       self.height,
                       {red=0,green=1,blue=0},
                       "line",
                       control_num,self.player_id)
    else
        self.pad = Textured_Pad(SCREEN_WIDTH - self.width,
                       SCREEN_HEIGHT/2 - self.height/2,
                      self.width,
                       self.height,
                       {red=0,green=1,blue=0},
                       "line",
                       control_num,self.player_id)
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