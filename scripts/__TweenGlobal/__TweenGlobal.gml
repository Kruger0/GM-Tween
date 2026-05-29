// feather ignore all

function TweenSetDeltatime(dt) {
    static __data = __TweenInit();
    __data.dt = dt;
}

function TweenPauseAll() {
    static __data = __TweenInit();
    time_source_pause(__data.timeSource);
}

function TweenResumeAll() {
    static __data = __TweenInit();
    time_source_start(__data.timeSource);
}

function TweenStopAll() {
    static __data = __TweenInit();
    time_source_stop(__data.timeSource);
}

function TweenClearAll() {
    static __data = __TweenInit();
    var _tweens = __data.tweens;
    for (var i = 0; i < array_length(_tweens); i++) {
        _tweens[i].__dead = true;
    }
}

function TweenDestroyAll() {
    static __data = __TweenInit();
    time_source_destroy(__data.timeSource);
}

function TweenGetAll() {
    static __data = __TweenInit();
    return __data.tweens;
}
