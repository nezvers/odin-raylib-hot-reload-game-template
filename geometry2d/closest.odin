package geometry2d

// Returns closest point on point to any shape (aka p1) :P
closest_point_point::proc(p1:Vec2, p2:Vec2)->Vec2{
    return p1
}

// Returns closest point on line to point
closest_line_point::proc(l:Line, p:Vec2)->Vec2{
    vector:Vec2 = line_vector(l)
    dot:f32 = vec2_dot(vector, p - l.xy)
    mag:f32 = vec2_mag2(vector)
    clamp:f32 = clamp(dot / mag, 0.0, 1.0)
    return l.xy + clamp * vector
}

// Returns closest point on Circle to point
closest_circle_point::proc(c:Circle, p:Vec2)->Vec2{
    return c.xy + vec2_norm(p - c.xy) * c.z
}

// Returns closest point on rectangle to point
closest_rectangle_point::proc(r:Rect, p:Vec2)->Vec2{
    // Note: this algorithm can be reused for polygon
    c1:Vec2 = closest_line_point(rect_top(r), p)
    c2:Vec2 = closest_line_point(rect_right(r), p)
    c3:Vec2 = closest_line_point(rect_bottom(r), p)
    c4:Vec2 = closest_line_point(rect_left(r), p)

    d1:f32 = vec2_mag2(c1 - p)
    d2:f32 = vec2_mag2(c2 - p)
    d3:f32 = vec2_mag2(c3 - p)
    d4:f32 = vec2_mag2(c4 - p)

    cmin:Vec2 = c1
    dmin:f32 = d1

    if (d2 < dmin){
        dmin = d2
        cmin = c2
    }
    if (d3 < dmin){
        dmin = d3
        cmin = c3
    }
    if (d4 < dmin){
        dmin = d4
        cmin = c4
    }
    return cmin
}

// Returns closest point on Triangle to point
closest_triangle_point::proc(t:Triangle, p:Vec2)->Vec2{
    l:Line = line2D_new(t[0], t[1])
    p0:Vec2 = closest_line_point(l, p)
    d0:f32 = vec2_mag2(p0 - p)

    l.zw = t[2]
    p1:Vec2 = closest_line_point(l, p)
    d1:f32 = vec2_mag2(p1 - p)

    l.xy = t[1]
    p2:Vec2 = closest_line_point(l, p)
    d2:f32 = vec2_mag2(p2 - p)

    if ((d0 <= d1) && (d0 <= d2)){
        return p0
    }

    if ((d1 <= d0) && (d1 <= d2)){
        return p1
    }

    return p2
}

// TODO:
// Returns closest point on ray to point
closest_ray_point::proc(r:ray, p:Vec2)->Vec2{
    return{}
}


// Returns closest point on Circle to line
closest_circle_line::proc(c:Circle, l:Line)->Vec2{
    p:Vec2 = closest_line_point(l, c.xy)
    return c.xy + vec2_norm(p - c.xy) * c.z
}

// TODO:
// Returns closest point on line to line
closest_line_line::proc(l1:Line, l2:Line)->Vec2{
    return{}
}

// TODO:
// Returns closest point on rectangle to line
closest_rectangle_line::proc(r:Rect, l:Line)->Vec2{
    return{}
}

// TODO:
// Returns closest point on rectangle to line
closest_triangle_line::proc(t:Triangle, l:Line)->Vec2{
    return{}
}

// Returns closest point on Circle to Circle
closest_c2c::proc(c1:Circle, c2:Circle)->Vec2{
    return closest_circle_point(c1, c2.xy)
}

// Returns closest point on line to Circle
closest_l2c::proc(l:Line, c:Circle)->Vec2{
    p:Vec2 = closest_circle_line(c, l)
    return closest_line_point(l, p)
}

// TODO:
// Returns closest point on rectangle to Circle
closest_r2c::proc(r:Rect, c:Circle)->Vec2{
    return {}
}

// TODO:
// Returns closest point on Triangle to Circle
closest_t2c::proc(t:Triangle, c:Circle)->Vec2{
    return {}
}

// TODO:
// Returns closest point on line to Circle
closest_l2t::proc(l:Line, t:Triangle)->Vec2{
    return {}
}

// TODO:
// Returns closest point on Rect to Circle
closest_r2t::proc(r:Rect, t:Triangle)->Vec2{
    return {}
}

// TODO:
// Returns closest point on Circle to Circle
closest_c2t::proc(c:Circle, t:Triangle)->Vec2{
    return {}
}

// TODO:
// Returns closest point on Triangle to Circle
closest_t2t::proc(t1:Triangle, t2:Triangle)->Vec2{
    return {}
}


