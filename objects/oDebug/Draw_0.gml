if global.debugMode &&  global.showColisionMask{
  with all {
    draw_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,true)
  }
}