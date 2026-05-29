
//draw_sprite_ext(spr_arrow, 0, room_width/2, room_height/2, 1, 1, angle, color, 1);
//draw_self();

points.draw();

var _tweens = json_stringify(__TweenInit().tweens, true)
draw_text(32, 32, _tweens)