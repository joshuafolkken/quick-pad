class_name PadController
extends RefCounted

var _audio_player: AudioPlayer
var _ui_controller: PadUIController
var _row_index: int
var _column_index: int


func _init(
	audio_player: AudioPlayer, ui_controller: PadUIController, row_index: int, column_index: int
) -> void:
	_audio_player = audio_player
	_ui_controller = ui_controller
	_row_index = row_index
	_column_index = column_index


func load_audio_file(file_path: String) -> void:
	if _audio_player.load_audio_from_file(file_path):
		_ui_controller.update_label_from_file(file_path)


func load_audio_by_uid(uid: String, file_name: String) -> void:
	if _audio_player.load_audio_by_uid(uid):
		_ui_controller.set_label_text(file_name.get_basename())


func play_audio() -> void:
	_audio_player.play()


func handle_file_drop(file_path: String) -> void:
	var target_path := AudioFileHandler.validate_and_save_file(file_path, _row_index, _column_index)
	if target_path != "":
		load_audio_file(target_path)


func handle_web_file(file_name: String, file_data_base64: String) -> void:
	var target_path := AudioFileHandler.validate_and_save_web_file(
		file_name, file_data_base64, _row_index, _column_index
	)

	if target_path != "":
		load_audio_file(target_path)


func is_audio_loaded() -> bool:
	return _audio_player.is_audio_loaded()
