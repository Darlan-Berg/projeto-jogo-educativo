extends Area2D

@onready var transicao: CanvasLayer = $"../transicao"
@export var next_level : String = ""

func _on_body_entered(body):
	if body.name == "jogador" and !next_level == "":
		transicao.change_scene(next_level)
	else:
		print("No Scene Loaded")
