class_name Pad
extends Control

const SUPPORTED_AUDIO_FORMATS := ["wav", "mp3", "ogg"]

var _is_audio_loaded: bool:
	get:
		return _player.stream != null

@onready var _label: Label = $MarginContainer/Label
@onready var _player: AudioStreamPlayer = $Player
@onready var _rect: ColorRect = $ColorRect


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


func _load_audio_file(file_path: String) -> void:
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


func _on_files_dropped(files: PackedStringArray) -> void:
	if not _is_mouse_in_pad_area():
		return

	if files.size() != 1:
		print("Please drop exactly one audio file")
		return

	var file_path := files[0]
	if not _is_valid_audio_file(file_path):
		print("Invalid audio file format")
		return

	_load_audio_file(file_path)


func _ready() -> void:
	get_window().files_dropped.connect(_on_files_dropped)
	_label.text = "N/A"


func set_label(value: String) -> void:
	_label.text = value


func _add_glow_effect() -> void:
	var initial_color := _rect.color
	var glow_color := Color(1.0, 1.0, 1.0, 1.0)

	var tween := create_tween()
	tween.set_parallel(true)

	tween.tween_property(_rect, "color", glow_color, 0.04)
	tween.tween_property(_rect, "color", initial_color, 0.04).set_delay(0.04)


func play_audio() -> void:
	_add_glow_effect()

	if not _is_audio_loaded:
		print("No audio file loaded")
		return

	_player.play()


func _on_button_down() -> void:
	play_audio()
