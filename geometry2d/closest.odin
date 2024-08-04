package geometry2d

// Returns closest point on point to any shape (aka p1) :P
closest_p2p::proc(p1:Vec2D, p2:Vec2D)->Vec2D{
    return p1
}

// Returns closest point on line to point
closest_l2p::proc(l:Line2D, p:Vec2D)->Vec2D{
    vector:Vec2D = line2d_vector(l)
    dot:f32 = vec2d_dot(vector, p - l.xy)
    mag:f32 = vec2d_mag2(vector)
    clamp:f32 = clamp(dot / mag, 0.0, 1.0)
    return l.xy + clamp * vector
}

// Returns closest point on circle to point
closest_c2p::proc(c:Circle2D, p:Vec2D)->Vec2D{
    return c.xy + vec2d_norm(p - c.xy) * c.z
}

// Returns closest point on rectangle to point
closest_r2p::proc(r:Rect2D, p:Vec2D)->Vec2D{
    // Note: this algorithm can be reused for polygon
    c1:Vec2D = closest_l2p(rect2d_top(r), p)
    c2:Vec2D = closest_l2p(rect2d_right(r), p)
    c3:Vec2D = closest_l2p(rect2d_bottom(r), p)
    c4:Vec2D = closest_l2p(rect2d_left(r), p)

    d1:f32 = vec2d_mag2(c1 - p)
    d2:f32 = vec2d_mag2(c2 - p)
    d3:f32 = vec2d_mag2(c3 - p)
    d4:f32 = vec2d_mag2(c4 - p)

    cmin:Vec2D = c1
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

// Returns closest point on triangle to point
closest_t2p::proc(t:Triangle2D, p:Vec2D)->Vec2D{
    l:Line2D = line2D_new(t[0], t[1])
    p0:Vec2D = closest_l2p(l, p)
    d0:f32 = vec2d_mag2(p0 - p)

    l.zw = t[2]
    p1:Vec2D = closest_l2p(l, p)
    d1:f32 = vec2d_mag2(p1 - p)

    l.xy = t[1]
    p2:Vec2D = closest_l2p(l, p)
    d2:f32 = vec2d_mag2(p2 - p)

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
closest_ray2p::proc(r:Ray2D, p:Vec2D)->Vec2D{
    return{}
}


// Returns closest point on circle to line
closest_c2l::proc(c:Circle2D, l:Line2D)->Vec2D{
    p:Vec2D = closest_l2p(l, c.xy)
    return c.xy + vec2d_norm(p - c.xy) * c.z
}

// TODO:
// Returns closest point on line to line
closest_l2l::proc(l1:Line2D, l2:Line2D)->Vec2D{
    return{}
}

// TODO:
// Returns closest point on rectangle to line
closest_r2l::proc(r:Rect2D, l:Line2D)->Vec2D{
    return{}
}

// TODO:
// Returns closest point on rectangle to line
closest_t2l::proc(t:Triangle2D, l:Line2D)->Vec2D{
    return{}
}

// Returns closest point on circle to circle
closest_c2c::proc(c1:Circle2D, c2:Circle2D)->Vec2D{
    return closest_c2p(c1, c2.xy)
}

// Returns closest point on line to circle
closest_l2c::proc(l:Line2D, c:Circle2D)->Vec2D{
    p:Vec2D = closest_c2l(c, l)
    return closest_l2p(l, p)
}

// TODO:
// Returns closest point on rectangle to circle
closest_r2c::proc(r:Rect2D, c:Circle2D)->Vec2D{
    return {}
}

// TODO:
// Returns closest point on triangle to circle
closest_t2c::proc(t:Triangle2D, c:Circle2D)->Vec2D{
    return {}
}

// TODO:
// Returns closest point on line to circle
closest_l2t::proc(l:Line2D, t:Triangle2D)->Vec2D{
    return {}
}

// TODO:
// Returns closest point on rect to circle
closest_r2t::proc(r:Rect2D, t:Triangle2D)->Vec2D{
    return {}
}

// TODO:
// Returns closest point on circle to circle
closest_c2t::proc(c:Circle2D, t:Triangle2D)->Vec2D{
    return {}
}

// TODO:
// Returns closest point on triangle to circle
closest_t2t::proc(t1:Triangle2D, t2:Triangle2D)->Vec2D{
    return {}
}


