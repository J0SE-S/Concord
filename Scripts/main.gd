extends Node2D

var is_server = true
var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@onready var cam = $Camera2D

func _on_play_button_button_up():
	if (is_server):
		peer.create_server(10273)
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(add_player)
		add_player()
		cam.enabled = false
	else:
		peer.create_client("127.0.0.1", 10273)
		multiplayer.multiplayer_peer = peer
		cam.enabled = false

func _on_settings_button_button_up():
	peer.create_client("127.0.0.1", 10273)
	multiplayer.multiplayer_peer = peer
	cam.enabled = false


func _on_quit_button_button_up():
	get_tree().quit()

func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)

func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)
	get_tree().quit()

func del_player(id):
	rpc("_del_player", id)
	
@rpc("any_peer", "call_local") func _del_player(id):
	get_node(str(id)).queue_free()
