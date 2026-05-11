if !DEBUG exit
  
if global.debugMode{
  if !dbg_view_exists(view) view = dbg_view("Player", false,60,80)
}else{
  if dbg_view_exists(view) dbg_view_delete(view)
    
  exit
}


dbg_section("Visual",true)
dbg_sprite(ref_create(self, "sprite_index"), ref_create(self, "image_index"),"sprite",128,128);


dbg_section("Movimentation",true)
dbg_watch(ref_create(id,"hsp"),"hsp")
dbg_watch(ref_create(id,"vsp"),"vsp")
dbg_slider(ref_create(id,"maxHspWalk"),.5,3,"Max Walk Hsp",.1)
dbg_slider(ref_create(id,"maxHspRun"),2,10,"Max Run Hsp",.1)
dbg_slider(ref_create(id,"maxVsp"),0,30,"Max Vsp",.5)
dbg_text(" the strength of the jump is -maxVsp")
//dbg_text_separator("test",1)
dbg_watch(ref_create(id,"qtd_jumps"),"Number Jumps")
dbg_watch(ref_create(id,"coyote_timer"), "Coyote Timer")
dbg_watch(ref_create(id,"buffer_jump_timer"), "Jump Buffer Timer")
dbg_watch(ref_create(id,"buffer_atack_timer"), "Atack Buffer Timer")
dbg_watch(ref_create(id,"combo"), "Combo")

dbg_section("State Machine",true)
dbg_watch(ref_create(id,"current_state_name"), "Current State")
//dbg_watch(ref_create(id,"state_timer"), "State Timer")
dbg_watch(ref_create(id,"last_state"), "Last State")
