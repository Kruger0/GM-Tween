
/// @ignore
function __TweenValue() : __TweenStep() constructor {
    __type = __TWEEN_TYPE.VALUE;
    
    static SetEase = function(animCurve, animChannel = 0) {
        __ease = animcurve_get_channel(animCurve, animChannel);
        return self;
    }
    static SetDelay = function(value) {
        __delay = value;
        return self;
    }
    static SetInterpolate = function(func) {
        __lerp = method(self, func);
        return self;
    }
    static Relative = function() {
        __relative = true;
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
    __lerp = __TweenLerpValue;
}

/// @ignore
function __TweenColor() : __TweenValue() constructor {
    __type = __TWEEN_TYPE.COLOR;
    __lerp = __TweenLerpColor;
}

/// @ignore
function __TweenAngle() : __TweenValue() constructor {
    __type = __TWEEN_TYPE.ANGLE;
    __lerp = __TweenLerpAngle;
}

/// @ignore
function __TweenString() : __TweenValue() constructor {
    __type = __TWEEN_TYPE.ANGLE;
    __lerp = __TweenLerpString;
}

/// @ignore
function __TweenMethod() : __TweenValue() constructor {
    __type = __TWEEN_TYPE.METHOD;
    __lerp = __TweenLerpValue;
}
