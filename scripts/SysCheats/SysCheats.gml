function ApplyCheats() {
    static input_seq = ""
    static timer = 0
    static max_len = 30
    static delay = 120

    var _key_added = "" 
    
    // Captura setas (Mapeamento rápido)
    if (keyboard_check_pressed(vk_anykey)) {
        if (keyboard_check_pressed(vk_up))    _key_added = "U"
        else if (keyboard_check_pressed(vk_down))  _key_added = "D"
        else if (keyboard_check_pressed(vk_left))  _key_added = "L"
        else if (keyboard_check_pressed(vk_right)) _key_added = "R"
    }
    
    if (keyboard_string != "") {
        _key_added = string_lower(keyboard_string)
        keyboard_string = ""
    }

    // Lógica de Sequência
    if (_key_added != "") {
        input_seq += _key_added
        timer = 0

        // Clamp da string (Otimizado: deleta tudo que exceder o limite de uma vez)
        if (string_length(input_seq) > max_len) {
            input_seq = string_copy(input_seq, 2, max_len)
        }

        // Verificação em Cache
        var _db = global.___cheats_db
        var _size = array_length(_db)
        
        for (var i = 0; i < _size; i++) {
            var _c = _db[i]
            // string_ends_with é mais rápido que string_pos se o cheat for a última coisa digitada
            if (string_ends_with(input_seq, _c.sequence)) {
                _c.scr()
                input_seq = ""; // Limpa para evitar ativação dupla [cite: 5]
                show_debug_message("Cheat: " + _c.name)
                break; 
            }
        }
    } else {
        // Se não houver tecla, apenas incrementa o timer de expiração
        if (input_seq != "") {
            timer++
            if (timer > delay) {
                input_seq = ""
                timer = 0
            }
        }
    }
}

function CreateCheat(_name, _sequence, _scr) {
    if (!variable_global_exists("___cheats_db")) {
        global.___cheats_db = []
    }
    
    array_push(global.___cheats_db, {
        name: _name,
        sequence: string_lower(_sequence),
        scr: _scr
    });
}