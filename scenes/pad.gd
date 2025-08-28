class_name Pad
extends Control

var _pad_controller: PadController
var _audio_player: AudioPlayer
var _ui_controller: PadUIController
var _web_handler: PadWebHandler
var _file_drop_handler: PadFileDropHandler
var _interaction_handler: PadInteractionHandler

@onready var _label: Label = $MarginContainer/Label
@onready var _player: AudioStreamPlayer = $Player
@onready var _rect: ColorRect = $ColorRect
@onready var _file_dialog: FileDialog = $FileDialog


func _ready() -> void:
	_initialize_components()
	_setup_platform_handlers()


func _initialize_components() -> void:
	_audio_player = AudioPlayer.new(_player, _rect)
	_ui_controller = PadUIController.new(_label, _rect)
	_ui_controller.set_default_label()

	_pad_controller = PadController.new(_audio_player, _ui_controller)
	_interaction_handler = PadInteractionHandler.new(_pad_controller)

	_audio_player.connect_finished_signal(_on_player_finished)


func _setup_platform_handlers() -> void:
	if PlatformDetector.is_web_platform():
		_setup_web_platform()
	else:
		_setup_desktop_platform()


func _setup_web_platform() -> void:
	_web_handler = PadWebHandler.new(_pad_controller)
	_web_handler.setup_web_file_callback()


func _setup_desktop_platform() -> void:
	_file_drop_handler = PadFileDropHandler.new(_pad_controller, self)
	_file_drop_handler.setup_file_drop_support(get_window())
	_file_drop_handler.setup_file_dialog(_file_dialog)


func load_audio_file(file_path: String) -> void:
	_pad_controller.load_audio_file(file_path)


func load_audio_by_uid(uid: String, file_name: String) -> void:
	_pad_controller.load_audio_by_uid(uid, file_name)


func play_audio() -> void:
	_pad_controller.play_audio()


func set_grid_position(row_index: int, column_index: int) -> void:
	_pad_controller.set_grid_position(row_index, column_index)


func _on_player_finished() -> void:
	_pad_controller.handle_audio_finished()


func _on_file_dialog_file_selected(path: String) -> void:
	_interaction_handler.handle_file_dialog_selection(path)


func _on_button_down() -> void:
	_interaction_handler.handle_button_down()


func _on_button_pressed() -> void:
	_interaction_handler.handle_button_pressed(_web_handler, _file_dialog)
