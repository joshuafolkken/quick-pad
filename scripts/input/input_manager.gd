class_name InputManager
extends RefCounted

const SHORTCUT_MAPPING: Dictionary[int, Array] = {
	KEY_2: [0, 0],
	KEY_3: [0, 1],
	KEY_4: [0, 2],
	KEY_Q: [1, 0],
	KEY_W: [1, 1],
	KEY_E: [1, 2],
	KEY_A: [2, 0],
	KEY_S: [2, 1],
	KEY_D: [2, 2],
	KEY_Z: [3, 0],
	KEY_X: [3, 1],
	KEY_C: [3, 2],
}


static func get_pad_coordinates(keycode: int) -> Array[int]:
	if SHORTCUT_MAPPING.has(keycode):
		var int_array: Array[int] = []
		for item: int in SHORTCUT_MAPPING[keycode]:
			int_array.append(item)

		return int_array

	Log.w("Invalid keycode: %d" % keycode)
	return [-1, -1]


static func is_valid_shortcut(keycode: int) -> bool:
	return SHORTCUT_MAPPING.has(keycode)


static func get_all_shortcuts() -> Dictionary[int, Array]:
	return SHORTCUT_MAPPING.duplicate()
