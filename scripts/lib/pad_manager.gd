class_name PadManager
extends RefCounted


static func load_pad(main_scene: Main, row_index: int, column_index: int) -> void:
	var default: String = AudioConfig.get_default_file_name(row_index, column_index)
	var node_path := GridManager.get_node_path(row_index, column_index)
	var pad: Pad = main_scene.get_node(node_path)

	pad.set_grid_position(row_index, column_index)
	var file_path := Settings.load_pad(row_index, column_index, default)

	if AudioConfig.has_uid_mapping(file_path):
		var uid := AudioConfig.get_audio_uid(file_path)
		pad.load_audio_by_uid(uid, file_path)
	else:
		pad.load_audio_file(file_path)


static func play_pad_at_coordinates(main_scene: Main, row_index: int, column_index: int) -> void:
	var node_path := GridManager.get_node_path(row_index, column_index)
	var pad: Pad = main_scene.get_node(node_path)
	pad.play_audio()


static func initialize_all_pads(main_scene: Main) -> void:
	for coords: Array[int] in GridManager.iterate_grid():
		load_pad(main_scene, coords[0], coords[1])
