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
    love.graphics.setColor(1,0,0)
    love.graphics.points(self.x+1, self.y+1)
    love.graphics.points(self.x+2, self.y+2)
    love.graphics.print( self.x..","..self.y, self.x, self.y, 0, 1,1,0,0)
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.rectangle(self.fill_type, self.x, self.y, self.width, self.height)
    love.graphics.reset()
end