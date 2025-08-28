class_name Pad
extends Control

const SUPPORTED_AUDIO_FORMATS := ["wav", "mp3", "ogg"]
const DEFAULT_COLOR = Color.BLACK
const ACTION_COLOR = Color.WHITE
const ACTIVE_COLOR = Color.DARK_RED

var _is_audio_loaded: bool:
	get:
		return _player.stream != null

var _row_index := -1
var _column_index := -1

@onready var _label: Label = $MarginContainer/Label
@onready var _player: AudioStreamPlayer = $Player
@onready var _rect: ColorRect = $ColorRect
@onready var _file_dialog: FileDialog = $FileDialog


func _create_audio_stream(file_path: String) -> AudioStream:
	var extension := file_path.get_extension().to_lower()

	match extension:
		"wav":
			return AudioStreamWAV.load_from_file(file_path)
		"mp3":
			return AudioStreamMP3.load_from_file(file_path)
		"ogg":
			return AudioStreamOggVorbis.load_from_file(file_path)
		_:
			print("Unsupported audio format: ", extension)
			return null


func _is_mouse_in_pad_area() -> bool:
	return Rect2(global_position, size).has_point(get_global_mouse_position())


func _is_valid_audio_file(file_path: String) -> bool:
	var extension := file_path.get_extension().to_lower()
	return extension in SUPPORTED_AUDIO_FORMATS


func load_audio_file(file_path: String) -> void:
	var file_name := file_path.get_file()
	print("Loading audio file: ", file_name)

	var audio_stream := _create_audio_stream(file_path)
	if audio_stream == null:
		return

	_player.stream = audio_stream
	var file_name_no_ext := file_name.get_basename()
	set_label(file_name_no_ext)


func load_audio_by_uid(uid: String, file_name: String) -> void:
	var audio_stream := load(uid)

	if audio_stream == null:
		print("Failed to load audio with UID: ", uid)
		return

	_player.stream = audio_stream
	_label.text = file_name.get_basename()
	print("Successfully loaded audio with UID: ", uid)


func _copy_file_to_user_directory(source_path: String) -> String:
	var target_path := "user://audio/" + source_path.get_file()
	var dir := DirAccess.open("user://")

	dir.make_dir_recursive("audio")
	dir.copy(source_path, target_path)

	return target_path


func _save_audio(file_path: String) -> void:
	if not _is_valid_audio_file(file_path):
		print("Invalid audio file format: " + file_path)
		return

	var target_path := _copy_file_to_user_directory(file_path)
	Settings._save_pad(_row_index, _column_index, target_path)
	load_audio_file(target_path)


func _on_files_dropped(files: PackedStringArray) -> void:
	if not _is_mouse_in_pad_area():
		return

	if files.size() != 1:
		print("Please drop exactly one audio file")
		return

	var file_path := files[0]

	_save_audio(file_path)


func _setup_file_dialog() -> void:
	_file_dialog.use_native_dialog = true
	_file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	_file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	_file_dialog.filters = PackedStringArray(["*.wav", "*.mp3", "*.ogg"])
	_file_dialog.title = "Open Audio File"


func _ready() -> void:
	get_window().files_dropped.connect(_on_files_dropped)
	_label.text = "N/A"
	_setup_file_dialog()


func set_label(value: String) -> void:
	_label.text = value


func _add_glow_effect() -> void:
	var tween := create_tween()
	tween.set_parallel(true)

	tween.tween_property(_rect, "color", ACTION_COLOR, 0.04)
	tween.tween_property(_rect, "color", ACTIVE_COLOR, 0.04).set_delay(0.04)


func play_audio() -> void:
	_add_glow_effect()

	if not _is_audio_loaded:
		print("No audio file loaded")
		return

	_player.play()


func _on_button_down() -> void:
	var main: Main = get_tree().get_current_scene()
	if main and main.is_setting_mode():
		_file_dialog.popup_centered()
	else:
		play_audio()


func set_grid_position(row_index: int, column_index: int) -> void:
	_row_index = row_index
	_column_index = column_index


func _on_player_finished() -> void:
	_rect.color = DEFAULT_COLOR


func _on_file_dialog_file_selected(path: String) -> void:
	_save_audio(path)
