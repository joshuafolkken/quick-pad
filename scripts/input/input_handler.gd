class_name InputHandler
extends RefCounted

var _main_scene: Main


func _init(main_scene: Main) -> void:
	_main_scene = main_scene


func _handle_key_press(keycode: int) -> void:
	if not InputManager.is_valid_shortcut(keycode):
		return

	var coords: Array = InputManager.get_pad_coordinates(keycode)
	var row_index: int = coords[0]
	var column_index: int = coords[1]

	PadManager.play_pad_at_coordinates(_main_scene, row_index, column_index)


func handle_input_event(event: InputEvent) -> void:
	if event is not InputEventKey:
		return

	var event_key: InputEventKey = event

	if event_key.pressed and not event_key.echo:
		_handle_key_press(event_key.keycode)
