class_name PadUIController
extends RefCounted

const DEFAULT_LABEL_TEXT = "N/A"

var _label: Label
var _rect: ColorRect


func _init(label: Label, rect: ColorRect) -> void:
	_label = label
	_rect = rect


func set_label_text(text: String) -> void:
	_label.text = text


func get_label_text() -> String:
	return _label.text


func reset_color() -> void:
	_rect.color = AudioPlayer.DEFAULT_COLOR


func set_default_label() -> void:
	_label.text = DEFAULT_LABEL_TEXT
