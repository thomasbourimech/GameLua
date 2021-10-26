require "objects.Shape"

Rectangle = Shape:extend()

function Rectangle:new(x, y, width, height, color, fill_type)

    Rectangle.super.new(self, x, y)
    self.width = width
    self.height = height
    self.color = color
    self.fill_type = fill_type
end

function Rectangle:get_width()
    return self.width
end

function Rectangle:get_height()
    return self.height
end

function Rectangle:draw()

    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.rectangle(self.fill_type, self.x, self.y, self.width, self.height)
    love.graphics.reset()
end