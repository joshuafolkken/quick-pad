class_name AudioConfig
extends RefCounted

const UID_MAPPING: Dictionary[String, String] = {
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

const DEFAULT_FILE_NAMES: Array[Array] = [
	["和太鼓でドン.mp3", "和太鼓でドドン.mp3", "チーン1.mp3"],
	["歓声と拍手1.mp3", "ラッパのファンファーレ.mp3", "ドンドンパフパフ.mp3"],
	["ツッコミを入れる.mp3", "「わぁーーっ♪」.mp3", "自主規制ピー音.mp3"],
	["クイズ出題1.mp3", "クイズ正解1.mp3", "クイズ不正解1.mp3"],
]

const FILE_PATH_FORMAT = "res://assets/audio/%s"


static func get_default_file_name(row_index: int, column_index: int) -> String:
	if (
		row_index < DEFAULT_FILE_NAMES.size()
		and column_index < DEFAULT_FILE_NAMES[row_index].size()
	):
		return DEFAULT_FILE_NAMES[row_index][column_index]
	return ""


static func get_uid(file_path: String) -> String:
	if UID_MAPPING.has(file_path):
		return UID_MAPPING[file_path]
	return ""


static func get_file_path(file_name: String) -> String:
	return FILE_PATH_FORMAT % file_name


static func has_uid_mapping(file_path: String) -> bool:
	return UID_MAPPING.has(file_path)
