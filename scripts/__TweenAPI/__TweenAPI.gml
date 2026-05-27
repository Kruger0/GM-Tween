
function Tween(source) constructor {
    static data = __TweenInit();
    
    __source = source;
    __steps = [];
    __current = 0;
    __speed = 1.0;
    __loops = 1;
    __paused = false;
    __parallel = false;
    __destroy = false;
    
    array_push(data.tweens, self);
    
    static Variable = function(instance, variable, target, duration) {
        var _step = new __TweenVariable();
        _step.__instance = instance;
        _step.__variable = variable;
        _step.__target = target;
        _step.__duration = duration;
        _step.__parallel = __parallel;
        
        if (__parallel && array_length(__steps) > 0) {
            var _last = array_last(__steps);
            if (is_array(_last)) {
                array_push(_last, _step);
            } else {
                array_pop(__steps);
                array_push(__steps, [_last, _step]);
            }
        } else {
            array_push(__steps, _step);
        }
        
        return _step;
    }
    static Interval = function(duration) {
        var _step = new __TweenInterval();
        _step.__duration = duration;
        _step.__parallel = __parallel;
        __parallel = false;
        array_push(__steps, _step);
        return self;
    }
    static Callback = function(instance, func) {
        var _step = new __TweenCallback();
        _step.__instance = instance;
        _step.__func = func;
        _step.__parallel = __parallel;
        __parallel = false;
        array_push(__steps, _step);
        return self;
    }
    
    static SetParallel = function(enabled) {
        __parallel = enabled;
        return self;
    }
    static SetSpeed = function(scale) {
        __speed = scale;
        return self;
    }
    static SetLoops = function(count) {
        __loops = count;
        return self;
    }
    
    static Pause = function() {
        __paused = true;
        return self;
    }
    static Resume = function() {
        __paused = false;
        return self;
    }
    static Destroy = function() {
        __paused = true;
        __destroy = true;
        return self;
    }
}

/// @ignore
function __TweenVariable() constructor {
    
    __instance = undefined;
    __variable = "";
    __from = undefined;
    __target = 0;
    __duration = 0;
    __delay = 0;
    __elapsed = 0;
    __parallel = false;
    __type = __TWEEN_TYPE.VARIABLE;
    __done = false;
    
    static SetEase = function(animCurve, animChannel = 0) {
        var _channel = animcurve_get_channel(animChannel, animChannel);
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
function __TweenInterval() constructor {
    
    __duration = 0;
    __elapsed = 0;
    __parallel = false;
    __type = __TWEEN_TYPE.INTERVAL;
    __done = false;
}

/// @ignore
function __TweenCallback() constructor {
    
    __instance = undefined;
    __func = undefined;
    __parallel = false;
    __type = __TWEEN_TYPE.CALLBACK;
    __done = false;
}
