function create_cutscene(){
  var _inst = instance_create_layer(0,0,"Controlers",oCutsceneManager)
  with _inst {
    scene_info = argument0
  }
}

function CUTSYS_cutscene_end_action(){
  scene ++
  if scene > array_length(scene_info)-1{
    instance_destroy()
  }
}

function CUTSYS_cutscene_wait(){
  timer ++
  if timer >= argument0 * 60{
    timer = 0
    CUTSYS_cutscene_end_action()
  }
}

function CUTSYS_create_box_at_mouse(){
  if mouse_check_button(mb_left){
    instance_create_layer(mouse_x,mouse_y,"Player",oColisor)
    CUTSYS_cutscene_end_action()
  }
}

function CUTSYS_change_variable(){
  with argument0 {
    variable_instance_set(id,argument1,argument2)
  }
  
  CUTSYS_cutscene_end_action()
}

function CUTSYS_execute_object_method(){
  with argument0{
    var scr = variable_instance_get(id,argument1)
    script_execute(scr)
  }
}