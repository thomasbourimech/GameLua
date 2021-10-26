require "objects.Rectangle"

Pad = Rectangle:extend()


function Pad:new(x, y, width, height, color, fill_type, control_num)
    Pad.super.new(self, x, y, width, height, color, fill_type)
    self.control_num = control_num
    self.arkanoid_atlas = love.graphics.newImage("gfx/pads_sheet.png")

    self.pad_sprite = love.graphics.newQuad(PAD_SHEET_X_POS, PAD_SHEET_Y_POS, PAD_SHEET_WIDTH, PAD_SHEET_HEIGHT,
                                            self.arkanoid_atlas:getDimensions())
    self.pad_sprite_x, self.pad_sprite_y, self.pad_sprite_width, self.pad_sprite_height = self.pad_sprite:getViewport()


    self.x_resize_factor = self:get_x_resize_paddle_sprite_factor()
    self.y_resize_factor = self:get_y_resize_paddle_sprite_factor()
end

function Pad:load()

end

function Pad:update(dt)

    local joysticks = love.joystick.getJoysticks()
    local joystick = joysticks[self.control_num]
    if not joystick then return end

    if joystick:isGamepadDown("dpup") then
        self.y = self.y - PAD_Y_SPEED * dt
        GAME_STATE=1
    end
    if joystick:isGamepadDown("dpdown") then
        self.y = self.y + PAD_Y_SPEED * dt
        GAME_STATE=1
    end

    self.x_resize_factor = self:get_x_resize_paddle_sprite_factor()
    self.y_resize_factor = self:get_y_resize_paddle_sprite_factor()

end

function Pad:get_y_resize_paddle_sprite_factor()
    y_factor = self.super.get_width(self) / self.pad_sprite_width
    print(self.super.get_width(self))
    print(self.pad_sprite_width)
    print("y factor:" .. y_factor)
    return y_factor
end

function Pad:get_x_resize_paddle_sprite_factor()

    x_factor = self.super.get_height(self) / self.pad_sprite_height
    print(self.super.get_height(self))
    print(self.pad_sprite_height)
    print("x factor:" .. x_factor)
    return x_factor
end

function Pad:rotate(angle)
     self.angle = angle
end

function Pad:map_texture()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    if self.control_num == 1 then
        self:rotate(0)
    else
        self:rotate(-180)
    end
    if self.control_num == 1 then
        love.graphics.draw(self.arkanoid_atlas,self.pad_sprite, self.x, self.y, math.rad(self.angle),
                self.y_resize_factor,
                self.x_resize_factor,
                0,0)
    else
        love.graphics.draw(self.arkanoid_atlas,self.pad_sprite, self.x + self.super.get_width(self) , self.y + self.super.get_height(self), math.rad(self.angle),
                self.x_resize_factor,
                self.y_resize_factor,
                0,0)
    end

end

function Pad:draw(dt)
    Pad.super.draw(self)
    self:map_texture()
end

