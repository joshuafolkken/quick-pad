class_name InputHandler
extends RefCounted

var _main_scene: Main


func _init(main_scene: Main) -> void:
	_main_scene = main_scene


func _handle_key_press(keycode: int) -> void:
	if not InputManager.is_valid_shortcut(keycode):
		return

	var coordinates := InputManager.get_pad_coordinates(keycode)
	var row_index := coordinates[0]
	var column_index := coordinates[1]

	PadManager.play(_main_scene, row_index, column_index)


func handle_input_event(event: InputEvent) -> void:
	if not _is_valid_key_event(event):
		return

	var event_key: InputEventKey = event
	if event_key.pressed and not event_key.echo:
		_handle_key_press(event_key.keycode)


func _is_valid_key_event(event: InputEvent) -> bool:
	return event is InputEventKey
