
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
    draw : function() {
        draw_set_valign(1);
        draw_set_halign(1);
        draw_set_font(fnt_test)
        gpu_set_texfilter(true)
        draw_text_transformed_colour(x, y, floor(value), xscl, yscl, ang, c, c, c, c, a);
        gpu_set_texfilter(false)
        draw_set_font(-1)
        draw_set_valign(0);
        draw_set_halign(0);
        if (t.Finished()) {
            show_debug_message("finished")
        }
    },
    func : function() {
        show_debug_message("Hello!")
    },
    test : function(v) {
        var _str1 = "Oh my God its Kotsume!"
        var _str2 = "The quick brown fox jumps over the lazy dog"
        show_debug_message(__TweenLerpString(_str1, _str2, v))
    },
    increase : function() {
        if (t) t.Destroy();
        t = new Tween(); 
        t.ParallelBegin();
            t.Variable(self, "value", 1000, 3).Relative().SetEase(TWEEN_EASE_EXPO, TWEEN_CHANNEL_IN_OUT);
            t.Variable(self, "xscl", 0.8, 2).SetEase(TWEEN_EASE_QUART, TWEEN_CHANNEL_OUT);
            t.Variable(self, "yscl", 0.8, 2).SetEase(TWEEN_EASE_QUART, TWEEN_CHANNEL_OUT);
        t.ParallelEnd();
        //t.ParallelBegin();
        //    t.Angle(self, "ang", 0, 2).From(10).SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT);
        //    t.Variable(self, "xscl", 1, 2).From(1.5).SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT);
        //    t.Variable(self, "yscl", 1, 2).From(1.5).SetEase(TWEEN_EASE_ELASTIC, TWEEN_CHANNEL_OUT);
        //    t.Color(self, "c", c_white, 2).From(c_yellow).SetEase(TWEEN_EASE_EXPO, TWEEN_CHANNEL_OUT);
        //t.ParallelEnd();
        t.Callback(func);
    }
}

var _t2 = new Tween().SetLoops().SetEase(TWEEN_EASE_SINE, TWEEN_CHANNEL_IN_OUT);
_t2.Variable(obj_test.points, "y", 5, 1).Relative();
_t2.Variable(obj_test.points, "y", -5, 1).Relative();




















