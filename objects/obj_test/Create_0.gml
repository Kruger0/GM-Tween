
tween = undefined;
angle = irandom(360);
color = c_white;

//t = new Tween(id);
//t.Variable(id, "image_xscale", 2, 1);
//t.Interval(1);
//t.Variable(id, "image_yscale", 2, 1);
//t.Callback(show_debug_message, "UEPA");
//t.Method(show_debug_message, 0, 100, 3);

points = {
    value: 0,
    x: 128,
    y: 64,
    xscl : 1,
    yscl : 1,
    c : c_white,
    a : 1,
    ang : 0,
    t : new Tween(),
    text : "Hello",
    draw : function() {
        draw_set_valign(1);
        draw_set_halign(1);
        draw_set_font(fnt_test)
        gpu_set_texfilter(true)
        draw_text_transformed_colour(x, y, floor(value), xscl, yscl, ang, c, c, c, c, a);
        draw_text_transformed_colour(x, y+32, text, 0.3, 0.3, 0, c, c, c, c, a);
        gpu_set_texfilter(false)
        draw_set_font(-1)
        draw_set_valign(0);
        draw_set_halign(0);
    },
    func : function() {
        show_debug_message("Hello!")
    },
    test : function(v) {
        show_debug_message(text)
    },
    increase : function() {
        if (t) t.Destroy();
        t = new Tween(); 
        t.OnFinished(function() {
            show_debug_message("TERMINOU")
        })
        t.ParallelBegin();
            t.Variable(self, "value", 1000, 3).Relative().SetEase(TWEEN_EASE_EXPO, TWEEN_CHANNEL_IN_OUT);
            t.Variable(self, "xscl", 0.8, 2).SetEase(TWEEN_EASE_QUART, TWEEN_CHANNEL_OUT);
            t.Variable(self, "yscl", 0.8, 2).SetEase(TWEEN_EASE_QUART, TWEEN_CHANNEL_OUT);
        t.ParallelEnd();
        t.ParallelBegin();
            t.Angle(self, "ang", 0, 2).From(10).SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT);
            t.Variable(self, "xscl", 1, 2).From(1.5).SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT);
            t.Variable(self, "yscl", 1, 2).From(1.5).SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT);
            t.Color(self, "c", c_white, 2).From(c_yellow).SetEase(TWEEN_EASE_EXPO, TWEEN_CHANNEL_OUT);
        t.ParallelEnd();
        t.String(self, "text", "The quick brown fox jumps over the lazy dog", 2).SetEase(TWEEN_EASE_EXPO, TWEEN_CHANNEL_OUT);
    }
}

var _t2 = new Tween().SetLoops().SetEase(TWEEN_EASE_SINE, TWEEN_CHANNEL_IN_OUT);
_t2.Variable(obj_test.points, "y", 5, 1).Relative();
_t2.Variable(obj_test.points, "y", -5, 1).Relative();




















