class_name FileSystemHandler
extends RefCounted

static var _user_dir_access: DirAccess


static func get_user_directory() -> DirAccess:
	if not _user_dir_access:
		_user_dir_access = DirAccess.open(Constants.FileSystem.USER_DIR)
		if not _user_dir_access:
			push_error("Failed to access user directory: " + Constants.FileSystem.USER_DIR)

	return _user_dir_access


static func setup_file_drop_support(window: Window, callback: Callable) -> void:
	window.files_dropped.connect(callback)


static func setup_file_dialog(dialog: FileDialog) -> void:
	dialog.use_native_dialog = true
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.filters = Constants.FileSystem.AUDIO_FILE_FILTERS
	dialog.title = Constants.FileSystem.FILE_DIALOG_TITLE


static func create_user_directory(path: String) -> bool:
	var dir := get_user_directory()
	if not dir:
		return false

	return dir.make_dir_recursive(path) == OK


static func copy_file(source_path: String, target_path: String) -> bool:
	var dir := get_user_directory()
	if not dir:
		return false

	return dir.copy(source_path, target_path) == OK
