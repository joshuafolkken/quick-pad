class_name Main
extends Node2D

var _setting_mode_manager: SettingModeManager
var _input_handler: InputHandler

@onready
var _setting_button: TextureButton = $CanvasLayer/VBoxContainer/Control/HBoxContainer/SettingButton
@onready
# gdlint:ignore = max-line-length
var _setting_button_color_rect: ColorRect = $CanvasLayer/VBoxContainer/Control/HBoxContainer/SettingButton/ColorRect


func _ready() -> void:
	# Log.i(ProjectSettings.globalize_path("user://"))

	_setting_mode_manager = SettingModeManager.new(_setting_button, _setting_button_color_rect)
	_input_handler = InputHandler.new(self)
	PadManager.initialize_all(self)


func _input(event: InputEvent) -> void:
	_input_handler.handle_input_event(event)


func _on_setting_button_toggled(toggled_on: bool) -> void:
	_setting_mode_manager.toggle_setting_mode(toggled_on)


func is_setting_mode() -> bool:
	return _setting_mode_manager.is_setting_mode()
