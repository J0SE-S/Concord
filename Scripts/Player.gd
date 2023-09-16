extends CharacterBody2D

@export var cam: Camera2D

const SPEED = 300.0

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	cam.set_enabled(is_multiplayer_authority())

func _process(delta):
	if is_multiplayer_authority():
		if Input.is_action_pressed("exit"):
			$"../".exit_game(name)
			pass
		
		var direction : Vector2 = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		velocity = direction * SPEED
		
		move_and_slide()
