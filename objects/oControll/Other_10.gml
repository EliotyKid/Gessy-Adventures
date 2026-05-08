if !DEBUG exit
  
if global.debugMode{
  if !dbg_view_exists(view) view = dbg_view("General", false,60,80)
}else{
  if dbg_view_exists(view) dbg_view_delete(view)
  exit
}

dbg_section("Algo",true)
dbg_checkbox(ref_create(global, "showColisionMask"), "Show Colision Mask")