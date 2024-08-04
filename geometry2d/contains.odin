package geometry2d


// Checks if point contains point
contains_p2p::proc(p:Vec2D, p2:Vec2D)->bool{
    return vec2d_mag2(p - p2) < epsilon
}

// Checks if line contains point
contains_l2p::proc(l:Line2D, p:Vec2D)->bool{
    d:f32 = (p.x - l.x) * (l.w - l.y) - (p.y - l.y) * (l.z - l.x)
    if (abs(d) < epsilon){
        vector:Vec2D = line2d_vector(l)
        dot:f32 = vec2d_dot(vector, p - l.xy)
        mag2:f32 = vec2d_mag2(vector)
        u:f32 = dot / mag2
        return (u >= 0.0) && (u <= 1.0)
    }
    return false
}

// Checks if rectangle contains point
contains_r2p::proc(r:Rect2D, p:Vec2D)->bool{
    return !(p.x < r.x || p.y < r.y || p.x > (r.x + r.z) || p.y > (r.y + r.w))
}

// Checks if circle contains point
contains_c2p::proc(c:Circle2D, p:Vec2D)->bool{
    return vec2d_mag2(c.xy - p) <= c.z * c.z
}

// Checks if triangle contains a point
contains_t2p::proc(t:Triangle2D, p:Vec2D)->bool{
    // http://jsfiddle.net/PerroAZUL/zdaY8/1/
    a:f32 = 0.5 * (-t[1].y * t[2].x + t[0].y * (t[1].x + t[2].x) + t[0].x * (t[1].y - t[2].y) + t[1].x * t[2].y)
    a_sign:f32 = f32(signf(a))
    s:f32 = (t[0].y * t[2].x - t[0].x * t[2].y + (t[2].y - t[0].y) * p.x + (t[0].x - t[2].x) * p.y) * a_sign
    v:f32 = (t[0].x * t[1].y - t[0].y * t[1].x + (t[0].y - t[1].y) * p.x + (t[1].x - t[0].x) * p.x) * a_sign
    return s >= 0 && v >= 0 && (s + v) <= 2 * a * a_sign
}

// Checks if raycast contains point
contains_ray2p::proc(r:Ray2D, p:Vec2D)->bool{
    op:Vec2D = p - r.xy
    dot:f32 = vec2d_dot(op, r.zw)
    if (dot < 0){
        return false
    }
    projection:Vec2D = {r.z * dot, r.w * dot}

    d:Vec2D = projection - op
    dist2:f32 = d.x * d.x + d.y * d.y
    // TODO: math is failing to build
    //distance:f32 = math.sqrt_f32(dist2)
    return dist2 < epsilon
}

// Checks if point contains line
// It can't!
contains_p2l::proc(p:Vec2D, l:Line2D)->bool{
    return false
}

// Checks if line contains line
contains_l2l::proc(l1:Line2D, l2:Line2D)->bool{
    return contains_l2p(l1, l2.xy) && contains_l2p(l2, l1.xy)
}

// Checks if line contains line
contains_r2l::proc(r:Rect2D, l:Line2D)->bool{
    return contains_r2p(r, l.xy) && contains_r2p(r, l.zw)
}

// Checks if circle contains line
contains_c2l::proc(c:Circle2D, l:Line2D)->bool{
    return contains_c2p(c, l.xy) && contains_c2p(c, l.zw)
}

// Checks if triangle contains line
contains_t2l::proc(t:Triangle2D, l:Line2D)->bool{
    return contains_t2p(t, l.xy) && contains_t2p(t, l.zw)
}

