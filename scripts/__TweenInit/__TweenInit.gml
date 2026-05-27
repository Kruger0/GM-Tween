
/// @ignore
function __TweenInit() {
    static data = {
        dt: 1,
        tweens: [],
        timeSource: undefined,
    }
    
    with (data) {
        if (time_source_exists(timeSource)) {
            time_source_destroy(timeSource, true);
        }
        timeSource = time_source_create(time_source_game, 1, time_source_units_frames, __TweenUpdate);
        time_source_start(timeSource);
    }
    
    return data;
}
