FIELD_SHAPES ={}

top_shape = {dir="hor", item=Rectangle(0, 0, SCREEN_WIDTH, 15, {red=0, green=1, blue=0}, "fill")}
bottom_shape = {dir="hor", item=Rectangle(0 , SCREEN_HEIGHT-15, SCREEN_WIDTH, 15, {red=0, green=1, blue=0}, "fill")}
right_shape = {dir="vert", item=Rectangle(SCREEN_WIDTH - 15 , 0, 15, SCREEN_HEIGHT, {red=0, green=1, blue=0}, "fill")}

table.insert(FIELD_SHAPES, top_shape)
table.insert(FIELD_SHAPES, bottom_shape)
--table.insert(FIELD_SHAPES, right_shape)



