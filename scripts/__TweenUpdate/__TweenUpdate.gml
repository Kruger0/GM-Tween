
/// @ignore
function __TweenUpdate() {
    var _data = __TweenInit();
    var _tweens = _data.tweens;
    var _i = array_length(_tweens) - 1;
    
    for (var i = array_length(_tweens)-1; i >= 0; i--) {
        var _tween = _tweens[_i];
        //if (_tween.__destroyed) {
        //    array_delete(_tweens, _i, 1);
        //    continue;
        //}
        //if (!_tween.__paused) {
        //    __TweenAdvance(_tween);
        //}
    }
}
