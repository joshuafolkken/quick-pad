class_name SettingModeManager
extends RefCounted

var _setting_button: TextureButton
var _setting_button_color_rect: ColorRect


func _init(setting_button: TextureButton, setting_button_color_rect: ColorRect) -> void:
	_setting_button = setting_button
	_setting_button_color_rect = setting_button_color_rect


func toggle_setting_mode(toggled_on: bool) -> void:
	if toggled_on:
		_setting_button_color_rect.color = Color8(0, 193, 167)
	else:
		_setting_button_color_rect.color = Color.BLACK


func is_setting_mode() -> bool:
	return _setting_button.button_pressed


func get_setting_button() -> TextureButton:
	return _setting_button
