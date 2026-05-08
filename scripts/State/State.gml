function state(_name = "")  constructor {
    name = _name
    apply_moviment = true
    static enter = function(){}
    static update = function(){}
    static leave= function(){}
    static draw = function(){}
}

function start_state(_state){
    last_state = -1
    current_state = _state
    current_state.enter()
}

function change_state(_state) {
    current_state.leave()
    last_state = current_state.name
    current_state = _state
    current_state.enter()
}

function update_state() {
    current_state.update()
}