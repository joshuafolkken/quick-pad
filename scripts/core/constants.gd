class_name Constants
extends RefCounted


class FileSystem:
	const USER_DIR = "user://"
	const USER_AUDIO_DIR = USER_DIR + "audio/"
	const AUDIO_FILE_FILTERS = ["*.wav", "*.mp3", "*.ogg"]
	const AUDIO_FILE_EXTENSIONS = ["wav", "mp3", "ogg"]
	const FILE_DIALOG_TITLE = "Open Audio File"


class Grid:
	const ROW_SIZE = 4
	const COLUMN_SIZE = 3
	const NODE_PATH_FORMAT = "CanvasLayer/VBoxContainer/Row%d/Pad%d"


class ArrayIndices:
	const ROW = 0
	const COLUMN = 1


class ErrorMessages:
	const INVALID_POSITION = "Invalid grid position: (%d, %d)"
	const PAD_NOT_FOUND = "Failed to get pad at position (%d, %d)"


class PadColors:
	const DEFAULT = Color.BLACK
	const PRESSED = Color.WHITE
	const PLAYING = Color.DARK_RED
