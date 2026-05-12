check_ground()

if GetInputPressed(KEYS.RIGHT) {
    if (last_tap_timer_right > 0) is_runing_pressed = true
    else last_tap_timer_right = tap_window
}


if GetInputPressed(KEYS.LEFT) {
    if (last_tap_timer_left > 0) is_runing_pressed = true
    else last_tap_timer_left = tap_window
}

apply_velocity() 

if (move_dir == 0)  is_runing_pressed = false


if (last_tap_timer_left > 0) last_tap_timer_left--
if (last_tap_timer_right > 0) last_tap_timer_right--

update_state()


if current_state.name != "turn" {
    if move_dir != 0 {
        facing_dir = move_dir
        image_xscale = facing_dir
    }
}
    
current_state_name = current_state.name