extends Node2D

const NODE_PATH_FORMAT = "CanvasLayer/VBoxContainer/Row%d/Pad%d"
const FILE_PATH_FORMAT = "res://assets/audio/%s"

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
