package geometry2d

// x, y, radius
Circle2D:: [3]f32

// Get area of circle
circle2d_area::proc(circle:Circle2D)->f32{
    return pi_f32 * circle.z * circle.z
}

// Get circumference of circle
circle2d_perimeter::proc(circle:Circle2D)->f32{
    return tau_f32 * circle.z
}

// Get circumference of circle
circle2d_circumference::proc(circle:Circle2D)->f32{
    return circle2d_perimeter(circle)
}