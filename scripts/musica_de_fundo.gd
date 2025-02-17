extends Node

@onready var player = $AudioStreamPlayer

#func _ready():
#	if Global.fase_em_execucao == 5:
#		if player.playing == false:
#			player.play()

func _process(float) -> void:
	if Global.fase_em_execucao == 5:
		if player.playing == false:
			player.play()
	elif Global.fase_em_execucao == 6:
		player.stop()
