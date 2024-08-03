// This file is compiled as part of the `odin.dll` file. It contains the
// procs that `game.exe` will call, such as:
//
// game_init: Sets up the game state
// game_update: Run once per frame
// game_shutdown: Shuts down game and frees memory
// game_memory: Run just before a hot reload, so game.exe has a pointer to the
//		game's memory.
// game_hot_reloaded: Run after a hot reload so that the `g_mem` global variable
//		can be set to whatever pointer it was in the old DLL.

package game

import "game_state"
import "examples"
import rl "vendor:raylib"


@(export)
game_init_window :: proc() {
	rl.SetConfigFlags({.WINDOW_RESIZABLE})
	rl.InitWindow(1280, 720, "Odin + Raylib + Hot Reload template!")
	rl.SetWindowPosition(200, 200)
	rl.SetTargetFPS(500)
}

@(export)
game_init :: proc() {
	game_state.transition(examples.get_example(u64(examples.ExampleEnum.template)))
	game_hot_reloaded(game_state.g_mem)
}

@(export)
game_update :: proc() -> bool {
	if (rl.IsWindowResized()){
		game_state.g_mem.game_state.window_resized()
	}
	if(rl.IsKeyPressed(.MINUS)){
		// Previous Example
		count:u64 = u64(examples.ExampleEnum.count)
		i:u64 = (game_state.g_mem.game_state.id + count - 1) % count
		game_state.transition(examples.get_example(i))
	}
	if(rl.IsKeyPressed(.EQUAL)){
		// next example
		count:u64 = u64(examples.ExampleEnum.count)
		i:u64 = (game_state.g_mem.game_state.id + 1) % count
		game_state.transition(examples.get_example(i))
	}
	game_state.g_mem.game_state.update()
	game_state.g_mem.game_state.draw()
	return !rl.WindowShouldClose()
}

@(export)
game_shutdown :: proc() { 
	game_state.clear()
}

@(export)
game_shutdown_window :: proc() {
	rl.CloseWindow()
}

@(export)
game_memory :: proc() -> rawptr {
	return game_state.game_memory()
}

@(export)
game_memory_size :: proc() -> int {
	return size_of(game_state.GameMemory)
}

@(export)
game_hot_reloaded :: proc(mem: rawptr) {
	game_state.g_mem = (^game_state.GameMemory)(mem)
}

@(export)
game_force_reload :: proc() -> bool {
	return rl.IsKeyPressed(.F5)
}

@(export)
game_force_restart :: proc() -> bool {
	return rl.IsKeyPressed(.F6)
}