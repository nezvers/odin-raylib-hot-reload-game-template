package shapes

import "../../game_state"
import rl "vendor:raylib"

PIXEL_WINDOW_HEIGHT :: 180
GameState:: game_state.GameState
Vec2:: rl.Vector2
s_mem: ^StateMemory


// State data representing current scene
StateMemory :: struct {	
	player_pos: Vec2,
}

// Default state
state_default: StateMemory = {
    player_pos = {},
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
	s_mem.player_pos = Vec2{50.0, 50.0}
    window_resized()
}

clear :: proc(){
    free(s_mem)
}

update :: proc() {
	input: Vec2

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

	s_mem.player_pos += input * rl.GetFrameTime() * 100
}

draw :: proc() {
	rl.BeginDrawing()
	rl.ClearBackground(rl.BLACK)
	
	rl.DrawRectangleV(s_mem.player_pos, {10, 20}, rl.WHITE)
	rl.DrawRectangleV({20, 20}, {10, 10}, rl.RED)
	rl.DrawRectangleV({70, 100}, {10, 10}, rl.GREEN)

	rl.EndDrawing()
}

window_resized :: proc(){
    
}

window_should_close :: proc() -> bool {
    return rl.WindowShouldClose()
}