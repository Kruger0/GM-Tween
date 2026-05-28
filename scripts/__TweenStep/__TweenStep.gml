
/// @ignore
function __TweenStep() constructor {
    __parallel = false;
    __done = false;
    __delay = 0;
    __type = undefined;
    __remaining = 0;
    __elapsed = 0;
    __duration = 0;
    __instance = undefined;
    __func = undefined;
}

/// @ignore
function __TweenInterval() : __TweenStep() constructor {
    __type = __TWEEN_TYPE.INTERVAL;
}

/// @ignore
function __TweenCallback() : __TweenStep() constructor {
    __type = __TWEEN_TYPE.CALLBACK;
    __args = undefined;
}
