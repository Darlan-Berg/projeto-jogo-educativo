extends Node2D

var dialogue_scene = preload("res://cenas/cena_dialog.tscn")
var dialogue_instance

func _ready():
	if dialogue_scene:
		dialogue_instance = dialogue_scene.instance()
		add_child(dialogue_instance)
		dialogue_instance.start_dialogue()
	else:
		print("Erro: Cena de diálogo não foi carregada corretamente.")
