package geometry2d

// start = x,y
// end = z, w
Line2D :: [4]f32

line2D_new::proc(start:Vec2D, end:Vec2D)->Line2D{
	return Line2D{start.x, start.y, end.x, end.y}
}

// Get vector pointing from start to end
line2d_vector :: proc(line: Line2D) -> Vec2D {
	start:Vec2D = line.xy
	end:Vec2D = line.zw
	return {
		end.x - start.x,
		end.y - start.y,
	}
}

// Get length of line
line2d_length :: proc(line: Line2D) -> f32 {
	vector:Vec2D = line2d_vector(line)
	return vec2d_mag(vector)
}

// Get length of line^2
line2d_length2 :: proc(line: Line2D) -> f32 {
	vector:Vec2D = line2d_vector(line)
	return vec2d_mag2(vector)
}

// Given a real distance, get point along line
line2d_rpoint :: proc(line: Line2D, distance:f32) -> Vec2D {
	vector:Vec2D = line2d_vector(line)
	return line.xy + vec2d_norm(vector) * distance
}

// Given a real distance, get point along line
line2d_upoint :: proc(line: Line2D, distance:f32) -> Vec2D {
	vector:Vec2D = line2d_vector(line)
	return line.xy + vector * distance
}

// Return which side of the line does a point lie
line2d_side :: proc(line: Line2D, point:Vec2D) -> i32 {
	vector:Vec2D = line2d_vector(line)
	cross:f32 = vec2d_cross(vector, point - line.xy)
	
	if (0.0 < cross){
		return 1
	}
	else if (cross < 0.0){
		return -1
	}
	else{
		return 0
	}
}

// Returns line equation "mx + a" coefficients where:
// NOTE: Returns {inf, inf} if abs(end.x - start.x) < epsilon:
line2d_coefficients :: proc(line:Line2D) -> Vec2D{
	x1: = line.x
	x2: = line.z
	y1: = line.y
	y2: = line.w

	if (abs(x1 - x2) < epsilon){
		return {INF_F32, INF_F32}
	}
	m: = (y2 - y1) / (x2 - x1)
	return {m, -m * x1 + y1}
}


