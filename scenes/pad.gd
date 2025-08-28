class_name Pad
extends Control

const DEFAULT_COLOR = Color.BLACK
const ACTION_COLOR = Color.WHITE
const ACTIVE_COLOR = Color.DARK_RED

var _is_audio_loaded: bool:
	get:
		return _player.stream != null

var _row_index := -1
var _column_index := -1
var _web_file_callback: JavaScriptObject

@onready var _label: Label = $MarginContainer/Label
@onready var _player: AudioStreamPlayer = $Player
@onready var _rect: ColorRect = $ColorRect
@onready var _file_dialog: FileDialog = $FileDialog


func _is_mouse_in_pad_area() -> bool:
	return Rect2(global_position, size).has_point(get_global_mouse_position())


func load_audio_file(file_path: String) -> void:
	var file_name := file_path.get_file()

	var audio_stream := AudioManager.create_stream(file_path)
	if audio_stream == null:
		return

	_player.stream = audio_stream
	var file_name_no_ext := file_name.get_basename()
	set_label(file_name_no_ext)


func load_audio_by_uid(uid: String, file_name: String) -> void:
	var audio_stream := load(uid)

	if audio_stream == null:
		Log.e("Failed to load audio with UID: " + uid)
		return

	_player.stream = audio_stream
	_label.text = file_name.get_basename()


func _save_audio(file_path: String) -> void:
	if not AudioManager.is_valid_file(file_path):
		Log.w("Invalid audio file format: " + file_path)
		return

	var target_path := AudioManager.copy_file_to_user_directory(file_path)
	Settings._save_pad(_row_index, _column_index, target_path)
	load_audio_file(target_path)


func _on_files_dropped(files: PackedStringArray) -> void:
	if not _is_mouse_in_pad_area():
		return

	if files.size() != 1:
		Log.w("Please drop exactly one audio file")
		return

	_save_audio(files[0])


func _setup_web_file_callback() -> void:
	_web_file_callback = JavaScriptBridge.create_callback(_on_web_file_selected_js)


func _setup_file_dialog() -> void:
	_file_dialog.use_native_dialog = true
	_file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	_file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	_file_dialog.filters = PackedStringArray(["*.wav", "*.mp3", "*.ogg"])
	_file_dialog.title = "Open Audio File"


func _ready() -> void:
	_label.text = "N/A"

	if App.is_web_platform():
		_setup_web_file_callback()
	else:
		get_window().files_dropped.connect(_on_files_dropped)
		_setup_file_dialog()


func set_label(value: String) -> void:
	_label.text = value


func play_audio() -> void:
	UIEffects.create_glow_effect(_rect, ACTION_COLOR, ACTIVE_COLOR)

	if not _is_audio_loaded:
		Log.w("No audio file loaded")
		return

	_player.play()


func _on_web_file_selected_js(args: PackedStringArray) -> void:
	if args.size() < 2:
		return

	var file_name := args[0]
	var file_data_base64 := args[1]

	if not AudioManager.is_valid_file(file_name):
		return

	var target_path := AudioManager.save_web_file(file_name, file_data_base64)
	Settings._save_pad(_row_index, _column_index, target_path)
	load_audio_file(target_path)


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


func _on_player_finished() -> void:
	_rect.color = DEFAULT_COLOR


func _on_file_dialog_file_selected(path: String) -> void:
	_save_audio(path)


func _on_button_pressed() -> void:
	if not _is_setting_mode():
		return

	if App.is_web_platform():
		WebFileDialog.open(_web_file_callback)
	else:
		_file_dialog.popup_centered()
