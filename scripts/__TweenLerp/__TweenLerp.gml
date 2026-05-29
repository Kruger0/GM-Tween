
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

/// @ignore
function __TweenLerpString(val1, val2, amount) {
    if (amount <= 0) return val1;
    if (amount >= 1) return val2;
    var _val1 = string(val1);
    var _val2 = string(val2);
    var _oldLen = string_length(_val1);
    var _newLen = string_length(_val2);
    var _currLen = round(lerp(_oldLen, _newLen, amount));
    if (_currLen == 0) return "";
    var _result = "";
    for (var i = 1; i <= _currLen; i++) {
        var _oldChr = (i <= _oldLen) ? string_ord_at(_val1, i) : 33;
        var _newChr = (i <= _newLen) ? string_ord_at(_val2, i) : 33;
        var _ascii = round(lerp(_oldChr, _newChr, amount));
        _ascii = clamp(_ascii, 32, 126);
        _result += chr(_ascii);
    }
    return _result;
}
