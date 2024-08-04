package geometry2d

// pos = x, y
// size = z, w
Rect2D::[4]f32

rect2d_middle::proc(rect:Rect2D)->Vec2D{
	pos:Vec2D = rect.xy
	size:Vec2D = rect.zw
	return {pos.x, pos.y} + (size * {0.5, 0.5})
}

// Get line segment from top side of rectangle
rect2d_top::proc(rect:Rect2D)->Line2D{
	pos:Vec2D = rect.xy
	size:Vec2D = rect.zw
	return line2D_new({pos.x, pos.y}, {pos.x + size.x, pos.y})
}

// Get line segment from bottom side of rectangle
rect2d_bottom::proc(rect:Rect2D)->Line2D{
	pos:Vec2D = rect.xy
	size:Vec2D = rect.zw
	return line2D_new({pos.x, pos.y + size.y}, pos + size)
}

// Get line segment from left side of rectangle
rect2d_left::proc(rect:Rect2D)->Line2D{
	pos:Vec2D = rect.xy
	size:Vec2D = rect.zw
	return line2D_new({pos.x, pos.y}, {pos.x, pos.y + size.y})
}

// Get line segment from right side of rectangle
rect2d_right::proc(rect:Rect2D)->Line2D{
	pos:Vec2D = rect.xy
	size:Vec2D = rect.zw
	return line2D_new({pos.x + size.x, pos.y}, pos + size)
}

// Get a line from an indexed side, starting top, going clockwise
rect2d_side::proc(rect:Rect2D, i:u32)->Line2D{
	list: = [4]proc(Rect2D)->Line2D{rect2d_top, rect2d_right, rect2d_bottom, rect2d_left}
	return list[i](rect)
}

// Get area of rectangle
rect2d_area::proc(rect:Rect2D)->f32{
	return rect.z * rect.w
}

// Get perimeter of rectangle
rect2d_perimeter::proc(rect:Rect2D)->f32{
	return 2.0 * (rect.z + rect.w)
}

// Returns side count: 4
rect2d_side_count::proc(rect:Rect2D)->u32{
	return 4
}



