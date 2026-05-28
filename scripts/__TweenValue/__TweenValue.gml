
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
    static SetInterpolate = function(func) {
        __interpolate = method(self, func);
        return self;
    }
    static Relative = function() {
        // to = from + target
        return self;
    }
    static From = function(value) {
        __from = value;
        return self;
    }
    static FromCurrent = function() {
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

/// @ignore
function __TweenMethod() : __TweenValue() constructor {
    __type = __TWEEN_TYPE.METHOD;
    __interpolate = __TweenLerpValue;
}
