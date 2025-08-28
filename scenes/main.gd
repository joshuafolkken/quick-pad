class_name Main
extends Node2D

const ROW_SIZE = 4
const COLUMN_SIZE = 3

const NODE_PATH_FORMAT = "CanvasLayer/VBoxContainer/Row%d/Pad%d"
const FILE_PATH_FORMAT = "res://assets/audio/%s"

const AUDIO_UID_MAPPING: Dictionary[String, String] = {
	"和太鼓でドン.mp3": "uid://ddd8foqjrnovn",
	"和太鼓でドドン.mp3": "uid://dg2q22benpd3",
	"チーン1.mp3": "uid://wbv01t4b6ymq",
	"歓声と拍手1.mp3": "uid://bx81nwfhegkd2",
	"ラッパのファンファーレ.mp3": "uid://can1jh5nm483x",
	"ドンドンパフパフ.mp3": "uid://bw52nji8ay54d",
	"ツッコミを入れる.mp3": "uid://c742twl6jo8l",
	"「わぁーーっ♪」.mp3": "uid://cbofi5pxhwb3e",
	"自主規制ピー音.mp3": "uid://tew6dwyl5fcn",
	"クイズ出題1.mp3": "uid://beelu7mlxxqdy",
	"クイズ正解1.mp3": "uid://di3uii830ctpo",
	"クイズ不正解1.mp3": "uid://daqt5a22itqmr",
}

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

@onready
var _setting_button: TextureButton = $CanvasLayer/VBoxContainer/Control/HBoxContainer/SettingButton
@onready
var _setting_button_color_rect: ColorRect = $CanvasLayer/VBoxContainer/Control/HBoxContainer/SettingButton/ColorRect


func _load_pad(row_index: int, column_index: int) -> void:
	var default: String = FILE_NAMES[row_index][column_index]
	var node_path := NODE_PATH_FORMAT % [row_index, column_index]
	var pad: Pad = get_node(node_path)
	pad.set_grid_position(row_index, column_index)
	var file_path := Settings.load_pad(row_index, column_index, default)

	if AUDIO_UID_MAPPING.has(file_path):
		var uid := AUDIO_UID_MAPPING[file_path]
		pad.load_audio_by_uid(uid, file_path)
	else:
		pad.load_audio_file(file_path)


func _ready() -> void:
	# Log.i(ProjectSettings.globalize_path("user://"))

	for row_index in ROW_SIZE:
		for column_index in COLUMN_SIZE:
			_load_pad(row_index, column_index)


func _input(event: InputEvent) -> void:
	if event is not InputEventKey:
		return

	var event_key: InputEventKey = event

	if event_key.pressed and not event_key.echo:
		if not SHORTCUT_MAPPING.has(event_key.keycode):
			return

		var coords: Array = SHORTCUT_MAPPING[event_key.keycode]
		var row_index: int = coords[0]
		var column_index: int = coords[1]

		var node_path := NODE_PATH_FORMAT % [row_index, column_index]
		var pad: Pad = get_node(node_path)
		pad.play_audio()


func _on_setting_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_setting_button_color_rect.color = Color8(0, 193, 167)
	else:
		_setting_button_color_rect.color = Color.BLACK


func is_setting_mode() -> bool:
	return _setting_button.button_pressed
