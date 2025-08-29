class_name PadManager
extends RefCounted


static func setup(main_scene: Main, row_index: int, column_index: int) -> bool:
	var pad := _get_pad(main_scene, row_index, column_index)
	if not pad:
		Log.e(Constants.ErrorMessages.PAD_NOT_FOUND % [row_index, column_index])
		return false

	pad.set_grid_position(row_index, column_index)
	_load_audio(pad, row_index, column_index)
	return true


static func play(main_scene: Main, row_index: int, column_index: int) -> void:
	var pad := _get_pad(main_scene, row_index, column_index)
	pad.play_audio()


static func initialize_all(main_scene: Main) -> void:
	for coords in GridManager.iterate_grid():
		var row_index: int = coords[Constants.ArrayIndices.ROW]
		var column_index: int = coords[Constants.ArrayIndices.COLUMN]
		setup(main_scene, row_index, column_index)


static func _get_pad(main_scene: Main, row_index: int, column_index: int) -> Pad:
	if not GridManager.is_valid_position(row_index, column_index):
		Log.e(Constants.ErrorMessages.INVALID_POSITION % [row_index, column_index])
		return null

	var pad_path := GridManager.get_node_path(row_index, column_index)
	return main_scene.get_node(pad_path)


static func _load_audio(pad: Pad, row_index: int, column_index: int) -> void:
	var default: String = AudioConfig.get_default_file_name(row_index, column_index)
	var file_path := Settings.load_pad(row_index, column_index, default)

	if AudioConfig.has_uid_mapping(file_path):
		var uid := AudioConfig.get_uid(file_path)
		pad.load_audio_by_uid(uid, file_path)
	else:
		pad.load_audio_file(file_path)
