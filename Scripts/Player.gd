extends CharacterBody2D

@export var cam : Camera2D
@export var name_tag : Label

const SPEED = 100.0
const RUN_SPEED = 300.0

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if (is_multiplayer_authority()):
		cam.make_current()
		
func set_name_tag(new_name):
	name_tag.text = str(new_name)

func _process(_delta):
	if is_multiplayer_authority():
		if Input.is_action_pressed("exit"):
			get_tree().current_scene.rpc("del_player", name)
			get_tree().current_scene.close_game()
			pass
		
		var direction : Vector2 = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		if (Input.is_action_pressed("run")):
			velocity = direction * RUN_SPEED
		else:
			velocity = direction * SPEED
		
		move_and_slide()
