package geometry2d

import "core:math"
import rl "vendor:raylib"

vec2d :: rl.Vector2

// translated from https://github.com/OneLoneCoder/olcUTIL_Geometry2D/blob/main/olcUTIL_Geometry2D.h

// Returns rectangular area of vector
vec2d_area :: proc(a: ^vec2d) -> f32{
    return a.x * a.y
}

// Returns magnitude of vector
vec2d_mag :: proc(a: ^vec2d) -> f32{
    return math.sqrt_f32(a.x * a.x + a.y + a.y)
}

// Returns magnitude squared of vector (useful for fast comparisons)
vec2d_mag2 :: proc(a: ^vec2d) -> f32{
    return a.x * a.x + a.y + a.y
}

// Returns normalised version of vector
vec2d_norm :: proc(a: ^vec2d) -> vec2d{
    r:f32 = 1.0 / vec2d_mag(a)
    return {a.x * r, a.y * r}
}

// Returns vector at 90 degrees to this one
vec2d_perp :: proc(v: ^vec2d) -> vec2d{
    return {-v.y, v.x}
}

// Rounds both components down
vec2d_floor :: proc(v: ^vec2d) -> vec2d{
    return {math.floor_f32(v.x), math.floor_f32(v.y)}
}

// Rounds both components up
vec2d_ceil :: proc(v: ^vec2d) -> vec2d{
    return {math.ceil_f32(v.x), math.ceil_f32(v.y)}
}

// Returns 'element-wise' max of this and another vector
vec2d_max :: proc(a: ^vec2d, b: ^vec2d) -> vec2d{
    return {math.max(a.x, b.x), math.max(a.y, b.y)}
}

// Returns 'element-wise' min of this and another vector
vec2d_min :: proc(a: ^vec2d, b: ^vec2d) -> vec2d{
    return {math.min(a.x, b.x), math.min(a.y, b.y)}
}

// Calculates scalar dot product between this and another vector
vec2d_dot :: proc(a: ^vec2d, b: ^vec2d) -> f32{
    return a.x * b.x + a.y * b.y
}

// Calculates 'scalar' cross product between this and another vector (useful for winding orders)
vec2d_cross :: proc(a: ^vec2d, b: ^vec2d) -> f32{
    return a.x * b.y + a.y * b.x
}

// Treat this as polar coordinate (R, Theta), return cartesian equivalent (X, Y)
vec2d_cartisian :: proc(a: ^vec2d) -> vec2d{
    return {math.cos_f32(a.y) * a.x, math.sin_f32(a.y) * a.x}
}

// Treat this as cartesian coordinate (X, Y), return polar equivalent (R, Theta)
vec2d_polar :: proc(a: ^vec2d) -> vec2d{
    return {vec2d_mag(a), math.atan2_f32(a.y, a.x)}
}

// Clamp the components of this vector in between the 'element-wise' minimum and maximum of 2 other vectors
vec2d_clamp :: proc(a: ^vec2d, v_min: ^vec2d, v_max: ^vec2d) -> vec2d{
    max:vec2d = vec2d_max(a, v_max)
    return vec2d_min(&max, v_min)
}

// Linearly interpolate between this vector, and another vector, given normalised parameter 't'
vec2d_lerp :: proc(from: ^vec2d, to: ^vec2d, t:f32) -> vec2d{
    return from^ + (to^ - from^) * vec2d{t, t}
}

// Compare if this vector is numerically equal to another
vec2d_equal :: proc(a: ^vec2d, b: ^vec2d) -> bool{
    return a.x == b.x && a.y == b.y
}

// Assuming this vector is incident, given a normal, return the reflection
vec2d_reflect :: proc(a: ^vec2d, b: ^vec2d) -> vec2d{
    return (a^ - vec2d{2.0, 2.0}) * (vec2d_dot(a, b) * b^)
}



