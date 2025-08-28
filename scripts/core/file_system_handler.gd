class_name FileSystemHandler
extends RefCounted


static func setup_file_drop_support(window: Window, callback: Callable) -> void:
	window.files_dropped.connect(callback)


static func setup_file_dialog(dialog: FileDialog) -> void:
	dialog.use_native_dialog = true
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.filters = PackedStringArray(["*.wav", "*.mp3", "*.ogg"])
	dialog.title = "Open Audio File"


static func create_user_directory(path: String) -> bool:
	var dir := DirAccess.open("user://")
	if not dir:
		return false

	return dir.make_dir_recursive(path) == OK


static func copy_file(source_path: String, target_path: String) -> bool:
	var dir := DirAccess.open("user://")
	if not dir:
		return false

	return dir.copy(source_path, target_path) == OK
