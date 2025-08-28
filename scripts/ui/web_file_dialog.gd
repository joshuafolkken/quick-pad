class_name WebFileDialog
extends RefCounted


static func open(callback: JavaScriptObject) -> void:
	if not JavaScriptBridge.eval("typeof window !== 'undefined'", true):
		return

	var window_obj: JavaScriptObject = JavaScriptBridge.get_interface("window")
	window_obj.set("webFileCallback", callback)

	var js_code := """
	var input = document.createElement('input');

	input.type = 'file';
	input.accept = '.wav,.mp3,.ogg';

	input.onchange = function(e) {
		var file = e.target.files[0];

		if (file && window.webFileCallback) {
			var reader = new FileReader();

			reader.onload = function(e) {
				var arrayBuffer = e.target.result;
				var uint8Array = new Uint8Array(arrayBuffer);
				var binaryString = '';

				for (var i = 0; i < uint8Array.length; i++) {
					binaryString += String.fromCharCode(uint8Array[i]);
				}

				var base64String = btoa(binaryString);
				window.webFileCallback(file.name, base64String);
			};

			reader.readAsArrayBuffer(file);
		}
	};

	input.click();
	"""
	JavaScriptBridge.eval(js_code, true)
