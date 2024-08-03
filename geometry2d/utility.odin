package geometry2d

epsilon:f32 = 0.001
pi_f64:f64 = 3.141592653589793238462643383279502884
tau_f64:f64 = pi_f64 * 2

sign :: proc($T: typeid) -> T {
    return (0 < T) - (T < 0)
}