package template

import "../../game_state"
import rl "vendor:raylib"
import "core:math/linalg"
import "core:fmt"
import gm "../../geometry2d"

PIXEL_WINDOW_HEIGHT :: 180
GameState:: game_state.GameState
Vector2:: [2]f32
s_mem: ^StateMemory


// State data representing current scene
StateMemory :: struct {	
	player_pos: Vector2,
	some_number: f32,
	camera_main: rl.Camera2D,
	camera_ui: rl.Camera2D,
}

// Default state
state_default: StateMemory = {
    player_pos = {},
	some_number = {},
	camera_main = {},
	camera_ui = {},
}

get_state:: proc() -> game_state.GameState{
    return {
        init = init,
        update = update,
        draw = draw,
        clear = clear,
        window_resized = window_resized,
        window_should_close = window_should_close,
        state_size = size_of(StateMemory),
    }
}

init :: proc(g_mem: ^game_state.GameMemory){
    s_mem = new(StateMemory)
    g_mem.game_state.state_ptr = transmute([^]u8)s_mem
    window_resized()
}

clear :: proc(){
    free(s_mem)
}

update :: proc() {
	input: Vector2

	if rl.IsKeyDown(.UP) || rl.IsKeyDown(.W) {
		input.y -= 1
	}
	if rl.IsKeyDown(.DOWN) || rl.IsKeyDown(.S) {
		input.y += 1
	}
	if rl.IsKeyDown(.LEFT) || rl.IsKeyDown(.A) {
		input.x -= 1
	}
	if rl.IsKeyDown(.RIGHT) || rl.IsKeyDown(.D) {
		input.x += 1
	}

	input = linalg.normalize0(input)
	s_mem.player_pos += input * rl.GetFrameTime() * 100
	s_mem.camera_main.target = s_mem.player_pos

	//mouse:rl.Vector2 = rl.GetMousePosition()
	//line: gm.Line2D = {s_mem.player_pos, helpers.screen_to_camera(mouse, s_mem.camera_main)}
	test:[4]f32 = {0.0,1.0,2.0,3.0}
	s_mem.some_number = test.w
}

draw :: proc() {
	rl.BeginDrawing()
	rl.ClearBackground(rl.BLACK)
	
	rl.BeginMode2D(s_mem.camera_main)
	rl.DrawRectangleV(s_mem.player_pos, {10, 20}, rl.WHITE)
	rl.DrawRectangleV({20, 20}, {10, 10}, rl.RED)
	rl.DrawRectangleV({-30, -20}, {10, 10}, rl.GREEN)
	rl.EndMode2D()

	rl.BeginMode2D(s_mem.camera_ui)
	rl.DrawText(fmt.ctprintf("some_number: %v\nplayer_pos: %v", s_mem.some_number, s_mem.player_pos), 5, 5, 8, rl.WHITE)
	rl.EndMode2D()

	rl.EndDrawing()
}

window_resized :: proc(){
    w := f32(rl.GetScreenWidth())
	h := f32(rl.GetScreenHeight())

	s_mem.camera_main =  {
		zoom = h/PIXEL_WINDOW_HEIGHT,
		target = s_mem.player_pos,
		offset = { w/2, h/2 },
	}

    s_mem.camera_ui = {
        zoom = f32(rl.GetScreenHeight())/PIXEL_WINDOW_HEIGHT,
	}
}

window_should_close :: proc() -> bool {
    return rl.WindowShouldClose()
}