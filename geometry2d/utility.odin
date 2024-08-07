package geometry2d

import math "core:math"
import "core:c/libc"

epsilon :: f32(0.001)
pi_f64 :: f64(3.141592653589793238462643383279502884)
pi_f32 :: f32(pi_f64)
tau_f64 :: pi_f64 * 2
tau_f32 :: f32(tau_f64)

INFINITY:: 1e5000
INF_F32 :: f32(INFINITY)
INF_F64 :: f64(INFINITY)

signf :: proc(v: f32) -> i32 {
    return i32(0 < v) - i32(v < 0)
}
signi :: proc(v: i32) -> i32 {
    return i32(0 < v) - i32(v < 0)
}

abs::proc(a:f32)->f32{
    return a if a >= 0 else -a
}

clamp::proc(v:f32, lowest:f32, highest:f32)->f32{
    return math.min(math.max(v, lowest), highest,)
}

sqrt::math.sqrt_f32
isnan::libc.isnan

filter_duplicate_points::proc(point_list:[]Vec2)->int{
    point_count:int = len(point_list)
    for i in 0..<point_count {
        a:Vec2 = point_list[i]
        
        // compare starting from last
        pc: = point_count - 1
        for j := pc; j > i; j -= 1{
            b:Vec2 = point_list[j]

            if (abs(a.x - b.x) < epsilon && abs(a.y - b.y) < epsilon){
                point_list[j] = point_list[point_count - 1]
                point_count -= 1
            }
        }
    }
    return point_count
}