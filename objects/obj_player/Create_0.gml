#region Variables
hsp = 0
vsp = 0
maxHspWalk = 1
maxHspRun = 3
maxVsp = 5

maxHspCurrent = maxHspWalk

acc = .2
move_dir = 0
move_dir_before = 0

var _tl = layer_tilemap_get_id("tile_collision")
colision_list = [_tl]
is_ground = false

qtd_jumps = 1
max_qtd_jumps = qtd_jumps

coyote_timer = 10
max_coyote_timer = coyote_timer

buffer_jump_timer = 0
max_buffer_jump_timer = 10

cornner_pixels = 8

is_turning = false
facing_dir = 1
turn_target_dir = 1
turn_next_state = noone

combo = 0
buffer_atack_timer = 10
max_buffer_atack_timer = buffer_atack_timer
#endregion




#region States
#region Create States
state_idle = new state("idle")
state_walk = new state("walk")
state_run= new state("run")
state_jump= new state("jump")
state_fall= new state("fall")
state_run_to_idle = new state("run to idle")
state_turn = new state("turn")
state_lgrab = new state("lgrab")
state_lgrab_loop = new state("lgrab loop")
state_lgrab_climb = new state("lgrab climb")
state_atack = new state("atack")

start_state(state_idle)
#endregion

#region Idle
state_idle.enter = function() {
    change_sprite(spr_player_idle)
    hsp = 0
}
state_idle.update = function (){
    if should_start_turn() {
        start_turn(move_dir)
        exit
    }
    
    if move_dir != 0 {
        if GetInput(KEYS.SHIFT) change_state(state_run)
        else change_state(state_walk)
    }
    
   do_atack()
    
    if !is_ground && last_state != "lgrab climb" change_state(state_fall)
    do_jump()
}
#endregion
#region walk
state_walk.enter = function() {
    change_sprite(spr_player_walk)
    maxHspCurrent = maxHspWalk
}
state_walk.update = function(){
    if should_start_turn() {
        start_turn(move_dir)
        exit
    }
    
    if move_dir == 0 && abs(hsp) <.1 change_state(state_idle)
    
    if GetInput(KEYS.SHIFT) && move_dir != 0 change_state(state_run)
    
    if !is_ground change_state(state_fall)
    do_jump()
}

#endregion
#region Run
state_run.enter = function() {
    is_turning = false
    change_sprite(spr_player_run)
    maxHspCurrent = maxHspRun
}

state_run.update = function() {
    if should_start_turn() {
        start_turn(move_dir)
        exit
    }
    
    if (move_dir != 0 && !GetInput(KEYS.SHIFT)) change_state(state_walk);
        
    // Só entra no estado de animação de parada se a velocidade baixou o suficiente
    if (move_dir == 0 && abs(hsp) < (maxHspRun * 0.8)) {
        change_state(state_run_to_idle);
    }
    
    
    if (!is_ground) change_state(state_fall);
    do_jump();
}

#endregion
#region run to idle
state_run_to_idle.enter = function() {
    change_sprite(spr_player_run_to_idle)
}

state_run_to_idle.update = function() {
   if (move_dir != 0) {
        if (GetInput(KEYS.SHIFT)) change_state(state_run);
        else change_state(state_walk);
    }

    if (end_animation()) change_state(state_idle);
}
#endregion
#region Jump
state_jump.enter = function() {
    change_sprite(spr_player_jump)
    qtd_jumps --
    
    vsp -= maxVsp
    y+=vsp
}
state_jump.update = function()  {
    if vsp >= 0 change_state(state_fall)
        
    if GetInputReleased(KEYS.JUMP) {
        vsp *= .5
    }
    
    if place_meeting(x,y+vsp*.5,colision_list){
        var free_left = false
        var free_right = false
        
        for(var i=0; i<cornner_pixels; i++){
            free_right = !place_meeting(x+i,y+vsp*.5,colision_list)
            free_left = !place_meeting(x-i,y+vsp*.5,colision_list)
            
            if free_right {
                x += i
                break
            }
            if free_left {
                x -= i
                break
            }
            
        }

        
        if !free_left && !free_right vsp =0
    }
    
    
    do_jump()
}

#endregion
#region Fall
state_fall.enter = function() {
    change_sprite(spr_player_fall)
    if last_state != -1 {
        if last_state != "jump" && coyote_timer <=0 {
            qtd_jumps--
        }
    }
}
state_fall.update = function() {
    if is_ground {
        if buffer_jump_timer > 0{
            buffer_jump_timer=0
            change_state(state_jump)
        }else{
             change_state(state_idle)
        }
    }
        
    
    if GetInputPressed(KEYS.JUMP) {
        if qtd_jumps > 0 {
            vsp = 0
            change_state(state_jump)
        }
        
        buffer_jump_timer = max_buffer_jump_timer
    }
    
    var _pos_x = facing_dir == 1 ? bbox_right : bbox_left
    var _wall = position_meeting(_pos_x, bbox_top, colision_list)
    var _ledge = !position_meeting(_pos_x,bbox_top-4,colision_list)
    
    if _ledge && _wall && !is_ground && last_state != "lgrab" && last_state != "lgrab loop"{
        change_state(state_lgrab)
        exit
    }
}
#endregion
#region Ledge Grab
state_lgrab.apply_moviment = false
state_lgrab.enter = function() {
    change_sprite(spr_player_ledge_hang)
    vsp = 0
}

state_lgrab.update = function() {
    if end_animation(){
        change_state(state_lgrab_loop)
    }
    if GetInput(KEYS.JUMP){
        change_state(state_lgrab_climb)
    }
    if GetInput(KEYS.DOWN) {
        change_state(state_fall)
    }
}
#endregion
#region Edge grab loop
state_lgrab_loop.apply_moviment = false
state_lgrab_loop.enter = function() {
    change_sprite(spr_player_ledge_loop)
}

state_lgrab_loop.update = function() {
    if GetInput(KEYS.JUMP){
        change_state(state_lgrab_climb)
    }
    
    if GetInput(KEYS.DOWN) {
        change_state(state_fall)
    }
}
#endregion
#region Ledge grab climb
state_lgrab_climb.apply_moviment = false
state_lgrab_climb.enter = function() {
    change_sprite(spr_player_ledge_climb)
}
state_lgrab_climb.update = function (){
    if end_animation(){
        change_state(state_idle)
        x +=16 * facing_dir
        y -=29
    }
}
#endregion
#region turn
state_turn.enter = function() {
    is_turning = true
}
state_turn.update = function(){
    do_jump()
    
    if !is_ground {
        is_turning = false
        facing_dir = turn_target_dir
        image_xscale = facing_dir
        change_state(state_fall)
        exit
    }
    
    if end_animation(){
        is_turning = false
        facing_dir = turn_target_dir
        image_xscale = facing_dir
        
        if move_dir == 0 {
            change_state(state_idle)
        }
        else if  GetInput(KEYS.SHIFT ){
            change_state(state_run)
        }
        else {
            change_state(state_walk)
        }
    }
}
#endregion
#region atack
state_atack.enter = function() {
    if combo > 2 || last_state != "atack" combo = 0
    switch (combo) {
    	default:
            change_sprite(spr_player_combo_1)
            break;
        case 1 :
            change_sprite(spr_player_combo_2)
            break;
        case 2: 
            change_sprite(spr_player_combo_3)
            break;
    }
}
state_atack.update = function() {
    
    do_atack()
    
    buffer_atack_timer--
    
    if end_animation(){
        if  buffer_atack_timer > 0  {
            buffer_atack_timer = 0
             combo++ 
            change_state(state_atack)
        }else{
            if sprite_index != spr_player_combo_1_end && sprite_index != spr_player_combo_2_end && sprite_index != spr_player_combo_3_end {
                switch (combo) {
                   	default: change_sprite(spr_player_combo_1_end)  break;
                    case 1 : change_sprite(spr_player_combo_2_end)  break;
                    case 2: change_sprite(spr_player_combo_3_end)  break;
                   }
            }else{
                if end_animation() change_state(state_idle)
            }
        }
    }
}
#endregion

#endregion

do_atack =  function() {
    if GetInput(KEYS.ATACK){
        buffer_atack_timer = max_buffer_atack_timer
        change_state(state_atack)
    }
}

do_jump = function(){
    if (is_ground || qtd_jumps>0 )&& GetInputPressed(KEYS.JUMP) {
        change_state(state_jump)
    }
}


apply_velocity = function() {
    if !current_state.apply_moviment return
    move_dir_before = move_dir
    move_dir = GetInput(KEYS.RIGHT)-GetInput(KEYS.LEFT)
    
    var _multiplyer = maxHspWalk
    var _dcc  = .1
    if current_state.name == "run" {
        _dcc = .06
    }
    
    if current_state.name == "turn" {
        hsp = lerp(hsp, 0, .2)
    }else {
        hsp = lerp(hsp, move_dir * maxHspCurrent,move_dir != 0 ? acc : _dcc)
    }
    
    if !is_ground{
        vsp += GRAV
        
        coyote_timer--
        buffer_jump_timer--
    }else{
        vsp = 0
        qtd_jumps = max_qtd_jumps
        coyote_timer = max_coyote_timer
    }
    
    move_and_collide(hsp,0,colision_list,12)
    move_and_collide(0,vsp,colision_list,12)
}

function check_ground() {
    is_ground = place_meeting(x,y+1,colision_list)
}

start_turn = function(_target_dir){
    is_turning = true
    turn_target_dir = _target_dir
    
    image_index = 0 
    image_speed = 1
    
    image_xscale = facing_dir
    
    if current_state.name == "run" change_sprite(spr_player_run_turn)
    else if current_state.name == "walk" change_sprite(spr_player_walk_turn)
    else if current_state.name == "idle" change_sprite(spr_player_idle_turn)
        
    change_state(state_turn)
}

should_start_turn = function() {
    if !is_ground return false
        
    if current_state.name == "turn" return false
    if current_state.name == "jump" return false
    if current_state.name == "fall" return false
        
    if move_dir == 0 return false
        
    return move_dir != facing_dir
}

view = noone