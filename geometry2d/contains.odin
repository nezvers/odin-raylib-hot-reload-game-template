package geometry2d


// Checks if point contains point
contains_point_point::proc(p:Vec2, p2:Vec2)->bool{
    return vec2_mag2(p - p2) < epsilon
}

// Checks if line contains point
contains_line_point::proc(l:Line, p:Vec2)->bool{
    d:f32 = (p.x - l.x) * (l.w - l.y) - (p.y - l.y) * (l.z - l.x)
    if (abs(d) < epsilon){
        vector:Vec2 = line_vector(l)
        dot:f32 = vec2_dot(vector, p - l.xy)
        mag2:f32 = vec2_mag2(vector)
        u:f32 = dot / mag2
        return (u >= 0.0) && (u <= 1.0)
    }
    return false
}

// Checks if rectangle contains point
contains_rectangle_point::proc(r:Rect, p:Vec2)->bool{
    return !(p.x < r.x || p.y < r.y || p.x > (r.x + r.z) || p.y > (r.y + r.w))
}

// Checks if Circle contains point
contains_circle_point::proc(c:Circle, p:Vec2)->bool{
    return vec2_mag2(c.xy - p) <= c.z * c.z
}

// Checks if Triangle contains a point
contains_triangle_point::proc(t:Triangle, p:Vec2)->bool{
    // http://jsfiddle.net/PerroAZUL/zdaY8/1/
    a:f32 = 0.5 * (-t[1].y * t[2].x + t[0].y * (t[1].x + t[2].x) + t[0].x * (t[1].y - t[2].y) + t[1].x * t[2].y)
    a_sign:f32 = f32(signf(a))
    s:f32 = (t[0].y * t[2].x - t[0].x * t[2].y + (t[2].y - t[0].y) * p.x + (t[0].x - t[2].x) * p.y) * a_sign
    v:f32 = (t[0].x * t[1].y - t[0].y * t[1].x + (t[0].y - t[1].y) * p.x + (t[1].x - t[0].x) * p.x) * a_sign
    return s >= 0 && v >= 0 && (s + v) <= 2 * a * a_sign
}

// Checks if raycast contains point
contains_ray_point::proc(r:ray, p:Vec2)->bool{
    op:Vec2 = p - r.xy
    dot:f32 = vec2_dot(op, r.zw)
    if (dot < 0){
        return false
    }
    projection:Vec2 = {r.z * dot, r.w * dot}

    d:Vec2 = projection - op
    dist2:f32 = d.x * d.x + d.y * d.y
    distance:f32 = sqrt(dist2)
    return dist2 < epsilon
}

// Checks if point contains line
// It can't!
contains_point_line::proc(p:Vec2, l:Line)->bool{
    return false
}

// Checks if line contains line
contains_line_line::proc(l1:Line, l2:Line)->bool{
    return contains_line_point(l1, l2.xy) && contains_line_point(l2, l1.xy)
}

// Checks if line contains line
contains_rectangle_line::proc(r:Rect, l:Line)->bool{
    return contains_rectangle_point(r, l.xy) && contains_rectangle_point(r, l.zw)
}

// Checks if Circle contains line
contains_circle_line::proc(c:Circle, l:Line)->bool{
    return contains_circle_point(c, l.xy) && contains_circle_point(c, l.zw)
}

// Checks if Triangle contains line
contains_triangle_line::proc(t:Triangle, l:Line)->bool{
    return contains_triangle_point(t, l.xy) && contains_triangle_point(t, l.zw)
}



// Checks if point contains rectangle
// TODO: maybe if all vertices are one point
contains_point_rectangle::proc(p:Vec2, r:Rect)->bool{
    return false
}

// Checks if line contains rectangle
contains_line_rectangle::proc(l:Line, r:Rect)->bool{
    return false
}

// Checks if rectangle contains rectangle
// r1 >= r2
contains_rectangle_rectangle::proc(r1:Rect, r2:Rect)->bool{
    return r1.x <= r2.x && r1.x + r1.z >= r2.x + r2.z && r1.y <= r2.y && r1.y + r1.w >= r2.y + r2.w
}

// Checks if Circle contains rectangle
contains_c2r::proc(c:Circle, r:Rect)->bool{
    return contains_circle_point(c, r.xy) && contains_circle_point(c, r.xy + r.zw) && contains_circle_point(c, {r.x + r.z, r.y}) && contains_circle_point(c, {r.x, r.y + r.w})
}

// Checks if Triangle contains rectangle
contains_t2r::proc(t:Triangle, r:Rect)->bool{
    return contains_triangle_point(t, r.xy) && contains_triangle_point(t, r.xy + r.zw) && contains_triangle_point(t, {r.x + r.z, r.y}) && contains_triangle_point(t, {r.x, r.y + r.w})
}