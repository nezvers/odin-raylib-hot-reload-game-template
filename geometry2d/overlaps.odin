package geometry2d

// Check if point overlaps with point (analogous to contains())
overlaps_point_point::proc(p1:Vec2, p2:Vec2)->bool{
    return contains_point_point(p1, p2)
}

// Checks if line segment overlaps with point
overlaps_line_point::proc(l:Line, p:Vec2)->bool{
    return contains_line_point(l, p)
}

// Checks if rectangle overlaps with point
overlaps_rectangle_point::proc(r:Rect, p:Vec2)->bool{
    return contains_rectangle_point(r, p)
}

// Checks if Circle overlaps with point
overlaps_circle_point::proc(c:Circle, p:Vec2)->bool{
    return contains_circle_point(c, p)
}

// Checks if Triangle overlaps with point
overlaps_triangle_point::proc(t:Triangle, p:Vec2)->bool{
    return contains_triangle_point(t, p)
}

// Checks if point overlaps with line
overlaps_point_line::proc(p:Vec2, l:Line)->bool{
    return contains_line_point(l, p)
}

// Checks if line overlaps with line
overlaps_line_line::proc(l1:Line, l2:Line)->bool{
    D:f32 = (l2.w - l2.y) * (l1.z - l1.x) - (l2.z - l2.x) * (l1.w - l1.y)
    uA:f32 = ((l2.z - l2.x) * (l1.y - l2.y) - (l2.w - l2.y) * (l1.x - l2.x)) / D
    uB:f32 = ((l1.z - l1.x) * (l1.y - l2.y) - (l1.w - l1.y) * (l1.x - l2.x)) / D
    return uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1
}

// Checks if rectangle overlaps with line
overlaps_rectangle_line::proc(r:Rect, l:Line)->bool{
    return contains_rectangle_line(r, l) || overlaps_line_line(rect_top(r), l) || overlaps_line_line(rect_right(r), l) || overlaps_line_line(rect_bottom(r), l) || overlaps_line_line(rect_left(r), l)
}

// Checks if Circle overlaps with line
overlaps_circle_line::proc(c:Circle, l:Line)->bool{
    p:Vec2 = closest_line_point(l, c.xy)
    return vec2_mag2(c.xy - p) <= (c.z * c.z)
}

// Check if Triangle overlaps line segment
overlaps_triangle_line::proc(t:Triangle, l:Line)->bool{
    return overlaps_triangle_point(t, l.xy) || overlaps_line_line(triangle_side(t, 0), l) || overlaps_line_line(triangle_side(t, 1), l) || overlaps_line_line(triangle_side(t, 2), l)
}

// Checks if point overlaps with rectangle
overlaps_point_rectangle::proc(p:Vec2, r:Rect)->bool{
    return overlaps_rectangle_point(r, p)
}

// Checks if line overlaps with rectangle
overlaps_line_rectangle::proc(l:Line, r:Rect)->bool{
    return overlaps_rectangle_line(r, l)
}

// Checks if rectangle overlaps with rectangle
overlaps_rectangle_rectangle::proc(r1:Rect, r2:Rect)->bool{
    return contains_rectangle_rectangle(r2, r1)
}


// Check if Circle overlaps rectangle
overlaps_c2r::proc(c:Circle, r:Rect)->bool{
    overlap:f32 = vec2_mag2(Vec2{clamp(c.x, r.x, r.x + r.z), clamp(c.y, r.y, r.y + r.w)} - c.xy)
    if isnan(overlap){overlap = 0}
    return (overlap - (c.z * c.z)) < 0
}

// Check if Triangle overlaps rectangle
overlaps_t2r::proc(t:Triangle, r:Rect)->bool{
    return overlaps_triangle_line(t, rect_top(r)) || overlaps_triangle_line(t, rect_right(r)) || overlaps_triangle_line(t, rect_bottom(r)) || overlaps_triangle_line(t, rect_left(r)) || contains_rectangle_point(r, t[0])
}