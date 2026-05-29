// feather ignore all
/// @ignore
function __TweenInit() {
    static __data = undefined;
    if (is_undefined(__data)) {
        __data = {
            dt: 1,
            tweens: [],
            timeSource: undefined,
            defaultEase: animcurve_get_channel(TWEEN_EASE_LINEAR, TWEEN_CHANNEL_IN),
            dbgView: pointer_null,
            dbgSections: {},
            dbgMode: false,
        }
        if (GM_build_type == "run" && debug_mode) {
            global.__Tween = __data;
        }
        __TweenDebug();
    }
    with (__data) {
        if (!time_source_exists(timeSource)) {
            timeSource = time_source_create(time_source_game, 1, time_source_units_frames, function() {
                var _data = __TweenInit();
                var _tweens = _data.tweens;
                for (var i = array_length(_tweens)-1; i >= 0; i--) {
                    var _tween = _tweens[i];
                    if (_tween.__dead) {
                        array_delete(_tweens, i, 1);
                    } else {
                        _tween.__Update();
                    }
                }
            }, [], -1);
            time_source_start(timeSource);
        }
    }
    return __data;
}
