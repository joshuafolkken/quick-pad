class_name AudioFileHandler
extends RefCounted


static func copy_file_to_user_directory(source_path: String) -> String:
	var target_path := Constants.FileSystem.USER_AUDIO_DIR + source_path.get_file()
	var dir := FileSystemHandler.get_user_directory()

	if not dir:
		Log.e("Failed to open user directory")
		return ""

	if dir.make_dir_recursive("audio") != OK:
		Log.e("Failed to create audio directory")
		return ""

	if dir.copy(source_path, target_path) != OK:
		Log.e("Failed to copy file from %s to %s" % [source_path, target_path])
		return ""

	return target_path


static func save_web_file(file_name: String, file_data_base64: String) -> String:
	var buffer := Marshalls.base64_to_raw(file_data_base64)
	var target_path := Constants.FileSystem.USER_AUDIO_DIR + file_name

	var dir := FileSystemHandler.get_user_directory()
	dir.make_dir_recursive("audio")

	var file := FileAccess.open(target_path, FileAccess.WRITE)
	file.store_buffer(buffer)
	file.close()

	return target_path


static func validate_and_save_file(file_path: String, row_index: int, column_index: int) -> String:
	if not AudioManager.is_valid_file(file_path):
		Log.w("Invalid audio file format: " + file_path)
		return ""

	var target_path: String
	if PlatformDetector.is_web_platform():
		Log.w("Web platform handles file saving differently")
		target_path = file_path
	else:
		target_path = copy_file_to_user_directory(file_path)

	_save_pad_settings(target_path, row_index, column_index)
	return target_path


static func validate_and_save_web_file(
	file_name: String, file_data_base64: String, row_index: int, column_index: int
) -> String:
	if not AudioManager.is_valid_file(file_name):
		return ""

	var target_path := AudioFileHandler.save_web_file(file_name, file_data_base64)
	_save_pad_settings(target_path, row_index, column_index)
	return target_path


static func _save_pad_settings(file_path: String, row_index: int, column_index: int) -> void:
	Settings._save_pad(row_index, column_index, file_path)
