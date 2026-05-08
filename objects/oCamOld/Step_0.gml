

switch (mode) {
	case CAM_MODE.FOLLOW_OBJECT:
    if !instance_exists(object) break;
    pos.x = lerp(pos.x,object.x-sizeZoom.x*.5,spd)
    pos.y  =lerp(pos.y,object.y-sizeZoom.y*.5-object.sprite_height*.5,spd)
  
    break;
  case CAM_MODE.TO_TARGET:
    pos.x = lerp(pos.x,target.x-sizeZoom.x*.5,spd)
    pos.y = lerp(pos.y,target.y-sizeZoom.y*.5,spd)
    break;
}

new_zoom_percent += (keyboard_check(vk_down)-keyboard_check(vk_up))*zoom_spd
zoom_percent = lerp(zoom_percent,new_zoom_percent,zoom_spd)
zoom_percent = clamp(zoom_percent,-1,1)

var oldSize = new Vec2(camera_get_view_width(cam),camera_get_view_height(cam))

sizeZoom = new Vec2(size.x -(size.x * (zoom_range*zoom_percent)) ,size.y - (size.y * (zoom_range*zoom_percent)))

camera_set_view_size( global.game_settings.view_cam,sizeZoom.x,sizeZoom.y)

pos.x = pos.x - (sizeZoom.x - oldSize.x) * .5
pos.y = pos.y - (sizeZoom.y - oldSize.y) * .5

pos.x = clamp(pos.x,0,room_width-sizeZoom.x)
pos.y = clamp(pos.y,0,room_height-sizeZoom.y)

camera_set_view_pos( global.game_settings.view_cam,pos.x,pos.y)
