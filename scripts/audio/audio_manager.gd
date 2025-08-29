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
			Log.e(
				(
					"Unsupported audio format: '%s'. Supported formats: %s"
					% [extension, ", ".join(SUPPORTED_AUDIO_FORMATS)]
				)
			)
			return null


static func is_valid_file(file_path: String) -> bool:
	var extension := file_path.get_extension().to_lower()
	return extension in SUPPORTED_AUDIO_FORMATS
