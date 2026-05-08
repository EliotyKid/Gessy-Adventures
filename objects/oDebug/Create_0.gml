
active_debug = function(){
  if !DEBUG return
  if keyboard_check_pressed(vk_f3) {
    global.debugMode = !global.debugMode
    if global.debugMode {
      show_debug_overlay(1)
      //show_debug_log(true)
    }
    else{
      show_debug_overlay(0)
      //show_debug_log(0)
    }
    
    with (all) {
    	event_user(0)
    }
  }
}