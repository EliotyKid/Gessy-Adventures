enum CAM_MODE {
  FOLLOW_OBJECT,
  TO_TARGET
}

game_enable_view_port()

size = new Vec2(camera_get_view_width(global.game_settings.view_cam), camera_get_view_height(global.game_settings.view_cam))
pos = new Vec2(0,0)

mode = CAM_MODE.FOLLOW_OBJECT
to_target_pos = new Vec2(0)

spd = .1

zoom_percent = 0
new_zoom_percent = 0
zoom_range = .5
zoom_spd = .05

size_zoom = size

camera_set_view_size(global.game_settings.view_cam, size_zoom.x, size_zoom.y)

view = noone