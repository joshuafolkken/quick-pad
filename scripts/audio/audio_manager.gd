class_name AudioManager
extends RefCounted

const SUPPORTED_AUDIO_FORMATS := ["wav", "mp3", "ogg"]


static func create_stream(file_path: String) -> AudioStream:
	var extension := file_path.get_extension().to_lower()

	match extension:
		"wav":
			return AudioStreamWAV.load_from_file(file_path)
		"mp3":
			return AudioStreamMP3.load_from_file(file_path)
		"ogg":
			return AudioStreamOggVorbis.load_from_file(file_path)
		_:
			Log.e("Unsupported audio format: " + extension)
			return null


static func is_valid_file(file_path: String) -> bool:
	var extension := file_path.get_extension().to_lower()
	return extension in SUPPORTED_AUDIO_FORMATS


static func copy_file_to_user_directory(source_path: String) -> String:
	var target_path := "user://audio/" + source_path.get_file()
	var dir := DirAccess.open("user://")

	dir.make_dir_recursive("audio")
	dir.copy(source_path, target_path)

	return target_path


static func save_web_file(file_name: String, file_data_base64: String) -> String:
	var buffer := Marshalls.base64_to_raw(file_data_base64)
	var target_path := "user://audio/" + file_name

	var dir := DirAccess.open("user://")
	dir.make_dir_recursive("audio")

	var file := FileAccess.open(target_path, FileAccess.WRITE)
	file.store_buffer(buffer)
	file.close()

	return target_path
