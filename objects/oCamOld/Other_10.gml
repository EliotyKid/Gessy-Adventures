if global.debugMode{
  if !dbg_view_exists(view) view = dbg_view("Camera", false,60,80)
}else{
  if dbg_view_exists(view) dbg_view_delete(view)
  exit
}

dbg_section("Infos")
dbg_watch(ref_create(id,"pos"),"Position")
dbg_watch(ref_create(id,"size"),"Size")

dbg_section("Zoom")
dbg_watch(ref_create(id,"zoom_range"), "Zoom Range")
dbg_watch(ref_create(id,"sizeZoom"), "Size with zoom")
dbg_slider(ref_create(id,"new_zoom_percent"), -1,1,"Zoom percent", .01)

dbg_section("Cam modes")
dbg_drop_down(ref_create(id,"mode"),"FollowObject:0,ToTarget:1","Camera Mode")
dbg_watch(ref_create(id,"object"),"Object to follow")
dbg_watch(ref_create(id,"target"),"Target")