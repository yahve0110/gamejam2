extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	menu()
	
	pass

func menu():
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://Menu.tscn")


func _on_audio_stream_player_2d_finished():
	print("tit")
	$AudioStreamPlayer2D.play()   
