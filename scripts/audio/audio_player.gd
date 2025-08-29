class_name AudioPlayer
extends RefCounted

var _player: AudioStreamPlayer
var _rect: ColorRect


func _init(player: AudioStreamPlayer, rect: ColorRect) -> void:
	_player = player
	_rect = rect


func load_audio_stream(stream: AudioStream) -> void:
	_player.stream = stream


func load_audio_by_uid(uid: String) -> bool:
	var audio_stream := load(uid)

	if audio_stream == null:
		Log.w("Failed to load audio by UID: " + uid)
		return false

	_player.stream = audio_stream
	return true


func load_audio_file(file_path: String) -> bool:
	var audio_stream := AudioManager.create_stream(file_path)
	if audio_stream == null:
		Log.w("Failed to load audio file: " + file_path)
		return false

	_player.stream = audio_stream
	return true


func play() -> void:
	if not is_audio_loaded():
		Log.w("No audio file loaded")
		return

	UIEffects.create_glow_effect(_rect, Constants.PadColors.PRESSED, Constants.PadColors.PLAYING)
	_player.play()


func is_audio_loaded() -> bool:
	return _player.stream != null


func connect_finished_signal(callable: Callable) -> void:
	if not _player.finished.is_connected(callable):
		_player.finished.connect(callable)
