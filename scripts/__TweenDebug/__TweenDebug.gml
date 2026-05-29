// feather ignore all
/// @ignore
function __TweenDebug() {
    static __data = __TweenInit();
    if (os_browser != browser_not_a_browser) return 0;
    
    var _isDbgOpen  = is_debug_overlay_open();
    var _viewWidth  = 400;
    var _viewHeight = 300;
    var _btnWidth   = _viewWidth-24;
    
    if (!dbg_view_exists(__data.dbgView)) {
        __data.dbgView = dbg_view($"GM-Tween v{__TWEEN_VERSION}", false, 256, 32, _viewWidth, _viewHeight);
    }
    
    dbg_section_delete(__data.dbgSections[$ "general"]);
    __data.dbgSections[$ "general"] = dbg_section("General");
    
        dbg_slider(ref_create(__data, "dt"), 0, 5, "Delta Time");
}
