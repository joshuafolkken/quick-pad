extends Node2D

@onready var _button: TextureButton = $CanvasLayer/TextureButton


func _on_texture_button_pressed() -> void:
	_button.disabled = true
	get_tree().change_scene_to_file("res://scenes/main.tscn")
