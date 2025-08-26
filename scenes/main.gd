extends Node2D

const NODE_PATH_FORMAT = "CanvasLayer/VBoxContainer/Row%d/Pad%d"
const FILE_PATH_FORMAT = "res://assets/audio/%s"

const SHORTCUT_MAPPING: Dictionary = {
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

const FILE_NAMES: Array = [
	["和太鼓でドン.mp3", "和太鼓でドドン.mp3", "チーン1.mp3"],
	["歓声と拍手1.mp3", "ラッパのファンファーレ.mp3", "ドンドンパフパフ.mp3"],
	["ツッコミを入れる.mp3", "「わぁーーっ♪」.mp3", "自主規制ピー音.mp3"],
	["クイズ出題1.mp3", "クイズ正解1.mp3", "クイズ不正解1.mp3"],
]

@onready var pad0: Pad = $CanvasLayer/VBoxContainer/Row0/Pad0
@onready var pad1: Pad = $CanvasLayer/VBoxContainer/Row0/Pad1
@onready var pad2: Pad = $CanvasLayer/VBoxContainer/Row0/Pad2


func _ready() -> void:
	for row in FILE_NAMES.size():
		print(row)
		var row_names: Array = FILE_NAMES[row]

		for column in row_names.size():
			var file_name: String = row_names[column]

			var node_path := NODE_PATH_FORMAT % [row, column]
			var pad: Pad = get_node(node_path)
			var file_path := FILE_PATH_FORMAT % file_name
			pad._load_audio_file(file_path)


func _input(event: InputEvent) -> void:
	if event is not InputEventKey:
		return

	var event_key: InputEventKey = event

	if event_key.pressed and not event_key.echo:
		if not SHORTCUT_MAPPING.has(event_key.keycode):
			return

		var coords: Array = SHORTCUT_MAPPING[event_key.keycode]
		var row: int = coords[0]
		var column: int = coords[1]

		var node_path := NODE_PATH_FORMAT % [row, column]
		var pad: Pad = get_node(node_path)
		pad.play_audio()
