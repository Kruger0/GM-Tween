
if (mouse_check_button_pressed(mb_middle)) {
    var _duration = 1;
    if (tween) tween.Destroy();
    tween = new Tween(id).ParallelBegin();
    tween.Variable(id, "yOff", 4, _duration).From(10).SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT);
    tween.Callback(obj_test.points.increase);
    tween.Method(obj_test.points.test, 0, 1, 0.4)
}
