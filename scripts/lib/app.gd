class_name App
extends RefCounted


static func is_web_platform() -> bool:
	return OS.get_name() == "Web"
