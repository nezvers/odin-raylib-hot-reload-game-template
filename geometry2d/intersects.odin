package geometry2d


// Get intersection points where point intersects with point
intersects_p2p::proc(p1:Vec2D, p2:Vec2D)->Vec2D{
    if (contains_p2p(p1, p2)){
        return p1
    }
    return {}
}

// Get intersection points where line segment intersects with point
intersects_l2p::proc(l:Line2D, p:Vec2D)->Vec2D{
    if (contains_l2p(l, p)){
        return p
    }
    return {}
}

// Get intersection points where rectangle intersects with point
// TODO: Side line check felt weird
intersects_r2p::proc(r:Rect2D, p:Vec2D)->Vec2D{
    if (contains_r2p(r,p)){
        return p
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
    return {}
}

// Get intersection points where circle intersects with point
intersects_c2p::proc(c:Circle2D, p:Vec2D)->Vec2D{
    if (vec2d_mag2(vec2d_abs(p - c.xy)) - (c.z * c.z) <= epsilon){
        return p
    }
    return {}
}

// Get intersection points where triangle intersects with point
// TODO: Side line check feels weird
intersects_t2p::proc(t:Triangle2D, p:Vec2D)->Vec2D{
    if (contains_l2p(triangle2d_side(t, 0), p)){
        return p
    }
    if (contains_l2p(triangle2d_side(t, 1), p)){
        return p
    }
    if (contains_l2p(triangle2d_side(t, 2), p)){
        return p
    }
    return {}
}