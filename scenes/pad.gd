class_name Pad
extends Control

@onready var _label: Label = $Label
@onready var _player: AudioStreamPlayer = $Player


func set_label(value: String) -> void:
	_label.text = value


func _on_button_down() -> void:
	_player.play()
