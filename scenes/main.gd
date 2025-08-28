class_name Main
extends Node2D

var _setting_mode_manager: SettingModeManager

@onready
var _setting_button: TextureButton = $CanvasLayer/VBoxContainer/Control/HBoxContainer/SettingButton
@onready
# gdlint:ignore = max-line-length
var _setting_button_color_rect: ColorRect = $CanvasLayer/VBoxContainer/Control/HBoxContainer/SettingButton/ColorRect


func _ready() -> void:
	# Log.i(ProjectSettings.globalize_path("user://"))

	_setting_mode_manager = SettingModeManager.new(_setting_button, _setting_button_color_rect)
	PadManager.initialize_all_pads(self)


func _input(event: InputEvent) -> void:
	if event is not InputEventKey:
		return

	var event_key: InputEventKey = event

	if event_key.pressed and not event_key.echo:
		if not InputManager.is_valid_shortcut(event_key.keycode):
			return

		var coords: Array = InputManager.get_pad_coordinates(event_key.keycode)
		var row_index: int = coords[0]
		var column_index: int = coords[1]

		PadManager.play_pad_at_coordinates(self, row_index, column_index)


func _on_setting_button_toggled(toggled_on: bool) -> void:
	_setting_mode_manager.toggle_setting_mode(toggled_on)


func is_setting_mode() -> bool:
	return _setting_mode_manager.is_setting_mode()
