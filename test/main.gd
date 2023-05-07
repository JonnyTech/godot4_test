extends Node

# echo -n "hello" >/dev/udp/localhost/54321

var udp_ip = "127.0.0.1"
var udp = PacketPeerUDP.new()
var label : Label

func _ready():
	if not settings.mouse:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	label = $lbl_udp_status
	if (udp.bind(settings.udp_port) != OK):
		label.text = "Error accessing UDP port: " + str(settings.udp_port)
	else:
		label.text = "Listening on port: " + str(settings.udp_port)
	label.text += "\nMouse: " + str(settings.mouse) + "\nBackground: " + settings.background + "\nPassphrase: " + settings.passphrase

func udp_send():
	udp.set_dest_address(udp_ip,settings.udp_port)
	udp.put_packet("HELLO".to_ascii_buffer())

func udp_receive():
	if udp.is_bound():
		if udp.get_available_packet_count() > 0:
			var array_bytes = udp.get_packet()
			label.text = "[" + str(Time.get_ticks_usec()) + "] " + array_bytes.get_string_from_ascii()
			var udp_dict = JSON.parse_string(array_bytes.get_string_from_ascii())
			if udp_dict["Passphrase"] == settings.passphrase:
				$script_db.db_insert(udp_dict)

func _process(_delta):
	udp_receive()

func _exit_tree():
	udp.close()	
