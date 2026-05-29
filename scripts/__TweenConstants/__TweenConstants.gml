
enum __TWEEN_TYPE {
    VALUE,
    VARIABLE,
    COLOR,
    ANGLE,
    STRING,
    METHOD,
    INTERVAL,
    CALLBACK,
}

#macro TWEEN_CHANNEL_IN     "In"
#macro TWEEN_CHANNEL_OUT    "Out"
#macro TWEEN_CHANNEL_IN_OUT "InOut"
#macro TWEEN_CHANNEL_OUT_IN "OutIn"

#macro TWEEN_EASE_LINEAR    __TweenEaseLinear
#macro TWEEN_EASE_SINE      __TweenEaseSine
#macro TWEEN_EASE_QUAD      __TweenEaseQuad
#macro TWEEN_EASE_CUBIC     __TweenEaseCubic
#macro TWEEN_EASE_QUART     __TweenEaseQuart
#macro TWEEN_EASE_QUINT     __TweenEaseQuint
#macro TWEEN_EASE_EXPO      __TweenEaseExpo
#macro TWEEN_EASE_CIRC      __TweenEaseCirc
#macro TWEEN_EASE_BACK      __TweenEaseBack
#macro TWEEN_EASE_BOUNCE    __TweenEaseBounce
#macro TWEEN_EASE_ELASTIC   __TweenEaseElastic
#macro TWEEN_EASE_SPRING    __TweenEaseSpring
