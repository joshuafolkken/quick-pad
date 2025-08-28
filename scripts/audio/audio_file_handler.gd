class_name AudioFileHandler
extends RefCounted


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

	Settings._save_pad(row_index, column_index, target_path)
	return target_path


static func validate_and_save_web_file(
	file_name: String, file_data_base64: String, row_index: int, column_index: int
) -> String:
	if not AudioManager.is_valid_file(file_name):
		return ""

	var target_path := AudioFileHandler.save_web_file(file_name, file_data_base64)
	Settings._save_pad(row_index, column_index, target_path)
	return target_path
