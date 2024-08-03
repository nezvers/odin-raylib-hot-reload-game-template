package game_state


g_mem: ^GameMemory

GameMemory :: struct {	
    current_state: u64,
	game_state: GameState,
}


// State usable for swapping scenes
GameState :: struct {
    init: proc(^GameMemory), // initialize & decide what to do with memory | should set current_state index
    update: proc(),
    draw: proc(),
    clear: proc(),
    window_resized: proc(),
    window_should_close: proc()-> bool,
    id:u64,
    state_size: u64, // useful for allocated states
    state_ptr: [^]u8,
}

transition :: proc(new_state:GameState) ->^GameMemory{
    if (g_mem == nil){
		g_mem = new(GameMemory)
	}
    if (g_mem.game_state == {} && g_mem.game_state.clear != nil){
        g_mem.game_state.clear()
    }
    g_mem.game_state = new_state
	g_mem.game_state.init(g_mem)
    return g_mem
}

clear::proc(){
    if (g_mem.game_state == {} && g_mem.game_state.clear != nil){
        g_mem.game_state.clear()
    }
    free(g_mem)
}

set_current_state :: proc(i:u64){
    g_mem.current_state = i
}

game_memory :: proc() -> ^GameMemory {
	return g_mem
}

