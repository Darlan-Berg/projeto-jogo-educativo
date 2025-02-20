extends Area2D

@onready var transicao: CanvasLayer = $"../transicao"
@export var next_level : String = ""

func _on_body_entered(body):
	get_tree().change_scene_to_file(next_level)
	'if Input.is_action_just_pressed("acessar_minigame"):
		get_tree().change_scene_to_file("res://fases/memorial_chico_mendes.tscn")
	else:
		print("No Scene Loaded")'
