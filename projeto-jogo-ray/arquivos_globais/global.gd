extends Node

var score := 0
var latexs := 0
var is_dialog_active = false

var player = null

var current_checkpoint = null

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
