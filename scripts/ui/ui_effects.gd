class_name UIEffects
extends RefCounted

const GLOW_ANIMATION_DURATION = 0.04
const GLOW_DELAY = 0.04


static func create_glow_effect(target: ColorRect, action_color: Color, active_color: Color) -> void:
	var tween := target.create_tween()
	tween.set_parallel(true)

	tween.tween_property(target, "color", action_color, GLOW_ANIMATION_DURATION)
	tween.tween_property(target, "color", active_color, GLOW_ANIMATION_DURATION).set_delay(
		GLOW_DELAY
	)
