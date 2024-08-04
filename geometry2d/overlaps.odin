package geometry2d

// Check if point overlaps with point (analogous to contains())
overlaps_p2p::proc(p1:Vec2D, p2:Vec2D)->bool{
    return contains_p2p(p1, p2)
}

// Checks if line segment overlaps with point
overlaps_l2p::proc(l:Line2D, p:Vec2D)->bool{
    return contains_l2p(l, p)
}

// Checks if rectangle overlaps with point
overlaps_r2p::proc(r:Rect2D, p:Vec2D)->bool{
    return contains_r2p(r, p)
}

// Checks if circle overlaps with point
overlaps_c2p::proc(c:Circle2D, p:Vec2D)->bool{
    return contains_c2p(c, p)
}

// Checks if triangle overlaps with point
overlaps_t2p::proc(t:Triangle2D, p:Vec2D)->bool{
    return contains_t2p(t, p)
}
