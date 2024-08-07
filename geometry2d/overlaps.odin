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

// Checks if point overlaps with line
overlaps_p2l::proc(p:Vec2D, l:Line2D)->bool{
    return contains_l2p(l, p)
}

// Checks if line overlaps with line
overlaps_l2l::proc(l1:Line2D, l2:Line2D)->bool{
    D:f32 = (l2.w - l2.y) * (l1.z - l1.x) - (l2.z - l2.x) * (l1.w - l1.y)
    uA:f32 = ((l2.z - l2.x) * (l1.y - l2.y) - (l2.w - l2.y) * (l1.x - l2.x)) / D
    uB:f32 = ((l1.z - l1.x) * (l1.y - l2.y) - (l1.w - l1.y) * (l1.x - l2.x)) / D
    return uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1
}

// Checks if rectangle overlaps with line
overlaps_r2l::proc(r:Rect2D, l:Line2D)->bool{
    return contains_r2l(r, l) || overlaps_l2l(rect2d_top(r), l) || overlaps_l2l(rect2d_right(r), l) || overlaps_l2l(rect2d_bottom(r), l) || overlaps_l2l(rect2d_left(r), l)
}

// Checks if circle overlaps with line
overlaps_c2l::proc(c:Circle2D, l:Line2D)->bool{
    p:Vec2D = closest_l2p(l, c.xy)
    return vec2d_mag2(c.xy - p) <= (c.z * c.z)
}

// Check if triangle overlaps line segment
overlaps_t2l::proc(t:Triangle2D, l:Line2D)->bool{
    return overlaps_t2p(t, l.xy) || overlaps_l2l(triangle2d_side(t, 0), l) || overlaps_l2l(triangle2d_side(t, 1), l) || overlaps_l2l(triangle2d_side(t, 2), l)
}

// Checks if point overlaps with rectangle
overlaps_p2r::proc(p:Vec2D, r:Rect2D)->bool{
    return overlaps_r2p(r, p)
}

// Checks if line overlaps with rectangle
overlaps_l2r::proc(l:Line2D, r:Rect2D)->bool{
    return overlaps_r2l(r, l)
}

// Checks if rectangle overlaps with rectangle
overlaps_r2r::proc(r1:Rect2D, r2:Rect2D)->bool{
    return contains_r2r(r2, r1)
}


// Check if circle overlaps rectangle
overlaps_c2r::proc(c:Circle2D, r:Rect2D)->bool{
    overlap:f32 = vec2d_mag2(Vec2D{clamp(c.x, r.x, r.x + r.z), clamp(c.y, r.y, r.y + r.w)} - c.xy)
    if isnan(overlap){overlap = 0}
    return (overlap - (c.z * c.z)) < 0
}

// Check if triangle overlaps rectangle
overlaps_t2r::proc(t:Triangle2D, r:Rect2D)->bool{
    return overlaps_t2l(t, rect2d_top(r)) || overlaps_t2l(t, rect2d_right(r)) || overlaps_t2l(t, rect2d_bottom(r)) || overlaps_t2l(t, rect2d_left(r)) || contains_r2p(r, t[0])
}