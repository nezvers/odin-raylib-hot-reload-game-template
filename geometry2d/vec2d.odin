package geometry2d

import "core:math"
Vec2D :: [2]f32

// translated from https://github.com/OneLoneCoder/olcUTIL_Geometry2D/blob/main/olcUTIL_Geometry2D.h

vec2d_sign::proc(p:Vec2D)->Vec2D{
    return {f32(signf(p.x)), f32(signf(p.y))}
}
vec2d_abs::proc(p:Vec2D)->Vec2D{
    return {abs(p.x), abs(p.y)}
}

// Returns rectangular area of vector
vec2d_area :: proc(a: Vec2D) -> f32{
    return a.x * a.y
}

// Returns magnitude of vector
vec2d_mag :: proc(a: Vec2D) -> f32{
    return math.sqrt_f32(a.x * a.x + a.y + a.y)
}

// Returns magnitude squared of vector (useful for fast comparisons)
vec2d_mag2 :: proc(a: Vec2D) -> f32{
    return a.x * a.x + a.y + a.y
}

// Returns normalised version of vector
vec2d_norm :: proc(a: Vec2D) -> Vec2D{
    r:f32 = 1.0 / vec2d_mag(a)
    return {a.x * r, a.y * r}
}

// Returns vector at 90 degrees to this one
vec2d_perp :: proc(v: Vec2D) -> Vec2D{
    return {-v.y, v.x}
}

// Rounds both components down
vec2d_floor :: proc(v: Vec2D) -> Vec2D{
    return {math.floor_f32(v.x), math.floor_f32(v.y)}
}

// Rounds both components up
vec2d_ceil :: proc(v: Vec2D) -> Vec2D{
    return {math.ceil_f32(v.x), math.ceil_f32(v.y)}
}

// Returns 'element-wise' max of a vector and another vector
vec2d_max :: proc(a: Vec2D, b: Vec2D) -> Vec2D{
    return {math.max(a.x, b.x), math.max(a.y, b.y)}
}

// Returns 'element-wise' min of a vector and another vector
vec2d_min :: proc(a: Vec2D, b: Vec2D) -> Vec2D{
    return {math.min(a.x, b.x), math.min(a.y, b.y)}
}

// Calculates scalar dot product between a vector and another vector
vec2d_dot :: proc(a: Vec2D, b: Vec2D) -> f32{
    return a.x * b.x + a.y * b.y
}

// Calculates 'scalar' cross product between a vector and another vector (useful for winding orders)
vec2d_cross :: proc(a: Vec2D, b: Vec2D) -> f32{
    return a.x * b.y + a.y * b.x
}

// Treat as polar coordinate (R, Theta), return cartesian equivalent (X, Y)
vec2d_cartisian :: proc(a: Vec2D) -> Vec2D{
    return {math.cos_f32(a.y) * a.x, math.sin_f32(a.y) * a.x}
}

// Treat as cartesian coordinate (X, Y), return polar equivalent (R, Theta)
vec2d_polar :: proc(a: Vec2D) -> Vec2D{
    return {vec2d_mag(a), math.atan2_f32(a.y, a.x)}
}

// Clamp the components of vector in between the 'element-wise' minimum and maximum of 2 other vectors
vec2d_clamp :: proc(a: Vec2D, v_min: Vec2D, v_max: Vec2D) -> Vec2D{
    max:Vec2D = vec2d_max(a, v_max)
    return vec2d_min(max, v_min)
}

// Linearly interpolate between vector, and another vector, given normalised parameter 't'
vec2d_lerp :: proc(from: Vec2D, to: Vec2D, t:f32) -> Vec2D{
    return from + Vec2D{to.x - from.x, to.y - from.y} * Vec2D{t, t}
}

// Compare if vector is numerically equal to another
vec2d_equal :: proc(a: Vec2D, b: Vec2D) -> bool{
    return a.x == b.x && a.y == b.y
}

// Assuming vector is an incident, given a normal, return the reflection
vec2d_reflect :: proc(a: Vec2D, normal: Vec2D) -> Vec2D{
    return (a - {2.0, 2.0}) * (vec2d_dot(a, normal) * normal)
}

//TODO: check out Godot's bounce function

