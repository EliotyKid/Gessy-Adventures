




size = new Vec2(camera_get_view_width(global.game_settings.view),camera_get_view_height(global.game_settings.view))
cam = global.game_settings.view_cam
pos = new Vec2(camera_get_view_x(cam),camera_get_view_y(cam))


mode = CAM_MODE.TO_TARGET
object = obj_player
target = new Vec2(500,500)

spd = .1

zoom_percent = 0
new_zoom_percent = 0
zoom_range = .5
zoom_spd = .05


sizeZoom = size

camera_set_view_size( global.game_settings.view_cam,sizeZoom.x,sizeZoom.y)

view = noone

