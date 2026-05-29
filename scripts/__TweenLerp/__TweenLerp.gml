
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
    static __space = " ";
    static __rangeMin = 33;
    static __rangeMax = 126;
    var _len1 = string_length(val1);
    var _len2 = string_length(val2);
    var _targLen = round(_len1 + (_len2 - _len1) * amount);
    var _maxLen = max(_len1, _len2);
    var _s1 = val1;
    var _s2 = val2;
    if (_len1 < _maxLen) _s1 += string_repeat(__space, _maxLen - _len1);
    if (_len2 < _maxLen) _s2 += string_repeat(__space, _maxLen - _len2);
    var _result = "";
    for (var i = 1; i <= _maxLen; i++) {
        var _chr1 = string_char_at(_s1, i);
        var _chr2 = string_char_at(_s2, i);
        var _ord1 = ord(_chr1);
        var _ord2 = ord(_chr2);
        var _ordRnd;
        if (amount > 0 && amount < 1 && (_chr1 == __space || _chr2 == __space)) {
            _ordRnd= irandom_range(__rangeMin, __rangeMax);
        } else {
            _ordRnd= round(_ord1 + (_ord2 - _ord1) * amount);
        }
        _result += chr(_ordRnd);
    }
    return string_copy(_result, 1, _targLen);
}
