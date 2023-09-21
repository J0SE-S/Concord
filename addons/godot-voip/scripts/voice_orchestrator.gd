@tool
extends Node
class_name VoiceOrchestrator

signal received_voice_data
signal sent_voice_data
signal created_instance
signal removed_instance

@export var recording: bool = false: set = _set_recording
@export var listen: bool = false: set = _set_listen
@export var input_threshold: = 0.005: set = _set_input_threshold

var instances := {}
var _id = null

func _ready() -> void:
	multiplayer.connected_to_server.connect(_connected_ok)
	multiplayer.server_disconnected.connect(_server_disconnected)
	multiplayer.connection_failed.connect(_server_disconnected)

	multiplayer.peer_connected.connect(_player_connected)
	multiplayer.peer_disconnected.connect(_player_disconnected)

func _physics_process(delta: float) -> void:
	if multiplayer.has_multiplayer_peer() && multiplayer.is_server() && _id == null:
		_create_instance(multiplayer.get_unique_id())

	if (!multiplayer.has_multiplayer_peer() || !multiplayer.is_server()) && _id == 1:
		_reset()

func _create_instance(id: int) -> void:
	var instance := VoiceInstance.new()

	if id == multiplayer.get_unique_id():
		instance.recording = recording
		instance.listen = listen
		instance.input_threshold = input_threshold

		instance.connect("sent_voice_data", Callable(self, "_sent_voice_data"))

		_id = id

	instance.connect("received_voice_data", Callable(self, "_received_voice_data"))

	instance.name = str(id)

	instances[id] = instance

	add_child(instance)

	emit_signal("created_instance", id)

func _remove_instance(id: int) -> void:
	var instance: VoiceInstance = instances[id]

	if id == _id:
		_id = null

	instance.queue_free()

	instances.erase(id)

	emit_signal("removed_instance", id)

func _reset() -> void:
	for id in instances.keys():
		_remove_instance(id)

func _set_recording(value: bool) -> void:
	if _id != null:
		instances[_id].recording = value

	recording = value

func _set_listen(value: bool) -> void:
	if _id != null:
		instances[_id].listen = value

	listen = value

func _set_input_threshold(value: float) -> void:
	if _id != null:
		instances[_id].input_threshold = value

	input_threshold = value

func _connected_ok() -> void:
	if (!multiplayer.has_multiplayer_peer() || !multiplayer.is_server()) && _id == 1:
		_reset()

	_create_instance(multiplayer.get_unique_id())

func _server_disconnected() -> void:
	_reset()

func _player_connected(id) -> void:
	_create_instance(id)

func _player_disconnected(id) -> void:
	_remove_instance(id)

func _received_voice_data(data: PackedFloat32Array, id: int) -> void:
	emit_signal("received_voice_data", data, id)

func _sent_voice_data(data: PackedFloat32Array) -> void:
	emit_signal("sent_voice_data", data)
