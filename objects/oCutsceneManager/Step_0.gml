var _current_scene = scene_info[scene]

var _len = array_length(_current_scene)-1

switch (_len) {
	case 0: script_execute(_current_scene[0]) break;
	default: script_execute_ext(_current_scene[0],_current_scene[1]) break
}

