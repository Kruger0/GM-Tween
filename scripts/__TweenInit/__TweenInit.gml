function __TweenInit() {
    static data = {
        dt: 1,
        tweens: [],
        timeSource: undefined,
    }
    
    with (data) {
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
    return data;
}