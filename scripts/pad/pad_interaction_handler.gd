class_name PadInteractionHandler
extends RefCounted

var _pad_controller: PadController


func _init(pad_controller: PadController) -> void:
	_pad_controller = pad_controller


func handle_button_down() -> void:
	if _is_setting_mode():
		return

	Log.d()
	_pad_controller.play_audio()


func handle_button_pressed(web_handler: PadWebHandler, file_dialog: FileDialog) -> void:
	if not _is_setting_mode():
		return

	if PlatformDetector.is_web_platform():
		web_handler.open_file_dialog()
	else:
		file_dialog.popup_centered()


func _is_setting_mode() -> bool:
	var scene_tree: SceneTree = Engine.get_main_loop()
	var main: Main = scene_tree.get_current_scene()
	return main and main.is_setting_mode()
