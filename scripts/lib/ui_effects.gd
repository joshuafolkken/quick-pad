class_name UIEffects
extends RefCounted


static func create_glow_effect(target: ColorRect, action_color: Color, active_color: Color) -> void:
	var tween := target.create_tween()
	tween.set_parallel(true)

	tween.tween_property(target, "color", action_color, 0.04)
	tween.tween_property(target, "color", active_color, 0.04).set_delay(0.04)
