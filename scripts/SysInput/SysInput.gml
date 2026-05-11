#region sys
global.gamepad_id = noone
function gamepad_connect()  {
  var _gamepad_slots = gamepad_get_device_count()
  for(var i=0; i<_gamepad_slots; i++)  {
    if  (gamepad_is_connected(i))  {
      global.gamepad_id = i
      return true
    }
  }
  return false
}
gamepad_connect()

enum KEYS {
  RIGHT,
  LEFT,
  JUMP,
  SHIFT,
  DOWN,
  ATACK,
}

global.___key_binds = []

#macro ___KEYBINDS global.___key_binds

function ___add_key(_id,_name,_keyboard=noone,_mouse=noone,_gamepad=noone)  {
  ___KEYBINDS[_id] = {
    name: _name,
    keyboard: [],
    mouse: [],
    gamepad: []
  }
  
  if  (_keyboard != noone)  {
    if is_array(_keyboard) ___KEYBINDS[_id].keyboard = _keyboard
    else ___KEYBINDS[_id].keyboard[0] = _keyboard
  }

  if  (_mouse != noone)  {
    if is_array(_mouse) ___KEYBINDS[_id].mouse = _mouse
    else ___KEYBINDS[_id].mouse[0] = _mouse
  }

  if  (_gamepad != noone)  {
    if is_array(_gamepad) ___KEYBINDS[_id].gamepad = _gamepad
    else ___KEYBINDS[_id].gamepad[0] = _gamepad
  }
  
}

function GetInput(_id){
  var inp = ___KEYBINDS[_id]
  
  var isTru = false
  for  (var i=0; i<array_length(inp.keyboard); i++)  {
    isTru = keyboard_check(inp.keyboard[i])
    if  (isTru)  return true
  }

  for(var i=0; i<array_length(inp.mouse); i++)  {
    isTru = mouse_check_button(inp.mouse[i])
    if  (isTru)  return true
  }
  
  for(var i=0; i<array_length(inp.gamepad); i++)  {
    isTru = gamepad_button_check(global.gamepad_id,inp.gamepad[i])
    if  (isTru)  return true
  }
  
  return false
}

function GetInputReleased(_id){
  var inp = ___KEYBINDS[_id]
  
  var isTru = false
  for  (var i=0; i<array_length(inp.keyboard); i++)  {
    isTru = keyboard_check_released(inp.keyboard[i])
    if  (isTru)  return true
  }

  for(var i=0; i<array_length(inp.mouse); i++)  {
    isTru = mouse_check_button_released(inp.mouse[i])
    if  (isTru)  return true
  }
  
  for(var i=0; i<array_length(inp.gamepad); i++)  {
    isTru = gamepad_button_check_released(global.gamepad_id,inp.gamepad[i])
    if  (isTru)  return true
  }
  
  return false
}

function GetInputPressed(_id){
  var inp = ___KEYBINDS[_id]
  
  var isTru = false
  for  (var i=0; i<array_length(inp.keyboard); i++)  {
    isTru = keyboard_check_pressed(inp.keyboard[i])
    if  (isTru)  return true
  }

  for(var i=0; i<array_length(inp.mouse); i++)  {
    isTru = mouse_check_button_pressed(inp.mouse[i])
    if  (isTru)  return true
  }
  
  for(var i=0; i<array_length(inp.gamepad); i++)  {
    isTru = gamepad_button_check_pressed(global.gamepad_id,inp.gamepad[i])
    if  (isTru)  return true
  }
  
  return false
}
#endregion

#region binds
___add_key(KEYS.RIGHT,"right",[ord("D"), vk_right], ,gp_padr)
___add_key(KEYS.LEFT,"left",[ord("A"), vk_left], , gp_padl)
___add_key(KEYS.JUMP,"jump",vk_space,,gp_face1)
___add_key(KEYS.SHIFT,"shift",vk_shift)
___add_key(KEYS.DOWN,"down",ord("S"))
___add_key(KEYS.ATACK,"atack",ord("E"))

#endregion