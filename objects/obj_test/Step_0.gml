
if (mouse_check_button_pressed(mb_left)) {
    if (tween) tween.Destroy();
    tween = new Tween(id);
    
    // Donnut
    var _ease = __TweenEaseOutBack;
    var _duration = 1.0;
    tween.SetParallel(true);
    tween.Variable(id, "x", mouse_x, _duration).SetEase(_ease);
    tween.Variable(id, "y", mouse_y, _duration).SetEase(_ease);
    tween.Variable(id, "image_xscale", 1, _duration).From(1.2).SetEase(_ease);
    tween.Variable(id, "image_yscale", 1, _duration).From(0.8).SetEase(_ease);
    tween.SetParallel(false);
}

if (mouse_check_button_pressed(mb_right)) {
    if (tween) tween.Destroy();
    tween = new Tween(id);
    
    // Arrow
    var _ease = __TweenEaseLinear;
    
    var _duration = 0.8;
    var _dir = point_direction(room_width/2, room_height/2, mouse_x, mouse_y);
    tween.SetParallel(true);
    tween.Angle(id, "angle", _dir, _duration).SetEase(__TweenEaseOutElastic);
    tween.Color(id, "color", c_lime, _duration).SetEase(_ease);
    tween.SetParallel(false);
    
    tween.Color(id, "color", c_white, _duration).SetEase(_ease);
}