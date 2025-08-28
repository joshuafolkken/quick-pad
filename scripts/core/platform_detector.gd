class_name PlatformDetector
extends RefCounted


static func is_web_platform() -> bool:
	return OS.get_name() == "Web"


static func is_desktop_platform() -> bool:
	return OS.get_name() in ["Windows", "macOS", "Linux"]


static func is_mobile_platform() -> bool:
	return OS.get_name() in ["Android", "iOS"]


static func get_platform_name() -> String:
	return OS.get_name()
