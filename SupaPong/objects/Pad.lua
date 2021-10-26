require "objects.Rectangle"

Pad = Rectangle:extend()


function Pad:new(x, y, width, height, color, fill_type, control_num)
    Pad.super.new(self, x, y, width, height, color, fill_type)
    self.control_num = control_num
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
end



