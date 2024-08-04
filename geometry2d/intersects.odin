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

// Get intersection points where point intersects with line segment
intersects_p2l::proc(p:Vec2D, l:Line2D)->Vec2D{
    return intersects_l2p(l, p)
}

// Get intersection points where line segment intersects with line segment
intersects_l2l::proc(l1:Line2D, l2:Line2D)->Vec2D{
    rd:f32 = vec2d_cross(line2d_vector(l1), line2d_vector(l2))
    if (rd == 0){return {}}
    rd = 1 / rd
    rn:f32 = ((l2.z - l2.x) * (l1.y - l2.y) - (l2.w - l2.y) * (l1.x - l2.x)) * rd
    sn:f32 = ((l1.z - l1.x) * (l1.y - l2.y) - (l1.w - l1.y) * (l1.x - l2.x)) * rd
    if (rn < 0 || rn > 1 || sn < 0 || sn > 1){
        return {}
    }

    return l1.xy + rn * line2d_vector(l1)
}

// Get intersection points where rectangle intersects with line segment
// intersects_f2l::proc(r:Rect2D, l:Line2D)->[]Vec2D{
//     intersections: = [4]Vec2D{
//         intersects_l2l(rect2d_side(r, 0), l),
//         intersects_l2l(rect2d_side(r, 1), l),
//         intersects_l2l(rect2d_side(r, 2), l),
//         intersects_l2l(rect2d_side(r, 3), l),
//     }
//     return intersections
// }

