Field = Object:extend()


function Field:new(shape_table)
    self.shape_table = shape_table
end

function Field:draw()
    for i, shape in ipairs(self.shape_table) do
        shape.item:draw()
    end
end