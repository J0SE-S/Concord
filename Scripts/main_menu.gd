extends Node2D

@export var gameScene : PackedScene

func _on_play_button_button_up():
	get_tree().change_scene_to_packed(gameScene)


func _on_settings_button_button_up():
	pass # Replace with function body.


func _on_quit_button_button_up():
	get_tree().quit()
