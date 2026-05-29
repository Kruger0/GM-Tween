
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
    __elapsed = 0;
    __events = array_create(__TWEEN_EVENT.LENGTH, false);
    array_push(__data.tweens, self);
    
    static __Build = function(type, instance, variable, target, duration) {
        var _step = new type();
        _step.__instance = instance;
        _step.__variable = variable;
        _step.__target = target;
        _step.__duration = duration;
        return _step;
    }
    static __Push = function(step) {
        if (__parallel) {
            array_push(array_last(__steps), step);
        } else {
            array_push(__steps, step);
        }
        return step;
    }
    static __Update = function() {
        for (var i = 0; i < __TWEEN_EVENT.LENGTH; i++) {
            __events[i] = false;
        }
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
        var _dt = (__data.dt / game_get_speed(gamespeed_fps)) * __speed;
        __elapsed += _dt;
        if (is_array(_slot)) {
            // Parallel
            var _done = true;
            for (var i = 0; i < array_length(_slot); i++) {
                var _step = _slot[i];
                if (!_step.__done) {
                    __Execute(_step, _dt);
                    if (!_step.__done) _done = false;
                }
            }
            if (_done) __Advance();
        } else {
            // Sequential
            __Execute(_slot, _dt);
            if (_slot.__done) __Advance();
        }
    }
    static __Execute = function(step, dt) {
        static __data = __TweenInit();
        if (step.__remaining > 0) {
            step.__remaining -= dt;
            return;
        }
        with (step) {
            var _ease = __ease ?? other.__ease ?? __data.defaultEase;
            __from ??= variable_instance_get(__instance ?? -1, __variable) ?? 0;
            __elapsed += dt;
            var _pos = clamp(__elapsed / __duration, 0, 1);
            var _to = (__relative ? __from + __target : __target);
            var _t = animcurve_channel_evaluate(_ease, _pos);
            var _val = __lerp(__from, _to, _t);
            switch (__type) {
                case __TWEEN_TYPE.VARIABLE:
                case __TWEEN_TYPE.COLOR:
                case __TWEEN_TYPE.ANGLE:
                case __TWEEN_TYPE.STRING:{
                    variable_instance_set(__instance, __variable, _val);
                } break;
            
                case __TWEEN_TYPE.INTERVAL: {
                    // Wait
                } break;
            
                case __TWEEN_TYPE.CALLBACK: {
                    method_call(__func, __args);
                    __done = true;
                } break;
                
                case __TWEEN_TYPE.METHOD: {
                    method_call(__func, [_val]);
                } break;
            }
            if (__elapsed >= __duration) __done = true;
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
        __elapsed = 0;
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
    static __Skip = function(step) {
        with (step) {
            __from ??= variable_instance_get(__instance ?? -1, __variable) ?? 0;
            var _to = (__relative ? __from + __target : __target);
            variable_instance_set(__instance, __variable, _to);
            __done = true;
        }
    }
    #endregion
    
    static Variable = function(instance, variable, target, duration) {
        var _step = __Build(__TweenVariable, instance, variable, target, duration)
        return __Push(_step);
    }
    static Color = function(instance, variable, target, duration) {
        var _step = __Build(__TweenColor, instance, variable, target, duration)
        return __Push(_step);
    }
    static Angle = function(instance, variable, target, duration) {
        var _step = __Build(__TweenAngle, instance, variable, target, duration)
        return __Push(_step);
    }
    static String = function(instance, variable, target, duration) {
        var _step = __Build(__TweenString, instance, variable, target, duration)
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
        _step.__args = (is_array(args) ? args : [args]);
        return __Push(_step);
    }
    
    static ParallelBegin = function() {
        if (__parallel) __TweenError("ParallelBegin() called without closing previous ParallelEnd()", true);
        __parallel = true;
        array_push(__steps, []);
        return self;
    }
    static ParallelEnd = function() {
        if (!__parallel) __TweenError("ParallelEnd() called without a matching ParallelBegin()", true);
        __parallel = false;
        return self;
    }
    
    static SetSpeed = function(scale) {
        __speed = scale;
        return self;
    }
    static SetLoops = function(loops = -1) {
        __loopsTotal = (loops < 1 ? -1 : loops);
        __loopsLeft = __loopsTotal;
        return self;
    }
    static SetEase = function(animCurve, animChannel = 0) {
        __ease = animcurve_get_channel(animCurve, animChannel);
        return self;
    }
    
    static GetLoops = function() {
        return __loopsTotal;
    }
    static GetLoopsLeft = function() {
        return __loopsLeft;
    }
    static GetElapsedTime = function() {
        return __elapsed;
    }
    
    static IsRunning = function() {
        return !__paused && !__dead;
    }
    static IsPaused = function() {
        return __paused;
    }
    
    static Skip = function() {
        while (__current < array_length(__steps)) {
            var _slot = __steps[__current];
            if (is_array(_slot)) {
                for (var i = 0; i < array_length(_slot); i++) {
                    __CompleteStep(_slot[i]);
                }
            } else {
                __CompleteStep(_slot);
            }
            __current++;
        }
        __dead = true;
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
        __paused = true;
        __Reset();
        return self;
    }
    static Finished = function() {
        return __events[__TWEEN_EVENT.FINISHED];
    }
    static LoopFinished = function() {
        return __events[__TWEEN_EVENT.LOOP_FINISHED];
    }
    static StepFinished = function() {
        return __events[__TWEEN_EVENT.STEP_FINISHED];
    }
    static Destroy = function() {
        __paused = true;
        __dead = true;
    }
}
