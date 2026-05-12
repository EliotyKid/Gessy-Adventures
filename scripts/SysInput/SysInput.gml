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
    gamepad: [],
    virtual_active: false,
    virtual_previous: false
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
  
    if (inp.virtual_active) {
        //inp.virtual_active = false
        return true  
    }
    
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
  
    if (!inp.virtual_active && inp.virtual_previous) {
        //inp.virtual_active = false
        return true  
    }
    
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
  
    if (inp.virtual_active && !inp.virtual_previous) {
        //inp.virtual_active = false
        return true  
    }
    
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

function SetVirtualInput(_id, _is_pressed=true) {
    ___KEYBINDS[_id].virtual_active = _is_pressed;
}

function ___virtual_btn(_pos, _size,_key) constructor {
    pos  = _pos
    size =_size
    key = _key
    hovered = false
    static update = function () {
      var _found_touch = false;
      
      // Verifica os primeiros 5 slots de toque (multi-touch)
      for (var i = 0; i < 5; i++) {
          var _mx = device_mouse_x_to_gui(i);
          var _my = device_mouse_y_to_gui(i);
          
          // Verifica se o dedo 'i' está sobre o botão e pressionado
          if (device_mouse_check_button(i, mb_left)) {
              if (point_in_rectangle(_mx, _my, pos.x-size.x*.5, pos.y-size.y*.5, pos.x+size.x*.5, pos.y+size.y*.5)) {
                  _found_touch = true;
                  break; // Se encontrou um toque neste botão, não precisa checar os outros dedos
              }
          }
      }
  
      if (_found_touch) {
          SetVirtualInput(key, true);
      } else {
          if (___KEYBINDS[key].virtual_active) {
              SetVirtualInput(key, false);
          }
      }
    }
    
    static draw = function() {
        draw_rectangle(pos.x-size.x*.5,pos.y-size.y*.5,pos.x+size.x*.5,pos.y+size.y*.5, false)
    }
}

global.___virtual_btns = []
function CreateVirtuaButton(_pos,_size,_key)   {
    array_push(global.___virtual_btns, new ___virtual_btn(_pos, _size,_key))
}

function DrawVirtualBtns() {
    for(var i=0; i<array_length(global.___virtual_btns); i++){
        global.___virtual_btns[i].update()
        global.___virtual_btns[i].draw()
    }
}

function UpdateVirtualInputStates() {
    for (var i = 0; i < array_length(___KEYBINDS); i++) {
        ___KEYBINDS[i].virtual_previous = ___KEYBINDS[i].virtual_active;
    }
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

#region Virtual Butons
CreateVirtuaButton(new Vec2(30,global.game_settings.gui_height*.8), new Vec2(40), KEYS.LEFT)
CreateVirtuaButton(new Vec2(80,game_settings.gui_height*.8), new Vec2(40), KEYS.RIGHT)
CreateVirtuaButton(new Vec2(game_settings.gui_width*.8,game_settings.gui_height*.8), new Vec2(40), KEYS.JUMP)
CreateVirtuaButton(new Vec2(game_settings.gui_width*.9,game_settings.gui_height*.6), new Vec2(40), KEYS.ATACK)
#endregion