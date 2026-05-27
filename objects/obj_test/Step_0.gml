
if (mouse_check_button_pressed(mb_left)) {
    var _t = new Tween(id);
    _t.SetParallel(true);
    _t.Variable(id, "x", mouse_x, 1).SetEase(__TweenEaseOutBounce);
    _t.Variable(id, "y", mouse_y, 1).SetEase(__TweenEaseOutBounce);
    _t.SetParallel(false);
    _t.Variable(id, "alpha", 1, 1).SetEase(__TweenEaseOutBounce);
    var _foo = 1;
}