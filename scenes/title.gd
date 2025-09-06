extends Node2D

@onready var _button: TextureButton = $CanvasLayer/TextureButton
@onready var _version_label: Label = $CanvasLayer/VBoxContainer/VersionLabel


func _ready() -> void:
	_version_label.text = "v%s" % ProjectSettings.get_setting("application/config/version")


func _on_texture_button_pressed() -> void:
	_button.disabled = true
	get_tree().change_scene_to_file("res://scenes/main.tscn")
