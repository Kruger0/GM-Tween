
if (mouse_check_button_pressed(mb_middle)) {
    var _duration = 1;
    var _ease = __TweenEaseOutElastic;

    if (tween) tween.Destroy();
    tween = new Tween(id);
    tween.Variable(id, "yOff", 4, _duration).From(10).SetEase(_ease)
}