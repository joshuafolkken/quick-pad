class_name PadFileDropHandler
extends RefCounted

var _pad_controller: PadController
var _pad_node: Control


func _init(pad_controller: PadController, pad_node: Control) -> void:
	_pad_controller = pad_controller
	_pad_node = pad_node


func setup_file_drop_support(window: Window) -> void:
	FileSystemHandler.setup_file_drop_support(window, _on_files_dropped)


func setup_file_dialog(file_dialog: FileDialog) -> void:
	FileSystemHandler.setup_file_dialog(file_dialog)


func _is_mouse_in_pad_area() -> bool:
	return Rect2(_pad_node.global_position, _pad_node.size).has_point(
		_pad_node.get_global_mouse_position()
	)


func _on_files_dropped(files: PackedStringArray) -> void:
	if not _is_mouse_in_pad_area():
		return

	if files.size() != 1:
		Log.w("Please drop exactly one audio file")
		return

	_pad_controller.handle_file_drop(files[0])


func handle_file_dialog_selection(file_path: String) -> void:
	_pad_controller.handle_file_drop(file_path)
