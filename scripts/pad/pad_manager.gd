class_name PadManager
extends RefCounted


static func setup(main_scene: Main, row_index: int, column_index: int) -> void:
	var pad := _get_pad(main_scene, row_index, column_index)
	pad.set_grid_position(row_index, column_index)
	_load_audio(pad, row_index, column_index)


static func play(main_scene: Main, row_index: int, column_index: int) -> void:
	var pad := _get_pad(main_scene, row_index, column_index)
	pad.play_audio()


static func initialize(main_scene: Main) -> void:
	for coords: Array[int] in GridManager.iterate_grid():
		setup(
			main_scene, coords[Constants.ARRAY_INDICES.ROW], coords[Constants.ARRAY_INDICES.COLUMN]
		)


static func _get_pad(main_scene: Main, row_index: int, column_index: int) -> Pad:
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
