extends Node2D

@onready var pad0: Pad = $CanvasLayer/VBoxContainer/Row/Pad0
@onready var pad1: Pad = $CanvasLayer/VBoxContainer/Row/Pad1
@onready var pad2: Pad = $CanvasLayer/VBoxContainer/Row/Pad2


func _ready() -> void:
	pad0.set_label("0")
	pad1.set_label("1")
	pad2.set_label("2")
