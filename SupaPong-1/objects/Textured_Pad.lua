require "objects.Rectangle"

Textured_Pad = Rectangle:extend()




function Textured_Pad:new(x, y, width, height, color, fill_type, control_num,player_id)

    self.fps = 120
    self.anim_timer = 1 / self.fps
    self.frame = 0
    self.num_frames = 6
    self.xoffset=0
    self.player_id = player_id
    self.control_num = control_num
    self.arkanoid_atlas = love.graphics.newImage("gfx/pads_sheet.png")

    self.pad_sprite = love.graphics.newQuad(PAD_SHEET_X_POS, PAD_SHEET_Y_POS, PAD_SHEET_WIDTH, PAD_SHEET_HEIGHT,
                                            self.arkanoid_atlas:getDimensions())
    self.pad_sprite_x, self.pad_sprite_y, self.pad_sprite_width, self.pad_sprite_height = self.pad_sprite:getViewport()

    Textured_Pad.super.new(self, x, y, self.pad_sprite_width, self.pad_sprite_height, color, fill_type)
end

function Textured_Pad:load()

end

function Textured_Pad:update(dt)

    local joysticks = love.joystick.getJoysticks()
    local joystick = joysticks[self.control_num]
    if not joystick then return end

    if joystick:isGamepadDown('a') and KICK_OFF_PLAYER_ID == self.player_id then
        GAME_STATE = 1
    end

    if joystick:isGamepadDown("dpup") then
    if self.y < 15 then
    self.y = 15
    end
    self.y = self.y - PAD_Y_SPEED * dt
    end
    if joystick:isGamepadDown("dpdown") then
    if self.y > SCREEN_HEIGHT - PAD_HEIGHT - 15 then
    self.y = SCREEN_HEIGHT - PAD_HEIGHT - 15
    end
    self.y = self.y + PAD_Y_SPEED * dt
    end


    self.anim_timer = self.anim_timer - dt

    if self.anim_timer <= 0 then
    self.anim_timer = 1 / self.fps
    if self.frame > self.num_frames then
    self.frame = 0
    end
    self.xoffset = PAD_QUAD_WIDTH * self.frame
    self.pad_sprite:setViewport(self.xoffset, PAD_SHEET_Y_POS,PAD_SHEET_WIDTH, PAD_SHEET_HEIGHT)
    self.frame = self.frame + 1
    end


end

function Textured_Pad:get_y_resize_paddle_sprite_factor()
    y_factor = self.super.get_width(self) / self.pad_sprite_width
    return y_factor
end

function Textured_Pad:get_x_resize_paddle_sprite_factor()

    x_factor = self.super.get_height(self) / self.pad_sprite_height
    return x_factor
end

function Textured_Pad:rotate(angle)
     self.angle = angle
end

function Textured_Pad:map_texture()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    if self.control_num == 1 then
        self:rotate(0)
        love.graphics.draw(self.arkanoid_atlas,self.pad_sprite, self.x, self.y, math.rad(self.angle),
                1,1,0,0)
    else

        self:rotate(-180)
        love.graphics.draw(self.arkanoid_atlas,self.pad_sprite, self.x + self.super.get_width(self) , self.y + self.super.get_height(self), math.rad(self.angle),
                1,1,0,0)
    end

end

function Textured_Pad:draw(dt)
    --Textured_Pad.super.draw(self)
    self:map_texture()
end

