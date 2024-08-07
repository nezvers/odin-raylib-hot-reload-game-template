package geometry2d


// Get intersection points where point intersects with point
intersects_point_point::proc(p1:Vec2, p2:Vec2)->(points:[1]Vec2, point_count:int){
    if (contains_point_point(p1, p2)){
        points[0] = p1
        point_count = 1
        return
    }
    return
}

// Get intersection points where line segment intersects with point
intersects_line_point::proc(l:Line, p:Vec2)->(points:[1]Vec2, point_count:int){
    if (contains_line_point(l, p)){
        points[0] = p
        point_count = 1
        return
    }
    return
}


// Get intersection points where rectangle intersects with point
// TODO: Side line check felt weird
intersects_rectangle_point::proc(r:Rect, p:Vec2)->(points:[1]Vec2, point_count:int){
    if (contains_rectangle_point(r,p)){
        points[0] = p
        point_count = 1
        return
    }
    // if (contains_line_point(rect_top, p)){
    //     return p
    // }
    // if (contains_line_point(rect_right, p)){
    //     return p
    // }
    // if (contains_line_point(rect_bottom, p)){
    //     return p
    // }
    // if (contains_line_point(rect_left, p)){
    //     return p
    // }
    return
}

// Get intersection points where Circle intersects with point
intersects_circle_point::proc(c:Circle, p:Vec2)->(points:[1]Vec2, point_count:int){
    if (vec2_mag2(vec2_abs(p - c.xy)) - (c.z * c.z) <= epsilon){
        points[0] = p
        point_count = 1
        return
    }
    return 
}

// Get intersection points where Triangle intersects with point
intersects_triangle_point::proc(t:Triangle, p:Vec2)->(points:[1]Vec2, point_count:int){
    if (contains_line_point(triangle_side(t, 0), p)){
        points[0] = p
        point_count = 1
        return
    }
    if (contains_line_point(triangle_side(t, 1), p)){
        points[0] = p
        point_count = 1
        return
    }
    if (contains_line_point(triangle_side(t, 2), p)){
        points[0] = p
        point_count = 1
        return
    }
    return
}

// Get intersection points where point intersects with line segment
intersects_point_line::proc(p:Vec2, l:Line)->(points:[1]Vec2, point_count:int){
    return intersects_line_point(l, p)
}

// Get intersection points where line segment intersects with line segment
intersects_line_line::proc(l1:Line, l2:Line)->(points:[1]Vec2, point_count:int){
    rd:f32 = vec2_cross(line_vector(l1), line_vector(l2))
    if (rd == 0){return}

    rd = 1 / rd
    rn:f32 = ((l2.z - l2.x) * (l1.y - l2.y) - (l2.w - l2.y) * (l1.x - l2.x)) * rd
    sn:f32 = ((l1.z - l1.x) * (l1.y - l2.y) - (l1.w - l1.y) * (l1.x - l2.x)) * rd

    if (rn < 0 || rn > 1 || sn < 0 || sn > 1){
        return
    }
    points[0] = l1.xy + rn * line_vector(l1)
    point_count = 1
    return
}

// Get intersection points where rectangle intersects with line segment
intersects_rectangle_line::proc(r:Rect, l:Line)->(points:[4]Vec2, point_count:int){
    for i in 0..<4{
        _points, _point_count: = intersects_line_line(rect_side(r, u32(i)), l)
        if (_point_count > 0){
            points[point_count] = _points[0]
            point_count += 1
        }
    }
    if point_count > 1{
        point_count = filter_duplicate_points(points[0:point_count])
    }
    return
}

// Get intersection points where Triangle intersects with line segment
intersects_triangle_line::proc(t:Triangle, l:Line)->(points:[4]Vec2, point_count:int){
    for i in 0..<3{
        _points, _point_count: = intersects_line_line(triangle_side(t, u32(i)), l)
        if (_point_count > 0){
            points[point_count] = _points[0]
            point_count += 1
        }
    }
    if point_count > 1{
        point_count = filter_duplicate_points(points[0:point_count])
    }
    return
}

// Get intersection points where Circle intersects with line segment
intersects_circle_line::proc(c:Circle, l:Line)->(points:[2]Vec2, point_count:int){
    closest_point_to_segment:Vec2 = closest_line_point(l, c.xy)
    if !overlaps_circle_point(c, closest_point_to_segment){
        return
    }
    
    // Compute point closest to the Circle on the line
    d:Vec2 = line_vector(l)
    u_line:f32 = vec2_dot(d, c.xy - l.xy) / vec2_mag2(d)
    closest_point_to_line:Vec2 = l.xy + u_line * d
    dist_to_line:f32 = vec2_mag2(c.xy - closest_point_to_line)

    if abs(dist_to_line - c.z * c.z) < epsilon{
        point_count += 1
        points[0] = closest_point_to_line 
        return
    }

    // Circle intersects the line
    length:f32 = sqrt(c.z * c.z - dist_to_line)

    p1:Vec2 = closest_point_to_line + vec2_norm(line_vector(l)) * length
    p2:Vec2 = closest_point_to_line - vec2_norm(line_vector(l)) * length

    if vec2_mag2(p1 - closest_line_point(l, p1)) < epsilon * epsilon{
        points[point_count] = p1
        point_count += 1
    }
    if vec2_mag2(p2 - closest_line_point(l, p2)) < epsilon * epsilon{
        points[point_count] = p2
        point_count += 1
    }
    
    if point_count > 1{
        point_count = filter_duplicate_points(points[0:point_count])
    }

    return
}

// Get intersection points where point intersects with rectangle
intersects_point_rectangle::proc(p:Vec2, r:Rect)->(points:[1]Vec2, point_count:int){
    return intersects_rectangle_point(r, p)
}

// Get intersection points where line intersects with rectangle
intersects_line_rectangle::proc(l:Line, r:Rect)->(points:[4]Vec2, point_count:int){
    return intersects_rectangle_line(r, l)
}