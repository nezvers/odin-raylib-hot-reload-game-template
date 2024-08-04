package geometry2d

Triangle2D::[3]Vec2D

// Get a line from an indexed side, starting top, going clockwise
triangle2d_side::proc(triangle:Triangle2D, i:u32)->Line2D{
	return line2D_new(triangle[i % 3], triangle[(i +1) % 3])
}

// Get area of triangle
triangle2d_area::proc(triangle:Triangle2D)->f32{
	return 0.5 * abs(
		(triangle[0].x * (triangle[1].y - triangle[2].y)) +
		(triangle[1].x * (triangle[2].y - triangle[0].y)) +
		(triangle[2].x * (triangle[0].y - triangle[1].y))
	)
}

// Get perimeter of triangle
triangle2d_perimeter::proc(triangle:Triangle2D)->f32{
	l1:f32 = line2d_length(line2D_new(triangle[0], triangle[1]))
	l2:f32 = line2d_length(line2D_new(triangle[1], triangle[2]))
	l3:f32 = line2d_length(line2D_new(triangle[2], triangle[0]))
	return l1 + l2 + l3
}

// Returns side count: 3
triangle2d_size_count::proc(triangle:Triangle2D)->u32{
	return 3
}

