//By @Elioty

function __add_sub_state(_name,_stru,_sub_state){
    if variable_struct_exists(_stru,_sub_state){
        self[$ string(_name)+"_"+_sub_state] = _stru[$ _sub_state]
    }
}

function __sub_state_execute(_state){
    if !is_undefined(self[$ current_state+"_"+_state]) script_execute(self[$ current_state+"_"+_state])
}

///@desc initializes the variables for the state machine
///@arg {String} _init_state the initial state
function lsm_init(_init_state){
    states = []
    current_state = _init_state
    enter_state = false
    free_state_enable = false
    state_timer = 0
    last_state = ""
}

///@desc updates the state every frame
function lsm_update(){
    if free_state_enable{
        if !is_undefined(self[$ "free_state_step_begin"]) script_execute(self[$ "free_state_step_begin"])
        if !is_undefined(self[$ "free_state_step"]) script_execute(self[$ "free_state_step"])
        if !is_undefined(self[$ "free_state_step_end"]) script_execute(self[$ "free_state_step_end"])
    }
    
    if enter_state == false{
        __sub_state_execute("enter")
        enter_state = true
    }
    
    
    if current_state != noone{
        __sub_state_execute("begin_step")
        __sub_state_execute("step")
        __sub_state_execute("end_step")
    }
  
    state_timer ++
    
}

///@desc draw the design of each state
function lsm_draw(){
    if !is_undefined(self[$ "free_state_draw"]) script_execute(self[$ "free_state_draw"])
    __sub_state_execute("draw")
}

///@desc draw the drawn gui of each state
function lsm_draw_gui(){
     if !is_undefined(self[$ "free_state_draw_gui"]) script_execute(self[$  "free_state_draw_gui"])
     __sub_state_execute("draw_gui")
}



///@desc add a new state
/// @arg {String} _name the name of the state
/// @arg {Struct} _stru the structure with the sub states
function lsm_add(_name, _stru = {}){
    array_push(states,_name)
    
    __add_sub_state(_name,_stru,"step")
    
    __add_sub_state(_name,_stru,"enter")
    
    __add_sub_state(_name,_stru,"begin_step")
    
    __add_sub_state(_name,_stru,"end_step")
    
    __add_sub_state(_name,_stru,"draw")
    
    __add_sub_state(_name,_stru,"draw_gui")
    
    __add_sub_state(_name,_stru,"leave")
}

///@desc change state
///@arg {String} _name name of the destination state
function lsm_change(_name){
    if !is_undefined(self[$ current_state+"_leave"]) script_execute(self[$ current_state+"_leave"])
    last_state = current_state
    current_state = _name
    enter_state = false
    state_timer = 0
}

///@desc adds a state that will run all the time
function lsm_add_free_state(_stru={ }){
    var _name = "free_state"
    free_state_enable = true
    
    __add_sub_state(_name,_stru,"step")
        
    __add_sub_state(_name,_stru,"begin_step")
    
    __add_sub_state(_name,_stru,"end_step")
    
    __add_sub_state(_name,_stru,"draw")
    
    __add_sub_state(_name,_stru,"draw_gui")
    
    __add_sub_state(_name,_stru,"leave")
}


