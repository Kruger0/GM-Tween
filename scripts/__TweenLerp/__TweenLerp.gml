
/// @ignore
function __TweenLerpValue(val1, val2, amount) {
    //return val1 + (val2 - val1) * amount;
    return lerp(val1, val2, amount);
}

/// @ignore
function __TweenLerpColor(val1, val2, amount) {
    var _r = lerp(colour_get_red(val1), colour_get_red(val2), amount);
    var _g = lerp(colour_get_green(val1), colour_get_green(val2), amount);
    var _b = lerp(colour_get_blue(val1), colour_get_blue(val2), amount);
    return make_colour_rgb(_r, _g, _b);
}

/// @ignore
function __TweenLerpAngle(val1, val2, amount) {
    return val1 + angle_difference(val2, val1) * amount;
}
