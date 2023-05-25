extends Node

var udp_ip = "127.0.0.1"
var udp = PacketPeerUDP.new()
var label : Label

func _ready():
	if not settings.mouse:
		mouse_visibility(Input.MOUSE_MODE_HIDDEN)
	label = $lbl_udp_status
	if (udp.bind(settings.udp_port) != OK):
		label.text = "Error accessing UDP port: " + str(settings.udp_port)
	else:
		label.text = "Listening on port: " + str(settings.udp_port)
	label.text += "\nMouse: " + str(settings.mouse) + "\nBackground: " + settings.background + "\nPassphrase: " + settings.passphrase
	label.text += "\nSettings: " + settings.settingsfile

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_M:
				mouse_visibility(int(not Input.mouse_mode) as Input.MouseMode)
			KEY_R:
				if event.shift_pressed:
					$".".position = Vector2(0,0)
					$".".rotation_degrees = 0
				else:
					$".".position = Vector2(0,ProjectSettings.get("display/window/size/viewport_width"))
					$".".rotation_degrees = 270
			KEY_F1:
				OS.alert("M = Mouse cursor toggle\nR = Rotate 90°\nSHIFT+R = Rotate 0°\nQ or ESCAPE = Quit with dialog\nSHIFT+Q or SHIFT+ESCAPE = Quit!","Keyboard help")
			KEY_Q, KEY_ESCAPE:
				if not event.shift_pressed:
					OS.alert("Bye...", "EXIT")
				get_tree().quit()

func mouse_visibility(state : Input.MouseMode):
	Input.mouse_mode = state
	label = $lbl_info
	label.text += "\nMouse: " + str(state)

func udp_send():
	udp.set_dest_address(udp_ip,settings.udp_port)
	udp.put_packet("HELLO".to_ascii_buffer())

func udp_receive():
	if udp.get_available_packet_count() > 0:
		var array_bytes = udp.get_packet()
		label.text = "[" + str(Time.get_ticks_usec()) + "] " + array_bytes.get_string_from_ascii()
		var udp_dict = JSON.parse_string(array_bytes.get_string_from_ascii())
		if udp_dict != null:
			if udp_dict["Passphrase"] == settings.passphrase:
				$script_db.db_insert(udp_dict)

func _process(_delta):
	udp_receive()

func _exit_tree():
	udp.close()	
