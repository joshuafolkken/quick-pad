class_name PadInteractionHandler
extends RefCounted

var _pad_controller: PadController


func _init(pad_controller: PadController) -> void:
	_pad_controller = pad_controller


func _should_handle_play_action() -> bool:
	return not _is_setting_mode()


func _should_handle_setting_action() -> bool:
	return _is_setting_mode()


func handle_button_down() -> void:
	if not _should_handle_play_action():
		return

	Log.d()
	_pad_controller.play_audio()


func handle_button_pressed(web_handler: PadWebHandler, file_dialog: FileDialog) -> void:
	if not _should_handle_setting_action():
		return

	if PlatformDetector.is_web_platform():
		web_handler.open_file_dialog()
	else:
		file_dialog.popup_centered()


func handle_file_dialog_selection(path: String) -> void:
	_pad_controller.handle_file_drop(path)


func _is_setting_mode() -> bool:
	var main: Main = _get_main_scene()
	return main and main.is_setting_mode()


func _get_main_scene() -> Main:
	var scene_tree: SceneTree = Engine.get_main_loop()
	return scene_tree.get_current_scene()
