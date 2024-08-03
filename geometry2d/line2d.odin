package geometry2d


Line2D :: struct {	
	start: vec2d,
	end: vec2d,
}


line2d_vector :: proc(line:Line2D) -> vec2d {
	return {
		line.end.x - line.start.x,
		line.end.y - line.start.y,
	}
}