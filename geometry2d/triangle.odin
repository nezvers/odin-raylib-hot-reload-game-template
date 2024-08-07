package geometry2d

Triangle::[3]Vec2

// Get a line from an indexed side, starting top, going clockwise
triangle_side::proc(Triangle:Triangle, i:u32)->Line{
	return line2D_new(Triangle[i % 3], Triangle[(i +1) % 3])
}

// Get area of Triangle
triangle_area::proc(Triangle:Triangle)->f32{
	return 0.5 * abs(
		(Triangle[0].x * (Triangle[1].y - Triangle[2].y)) +
		(Triangle[1].x * (Triangle[2].y - Triangle[0].y)) +
		(Triangle[2].x * (Triangle[0].y - Triangle[1].y))
	)
}

// Get perimeter of Triangle
triangle_perimeter::proc(Triangle:Triangle)->f32{
	l1:f32 = line_length(line2D_new(Triangle[0], Triangle[1]))
	l2:f32 = line_length(line2D_new(Triangle[1], Triangle[2]))
	l3:f32 = line_length(line2D_new(Triangle[2], Triangle[0]))
	return l1 + l2 + l3
}

// Returns side count: 3
triangle_size_count::proc(Triangle:Triangle)->u32{
	return 3
}

