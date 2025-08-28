class_name GridManager
extends RefCounted

const ROW_SIZE = 4
const COLUMN_SIZE = 3
const NODE_PATH_FORMAT = "CanvasLayer/VBoxContainer/Row%d/Pad%d"


static func get_grid_size() -> Vector2i:
	return Vector2i(COLUMN_SIZE, ROW_SIZE)


static func get_node_path(row_index: int, column_index: int) -> String:
	return NODE_PATH_FORMAT % [row_index, column_index]


static func is_valid_position(row_index: int, column_index: int) -> bool:
	return (
		row_index >= 0 and row_index < ROW_SIZE and column_index >= 0 and column_index < COLUMN_SIZE
	)


static func iterate_grid() -> Array[Array]:
	var positions: Array[Array] = []
	for row_index in ROW_SIZE:
		for column_index in COLUMN_SIZE:
			positions.append([row_index, column_index])
	return positions
