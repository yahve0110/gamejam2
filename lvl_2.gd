extends Node2D


func menu():
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	menu()
