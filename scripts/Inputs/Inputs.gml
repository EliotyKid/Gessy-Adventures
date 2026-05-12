enum KEYS {
  RIGHT,
  LEFT,
  JUMP,
  SHIFT,
  DOWN,
  ATACK,
}


function ___init_binds() {
    #region binds
    AddKeyBind(KEYS.RIGHT,"right",[ord("D"), vk_right], ,gp_padr)
    AddKeyBind(KEYS.LEFT,"left",[ord("A"), vk_left], , gp_padl)
    AddKeyBind(KEYS.JUMP,"jump",vk_space,,gp_face1)
    AddKeyBind(KEYS.SHIFT,"shift",vk_shift)
    AddKeyBind(KEYS.DOWN,"down",ord("S"))
    AddKeyBind(KEYS.ATACK,"atack",ord("E"),mb_left)
    #endregion
    
    #region Virtual Butons
    CreateVirtuaButton(new Vec2(30,global.game_settings.gui_height*.8), new Vec2(40), KEYS.LEFT)
    CreateVirtuaButton(new Vec2(80,global.game_settings.gui_height*.8), new Vec2(40), KEYS.RIGHT)
    CreateVirtuaButton(new Vec2(global.game_settings.gui_width*.8,global.game_settings.gui_height*.8), new Vec2(40), KEYS.JUMP)
    CreateVirtuaButton(new Vec2(global.game_settings.gui_width*.9,global.game_settings.gui_height*.6), new Vec2(40), KEYS.ATACK)
    #endregion
}
