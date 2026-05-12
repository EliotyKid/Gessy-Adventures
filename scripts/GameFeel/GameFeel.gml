function InitGameFeelvaraibles() {
    scale = new Vec2(1)
}


function DrawSelf(){
    draw_sprite_ext(sprite_index,image_index,x,y,scale.x,scale.y,image_angle,image_blend,image_alpha)
}

function SquashSet(_x, _y=_x) {
    scale.x = _x
    scale.y = _y
}

function SquashReset(_x = 1, _y = _x){
    scale.x = lerp(scale.x,_x,.1)
    scale.y = lerp(scale.y,_y,.1)
}
