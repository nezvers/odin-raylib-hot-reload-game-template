package utility

import rl "vendor:raylib"


screen_to_camera :: proc(point:rl.Vector2, camera: rl.Camera2D) -> rl.Vector2 {
	return (point - camera.offset + camera.target) / camera.zoom
}

