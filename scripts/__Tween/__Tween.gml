
function Tween(source = undefined) constructor {
    
    #region Private
    static __data = __TweenInit();
    __source = source;
    __steps = [];
    __current = 0;
    __speed = 1.0;
    __ease = undefined;
    __loopsTotal = 1;
    __loopsLeft = __loopsTotal;
    __paused = false;
    __parallel = false;
    __dead = false;
    array_push(__data.tweens, self);
    
    static __Push = function(step) {
        if (__parallel && array_length(__steps) > 0) {
            var _last = array_last(__steps);
            if (is_array(_last)) {
                array_push(_last, step);
            } else {
                array_pop(__steps);
                array_push(__steps, [_last, step]);
            }
        } else {
            array_push(__steps, step);
        }
        return step;
    }
    static __Update = function() {
        if (__dead) return;
        if (!is_undefined(__source) && !instance_exists(__source)) {
            __dead = true;
            return;
        }
        if (!__paused) __Process();
    }
    static __Process = function() {
        if (array_length(__steps) == 0) return;
        if (__current >= array_length(__steps)) return;
        var _slot = __steps[__current];
        if (is_array(_slot)) {
            // Parallel
            var _done = true;
            for (var i = 0; i < array_length(_slot); i++) {
                var _step = _slot[i];
                if (!_step.__done) {
                    __Execute(_step);
                    if (!_step.__done) _done = false;
                }
            }
            if (_done) __Advance();
        } else {
            // Sequential
            __Execute(_slot);
            if (_slot.__done) __Advance();
        }
    }
    static __Execute = function(step) {
        static __data = __TweenInit();
        var _dt = (__data.dt / game_get_speed(gamespeed_fps)) * __speed;
        if (step.__remaining > 0) {
            step.__remaining -= _dt;
            return;
        }
        with (step) {
            switch (__type) {
                case __TWEEN_TYPE.VARIABLE:
                case __TWEEN_TYPE.COLOR:
                case __TWEEN_TYPE.ANGLE:{
                    __from ??= variable_instance_get(__instance, __variable) ?? 0;
                    __elapsed += _dt;
                    var _t = clamp(__elapsed / __duration, 0, 1);
                    if (__ease != undefined) {
                        _t = animcurve_channel_evaluate(__ease, _t);
                    }
                    variable_instance_set(__instance, __variable, __interpolate(__from, __target, _t));
                    if (__elapsed >= __duration) __done = true;
                } break;
            
                case __TWEEN_TYPE.INTERVAL: {
                    __elapsed += _dt;
                    if (__elapsed >= __duration) __done = true;
                } break;
            
                case __TWEEN_TYPE.CALLBACK: {
                    script_execute_ext(__func, __args);
                    __done = true;
                } break;
                
                case __TWEEN_TYPE.METHOD: {
                    __from ??= 0;
                    __elapsed += _dt;
                    var _t = clamp(__elapsed / __duration, 0, 1);
                    if (__ease != undefined) {
                        _t = animcurve_channel_evaluate(__ease, _t);
                    }
                    var _val = __interpolate(__from, __target, _t);
                    __func(_val);
                    if (__elapsed >= __duration) __done = true;
                } break;
            }
        }
    }
    static __Advance = function() {
        __current++;
        if (__current >= array_length(__steps)) {
            if (__loopsTotal == -1) {
                __Reset();
            } else {
                __loopsLeft--;
                if (__loopsLeft <= 0) {
                    __dead = true;
                } else {
                    __Reset();
                }
            }
        }
    }
    static __Reset = function() {
        __current = 0;
        for (var i = 0; i < array_length(__steps); i++) {
            var _slot = __steps[i];
            if (is_array(_slot)) {
                for (var j = 0; j < array_length(_slot); j++) {
                    var _step = _slot[j];
                    _step.__elapsed = 0;
                    _step.__done = false;
                    _step.__remaining = _step.__delay;
                }
            } else {
                _slot.__elapsed = 0;
                _slot.__done = false;
                _slot.__remaining = _slot.__delay;
            }
        }
    }
    #endregion
    
    /// @arg instance The instance or struct scope
    static Variable = function(instance, variable, target, duration) {
        var _step = new __TweenVariable();
        _step.__instance = instance;
        _step.__variable = variable;
        _step.__target = target;
        _step.__duration = duration;
        return __Push(_step);
    }
    static Color = function(instance, variable, target, duration) {
        var _step = new __TweenColor();
        _step.__instance = instance;
        _step.__variable = variable;
        _step.__target = target;
        _step.__duration = duration;
        return __Push(_step);
    }
    static Angle = function(instance, variable, target, duration) {
        var _step = new __TweenAngle();
        _step.__instance = instance;
        _step.__variable = variable;
        _step.__target = target;
        _step.__duration = duration;
        return __Push(_step);
    }
    static Method = function(func, from, to, duration) {
        var _step = new __TweenMethod();
        _step.__func = func;
        _step.__from = from;
        _step.__target = to;
        _step.__duration = duration;
        return __Push(_step);
    }
    static Interval = function(duration) {
        var _step = new __TweenInterval();
        _step.__duration = duration;
        return __Push(_step);
    }
    static Callback = function(func, args = []) {
        var _step = new __TweenCallback();
        _step.__func = func;
        _step.__args = args;
        return __Push(_step);
    }
    
    static SetParallel = function(parallel) {
        __parallel = parallel;
        return self;
    }
    static SetSpeed = function(scale) {
        __speed = scale;
        return self;
    }
    static SetLoops = function(loops = 0) {
        __loopsTotal = loops;
        __loopsLeft = __loopsTotal;
        return self;
    }
    static SetEase = function(animCurve, animChannel = 0) {
        var _curve = animCurve;
        if (is_numeric(animCurve)) {
            switch (animCurve) {
                
            }
        }
        __ease = animcurve_get_channel(_curve, animChannel);
        return self;
    }
    
    static GetLoops = function() {
        return __loopsTotal;
    }
    static GetLoopsLeft = function() {
        return __loopsLeft;
    }
    static GetElapsedTime = function() {
        
    }
    
    static IsRunning = function() {
        
    }
    static IsPaused = function() {
        return __paused;
    }
    
    static Parallel = function() {
        __parallel = true;
        return self;
    }
    static Pause = function() {
        __paused = true;
        return self;
    }
    static Play = function() {
        __paused = false;
        return self;
    }
    static Stop = function() {
        
    }
    static Finished = function() {
        
    }
    static LoopFinished = function() {
        
    }
    static StepFinished = function() {
        
    }
    static Destroy = function() {
        __paused = true;
        __dead = true;
    }
}
