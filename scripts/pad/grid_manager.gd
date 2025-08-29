class_name GridManager
extends RefCounted


static func get_node_path(row_index: int, column_index: int) -> String:
	return Constants.GRID.NODE_PATH_FORMAT % [row_index, column_index]


static func is_valid_position(row_index: int, column_index: int) -> bool:
	return (
		row_index >= 0
		and row_index < Constants.GRID.ROW_SIZE
		and column_index >= 0
		and column_index < Constants.GRID.COLUMN_SIZE
	)


static func iterate_grid() -> Array[Array]:
	var positions: Array[Array] = []
	for row_index in Constants.GRID.ROW_SIZE:
		for column_index in Constants.GRID.COLUMN_SIZE:
			positions.append([row_index, column_index])
	return positions
