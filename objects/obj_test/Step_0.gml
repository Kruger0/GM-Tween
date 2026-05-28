
if (mouse_check_button_pressed(mb_left)) {
    if (tween) tween.Destroy();
    tween = new Tween(id);
    
    // Donnut
    var _duration = 1.0;
    tween.SetParallel(true);
    tween.Variable(id, "x", mouse_x, _duration).SetEase(TWEEN_EASE_BACK, TWEEN_CHANNEL_OUT);
    tween.Variable(id, "y", mouse_y, _duration).SetEase(TWEEN_EASE_BACK, TWEEN_CHANNEL_OUT);
    tween.Variable(id, "image_xscale", 1, _duration).From(1.2).SetEase(TWEEN_EASE_BACK, TWEEN_CHANNEL_OUT);
    tween.Variable(id, "image_yscale", 1, _duration).From(0.8).SetEase(TWEEN_EASE_BACK, TWEEN_CHANNEL_OUT);
    tween.SetParallel(false);
}

if (mouse_check_button_pressed(mb_right)) {
    if (tween) tween.Destroy();
    tween = new Tween(id);
    
    // Arrow
    
    var _duration = 0.8;
    var _dir = point_direction(room_width/2, room_height/2, mouse_x, mouse_y);
    tween.SetParallel(true);
    tween.Angle(id, "angle", _dir, _duration).SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT);
    tween.Color(id, "color", c_lime, _duration).SetEase(TWEEN_EASE_CIRC, TWEEN_CHANNEL_OUT);
    tween.SetParallel(false);
    
    tween.Color(id, "color", c_white, _duration).SetEase(TWEEN_EASE_CIRC, TWEEN_CHANNEL_OUT);
}