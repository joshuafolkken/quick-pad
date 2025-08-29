class_name PadWebHandler
extends RefCounted

var _web_file_callback: JavaScriptObject
var _pad_controller: PadController


func _init(pad_controller: PadController) -> void:
	_pad_controller = pad_controller


func setup_callback() -> void:
	_web_file_callback = JavaScriptBridge.create_callback(_handle_file_selection)


func open_file_dialog() -> void:
	WebFileDialog.open(_web_file_callback)


func _handle_file_selection(args: PackedStringArray) -> void:
	if args.size() < 2:
		Log.w("Invalid web file selection args: expected 2, got %d" % args.size())
		return

	var file_name := args[0]
	var file_data_base64 := args[1]

	if not AudioManager.is_valid_file(file_name):
		Log.w("Invalid audio file format: %s" % file_name)
		return

	_pad_controller.handle_web_file(file_name, file_data_base64)
