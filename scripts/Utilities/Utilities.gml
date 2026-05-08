function Vec2(_x, _y=_x) constructor {
  x = _x
  y = _y
}

function change_sprite(_sprite){
    if sprite_index != _sprite {
        sprite_index = _sprite
        image_index = 0
    }
}

function end_animation(){
    return image_index  >= image_number-1
}