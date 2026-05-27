
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
}

/// @ignore
function __TweenInterval() : __TweenStep() constructor {
    __type = __TWEEN_TYPE.INTERVAL;
}

/// @ignore
function __TweenCallback() : __TweenStep() constructor {
    __type = __TWEEN_TYPE.CALLBACK;
    __func = undefined;
    __args = undefined;
}

/// @ignore
function __TweenValue() : __TweenStep() constructor {
    __type = __TWEEN_TYPE.VALUE;
    __variable = "";
    __from = undefined;
    __target = 0;
    __ease = undefined;
    __interpolate = lerp;
    
    static SetEase = function(animCurve, animChannel = 0) {
        __ease = animcurve_get_channel(animCurve, animChannel);
        return self;
    }
    static SetDelay = function(value) {
        __delay = value;
        return self;
    }
    static From = function(value) {
        __from = value;
        return self;
    }
}

/// @ignore
function __TweenVariable() : __TweenValue() constructor {
    __type = __TWEEN_TYPE.VARIABLE;
    __interpolate = __TweenLerpValue;
}

/// @ignore
function __TweenColor() : __TweenValue() constructor {
    __type = __TWEEN_TYPE.COLOR;
    __interpolate = __TweenLerpColor;
}

/// @ignore
function __TweenAngle() : __TweenValue() constructor {
    __type = __TWEEN_TYPE.ANGLE;
    __interpolate = __TweenLerpAngle;
}
