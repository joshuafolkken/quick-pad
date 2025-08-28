class_name Pad
extends Control

var _pad_controller: PadController
var _audio_player: AudioPlayer
var _ui_controller: PadUIController
var _row_index := -1
var _column_index := -1
var _web_file_callback: JavaScriptObject

@onready var _label: Label = $MarginContainer/Label
@onready var _player: AudioStreamPlayer = $Player
@onready var _rect: ColorRect = $ColorRect
@onready var _file_dialog: FileDialog = $FileDialog


func _ready() -> void:
	_ui_controller = PadUIController.new(_label, _rect)
	_audio_player = AudioPlayer.new(_player, _rect)
	_ui_controller.set_default_label()

	_audio_player.connect_finished_signal(_on_player_finished)

	if PlatformDetector.is_web_platform():
		_setup_web_file_callback()
	else:
		FileSystemHandler.setup_file_drop_support(get_window(), _on_files_dropped)
		FileSystemHandler.setup_file_dialog(_file_dialog)


func _is_mouse_in_pad_area() -> bool:
	return Rect2(global_position, size).has_point(get_global_mouse_position())


func load_audio_file(file_path: String) -> void:
	_pad_controller.load_audio_file(file_path)


func load_audio_by_uid(uid: String, file_name: String) -> void:
	_pad_controller.load_audio_by_uid(uid, file_name)


func _on_files_dropped(files: PackedStringArray) -> void:
	if not _is_mouse_in_pad_area():
		return

	if files.size() != 1:
		Log.w("Please drop exactly one audio file")
		return

	_pad_controller.handle_file_drop(files[0])


func _setup_web_file_callback() -> void:
	_web_file_callback = JavaScriptBridge.create_callback(_on_web_file_selected_js)


func set_label(value: String) -> void:
	_ui_controller.set_label_text(value)


func play_audio() -> void:
	_pad_controller.play_audio()


func _on_web_file_selected_js(args: PackedStringArray) -> void:
	if args.size() < 2:
		return

	var file_name := args[0]
	var file_data_base64 := args[1]

	if not AudioManager.is_valid_file(file_name):
		return

	_pad_controller.handle_web_file(file_name, file_data_base64)


func _is_setting_mode() -> bool:
	var main: Main = get_tree().get_current_scene()
	return main and main.is_setting_mode()


func _on_button_down() -> void:
	if _is_setting_mode():
		return

	Log.d()
	play_audio()


func set_grid_position(row_index: int, column_index: int) -> void:
	_row_index = row_index
	_column_index = column_index

	_pad_controller = PadController.new(_audio_player, _ui_controller, row_index, column_index)


func _on_player_finished() -> void:
	_ui_controller.reset_color()


func _on_file_dialog_file_selected(path: String) -> void:
	_pad_controller.handle_file_drop(path)


func _on_button_pressed() -> void:
	if not _is_setting_mode():
		return

	if PlatformDetector.is_web_platform():
		WebFileDialog.open(_web_file_callback)
	else:
		_file_dialog.popup_centered()
