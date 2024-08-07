package geometry2d


// Get intersection points where point intersects with point
intersects_p2p::proc(p1:Vec2D, p2:Vec2D)->(points:[1]Vec2D, point_count:int){
    if (contains_p2p(p1, p2)){
        points[0] = p1
        point_count = 1
        return
    }
    return
}

// Get intersection points where line segment intersects with point
intersects_l2p::proc(l:Line2D, p:Vec2D)->(points:[1]Vec2D, point_count:int){
    if (contains_l2p(l, p)){
        points[0] = p
        point_count = 1
        return
    }
    return
}


// Get intersection points where rectangle intersects with point
// TODO: Side line check felt weird
intersects_r2p::proc(r:Rect2D, p:Vec2D)->(points:[1]Vec2D, point_count:int){
    if (contains_r2p(r,p)){
        points[0] = p
        point_count = 1
        return
    }
    // if (contains_l2p(rect2d_top, p)){
    //     return p
    // }
    // if (contains_l2p(rect2d_right, p)){
    //     return p
    // }
    // if (contains_l2p(rect2d_bottom, p)){
    //     return p
    // }
    // if (contains_l2p(rect2d_left, p)){
    //     return p
    // }
    return
}

// Get intersection points where circle intersects with point
intersects_c2p::proc(c:Circle2D, p:Vec2D)->(points:[1]Vec2D, point_count:int){
    if (vec2d_mag2(vec2d_abs(p - c.xy)) - (c.z * c.z) <= epsilon){
        points[0] = p
        point_count = 1
        return
    }
    return 
}

// Get intersection points where triangle intersects with point
intersects_t2p::proc(t:Triangle2D, p:Vec2D)->(points:[1]Vec2D, point_count:int){
    if (contains_l2p(triangle2d_side(t, 0), p)){
        points[0] = p
        point_count = 1
        return
    }
    if (contains_l2p(triangle2d_side(t, 1), p)){
        points[0] = p
        point_count = 1
        return
    }
    if (contains_l2p(triangle2d_side(t, 2), p)){
        points[0] = p
        point_count = 1
        return
    }
    return
}

// Get intersection points where point intersects with line segment
intersects_p2l::proc(p:Vec2D, l:Line2D)->(points:[1]Vec2D, point_count:int){
    return intersects_l2p(l, p)
}

// Get intersection points where line segment intersects with line segment
intersects_l2l::proc(l1:Line2D, l2:Line2D)->(points:[1]Vec2D, point_count:int){
    rd:f32 = vec2d_cross(line2d_vector(l1), line2d_vector(l2))
    if (rd == 0){return}

    rd = 1 / rd
    rn:f32 = ((l2.z - l2.x) * (l1.y - l2.y) - (l2.w - l2.y) * (l1.x - l2.x)) * rd
    sn:f32 = ((l1.z - l1.x) * (l1.y - l2.y) - (l1.w - l1.y) * (l1.x - l2.x)) * rd

    if (rn < 0 || rn > 1 || sn < 0 || sn > 1){
        return
    }
    points[0] = l1.xy + rn * line2d_vector(l1)
    point_count = 1
    return
}

// Get intersection points where rectangle intersects with line segment
intersects_r2l::proc(r:Rect2D, l:Line2D)->(points:[4]Vec2D, point_count:int){
    for i in 0..<4{
        _points, _point_count: = intersects_l2l(rect2d_side(r, u32(i)), l)
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

// Get intersection points where triangle intersects with line segment
intersects_t2l::proc(t:Triangle2D, l:Line2D)->(points:[4]Vec2D, point_count:int){
    for i in 0..<3{
        _points, _point_count: = intersects_l2l(triangle2d_side(t, u32(i)), l)
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

// Get intersection points where circle intersects with line segment
intersects_c2l::proc(c:Circle2D, l:Line2D)->(points:[2]Vec2D, point_count:int){
    closest_point_to_segment:Vec2D = closest_l2p(l, c.xy)
    if !overlaps_c2p(c, closest_point_to_segment){
        return
    }
    
    // Compute point closest to the circle on the line
    d:Vec2D = line2d_vector(l)
    u_line:f32 = vec2d_dot(d, c.xy - l.xy) / vec2d_mag2(d)
    closest_point_to_line:Vec2D = l.xy + u_line * d
    dist_to_line:f32 = vec2d_mag2(c.xy - closest_point_to_line)

    if abs(dist_to_line - c.z * c.z) < epsilon{
        point_count += 1
        points[0] = closest_point_to_line 
        return
    }

    // Circle intersects the line
    length:f32 = sqrt(c.z * c.z - dist_to_line)

    p1:Vec2D = closest_point_to_line + vec2d_norm(line2d_vector(l)) * length
    p2:Vec2D = closest_point_to_line - vec2d_norm(line2d_vector(l)) * length

    if vec2d_mag2(p1 - closest_l2p(l, p1)) < epsilon * epsilon{
        points[point_count] = p1
        point_count += 1
    }
    if vec2d_mag2(p2 - closest_l2p(l, p2)) < epsilon * epsilon{
        points[point_count] = p2
        point_count += 1
    }
    
    if point_count > 1{
        point_count = filter_duplicate_points(points[0:point_count])
    }

    return
}

