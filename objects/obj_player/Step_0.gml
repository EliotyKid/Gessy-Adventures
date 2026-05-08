check_ground()
apply_velocity()
update_state()


if current_state.name != "turn" {
    if move_dir != 0 {
        facing_dir = move_dir
        image_xscale = facing_dir
    }
}
    
current_state_name = current_state.name