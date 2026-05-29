[![GitHub license](https://img.shields.io/github/license/Kruger0/GM-Tween)](https://github.com/Kruger0/GM-Tween/blob/main/LICENSE)
[![GitHub release](https://img.shields.io/github/v/release/Kruger0/GM-Tween)](https://github.com/Kruger0/GM-Tween/releases)
[![GameMaker](https://img.shields.io/badge/GameMaker-LTS2026-blue?logo=gamemaker)](https://gamemaker.io/)
[![GitHub last commit](https://img.shields.io/github/last-commit/Kruger0/GM-Tween)](https://github.com/Kruger0/GM-Tween/commits)
<div align="center">
  <h1>GM-Tween 1.0.0</h1>
</div>
GM-Tween is a tweening engine made for GameMaker, featuring a fluent chainable API, 12 easing curves, sequential and parallel step execution, and flexible interpolation for variables, colors, angles, strings, and custom methods.

## How to use!

1. Create a tween instance and chain steps together:
   ```js
   // Create a new tween
   tween = new Tween();

   // Animate a variable over 60 frames
   tween.Variable(obj_player, "x", 300, 60)
        .Execute();
   ```

2. Use the fluent API to configure steps inline:
   ```js
   // Chain multiple steps with easing
   tween.Variable(obj_player, "x", 300, 60)
           .SetEase(TWEEN_EASE_BOUNCE, TWEEN_CHANNEL_OUT)
        .Variable(obj_player, "y", 400, 60)
           .SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT)
        .Execute();
   ```

3. Run steps in parallel for simultaneous animations:
   ```js
   // Move X and Y at the same time
   tween.ParallelBegin()
           .Variable(obj_player, "x", 300, 60)
           .Variable(obj_player, "y", 400, 60)
        .ParallelEnd()
        .Execute();
   ```

4. Set loops, callbacks, and control playback:
   ```js
   tween.Variable(obj_player, "x", 300, 60)
        .Variable(obj_player, "x", 100, 60)
        .SetLoops(3)
        .OnFinished(function() {
            show_debug_message("Animation complete!");
        })
        .Execute();

   // Control playback
   tween.Pause();
   tween.Play();
   tween.Skip();  // Jump to end
   ```

## Advanced Features

### Easing Curves
12 easing curves are available via macros, each with In, Out, InOut, and OutIn channels:
```js
// Set easing on the whole tween
tween.SetEase(TWEEN_EASE_BOUNCE, TWEEN_CHANNEL_OUT)
     .Variable(obj, "x", 500, 60)
     .Execute();

// Or per-step
tween.Variable(obj, "x", 500, 60)
        .SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_IN)
     .Execute();
```

Available curves: `TWEEN_EASE_LINEAR`, `TWEEN_EASE_SINE`, `TWEEN_EASE_QUAD`, `TWEEN_EASE_CUBIC`, `TWEEN_EASE_QUART`, `TWEEN_EASE_QUINT`, `TWEEN_EASE_EXPO`, `TWEEN_EASE_CIRC`, `TWEEN_EASE_BACK`, `TWEEN_EASE_BOUNCE`, `TWEEN_EASE_ELASTIC`, `TWEEN_EASE_SPRING`.

### Color & Angle Interpolation
Color and angle tweens handle their types automatically:
```js
// Fade a color
tween.Color(obj, "colour", c_red, 60).Execute();

// Rotate with shortest angle path
tween.Angle(obj, "image_angle", 720, 120).Execute();
```

### String Animation
Animate strings by interpolating character ordinals:
```js
tween.String(obj, "caption", "HELLO WORLD", 60).Execute();
```

### Custom Method Tween
Animate arbitrary values through a callback function:
```js
tween.Method(function(value) {
    audio_set_gain(snd_music, value, 0);
}, 0, 1, 120)
.SetEase(TWEEN_EASE_SINE, TWEEN_CHANNEL_IN)
.Execute();
```

### Relative Values
Target values relative to the current value:
```js
tween.Variable(obj, "x", 200, 60)
        .Relative()
     .Execute();
```

### From Values
Override the starting value of a step:
```js
tween.Variable(obj, "x", 500, 60)
        .From(0)
     .Execute();
```

### Delay & Interval
Add delays between steps or wait without animation:
```js
tween.Variable(obj, "x", 300, 60)
     .Interval(30)             // Wait 30 frames
     .Variable(obj, "y", 400, 60)
     .Callback(function() {    // Fire a callback mid-sequence
         show_debug_message("Halfway!");
     })
     .Execute();
```

### Looping
Loop animations a finite number of times or infinitely:
```js
// Infinite loop
tween.Variable(obj, "x", 500, 60)
     .Variable(obj, "x", 100, 60)
     .SetLoops()
     .Execute();

// Loop 5 times
tween.SetLoops(5).Execute();

// Listen for loop completions
tween.OnLoopFinished(function() {
    show_debug_message("Loop finished!");
}).Execute();
```

### Custom Interpolation
Provide your own lerp function for a step:
```js
tween.Variable(obj, "x", 500, 60)
        .SetInterpolate(customLerp)
     .Execute();
```

### Global Control
Manage all tweens at once:
```js
TweenPauseAll();
TweenResumeAll();
TweenStopAll();
TweenClearAll();
TweenDestroyAll();

// Get all active tweens
var all = TweenGetAll();
```

### Deltatime
Override the deltatime for frame-independent animation:
```js
TweenSetDeltatime(1.0);
```

## Complete API Reference

### Tween Constructor - `new Tween([source])`
Creates a new tween chain. Optional `source` instance - the tween auto-destructs if the source is destroyed.

### Step Methods
- `Variable(instance, variable, target, duration)` - Animate any numeric variable
- `Color(instance, variable, target, duration)` - Animate a colour variable
- `Angle(instance, variable, target, duration)` - Animate an angle (shortest path)
- `String(instance, variable, target, duration)` - Animate a string variable
- `Method(func, from, to, duration)` - Animate via custom callback (receives interpolated value)
- `Interval(duration)` - Wait/pause for a duration
- `Callback(func, [args])` - Execute a function mid-sequence

### Step Methods (returned by step methods above)
- `SetEase(animCurve, [channel])` - Set per-step easing curve
- `SetDelay(value)` - Delay before the step executes (in frames)
- `SetInterpolate(func)` - Custom interpolation function (val1, val2, amount)
- `Relative()` - Make the target value relative to current
- `From(value)` - Override the starting value
- `FromCurrent()` - Explicitly snap the from value to the current value

### Parallel
- `ParallelBegin()` - Start parallel step group
- `ParallelEnd()` - End parallel step group

### Tween Control
- `SetSpeed(scale)` - Set playback speed multiplier
- `SetLoops([loops])` - Set loop count (-1 = infinite, 1 = default)
- `SetEase(animCurve, [channel])` - Set global easing for all steps
- `Skip()` - Jump to the end immediately
- `Pause()` - Pause the tween
- `Play()` - Resume the tween
- `Stop()` - Pause and reset to beginning
- `Destroy()` - Destroy the tween
- `Execute()` - Start the tween

### Tween Queries
- `IsRunning()` - Check if the tween is actively playing
- `IsPaused()` - Check if the tween is paused
- `GetLoops()` - Get total loop count
- `GetLoopsLeft()` - Get remaining loops
- `GetElapsedTime()` - Get elapsed time

### Callbacks
- `OnFinished(callback)` - Called when all steps and loops finish
- `OnLoopFinished(callback)` - Called at the end of each loop
- `OnStepFinished(callback)` - Called when an individual step completes

### Global Functions
- `TweenSetDeltatime(dt)` - Override the global deltatime
- `TweenPauseAll()` - Pause all active tweens
- `TweenResumeAll()` - Resume all paused tweens
- `TweenStopAll()` - Stop all tweens
- `TweenClearAll()` - Destroy all tweens
- `TweenDestroyAll()` - Destroy the tween system entirely
- `TweenGetAll()` - Get an array of all active tweens

### Easing Curve Macros
- `TWEEN_EASE_LINEAR`, `TWEEN_EASE_SINE`, `TWEEN_EASE_QUAD`, `TWEEN_EASE_CUBIC`, `TWEEN_EASE_QUART`, `TWEEN_EASE_QUINT`, `TWEEN_EASE_EXPO`, `TWEEN_EASE_CIRC`, `TWEEN_EASE_BACK`, `TWEEN_EASE_BOUNCE`, `TWEEN_EASE_ELASTIC`, `TWEEN_EASE_SPRING`

### Easing Channel Macros
- `TWEEN_CHANNEL_IN`, `TWEEN_CHANNEL_OUT`, `TWEEN_CHANNEL_IN_OUT`, `TWEEN_CHANNEL_OUT_IN`
