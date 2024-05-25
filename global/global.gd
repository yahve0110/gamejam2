extends Node

var player_current_attack = false

var current_scene = "world"
var transition_scene = false

var player_exit_lvl1_posx = 0
var player_exit_lvl1_posy = 0

func finish_changescene():
	if transition_scene:
		transition_scene = false
		if current_scene == "world":
			current_scene = "lvl2"
		else:
			current_scene = "world"
