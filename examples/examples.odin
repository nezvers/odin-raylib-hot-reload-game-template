package examples

import "../game_state"
import "template"
import "shapes"


ExampleEnum :: enum {
    template,
    shapes,
    count
}


get_example :: proc(i:u64) -> game_state.GameState {
    example_list: = [?]proc()->game_state.GameState {
        template.get_state,
        shapes.get_state,
    }
    state: game_state.GameState = example_list[i]()
    state.id = i
    return state
}
