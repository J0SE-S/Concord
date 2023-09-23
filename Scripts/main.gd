extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene : PackedScene
@export var network_objects_node : Node2D
@export var cam : Camera2D
@export var spawn_positions : PackedVector2Array
var user_key : String
var server_key : String
var port = 10273

func _ready():
	if (!FileAccess.file_exists("user://auth.dat")):
		close_game(1)
	var auth = FileAccess.open("user://auth.dat", FileAccess.READ)
	user_key = auth.get_line()
	server_key = auth.get_line()
	auth.close()

func _on_play_button_button_up():
	if (server_key.hex_decode().get_string_from_utf8() == "127.0.0.1"):
		peer.create_server(port)
		multiplayer.peer_connected.connect(add_player)
		add_player()
		multiplayer.multiplayer_peer = peer
	else:
		peer.create_client(server_key.hex_decode().get_string_from_utf8(), port)
		multiplayer.multiplayer_peer = peer

func _on_settings_button_button_up():
	peer.create_client(server_key.hex_decode().get_string_from_utf8(), port)
	multiplayer.multiplayer_peer = peer

func close_game(code = 0):
	get_tree().quit(code)

func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	player.set_name_tag(user_key.hex_decode().get_string_from_utf8())
	network_objects_node.add_child(player)

@rpc("any_peer", "call_local", "reliable")
func del_player(id):
	network_objects_node.get_node(str(id)).queue_free()
