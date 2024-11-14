# texto_cutscene_5.gd
extends CanvasLayer

@export var text_list: Array = [
"Fase 1: Infância no Seringal",
"Chico Mendes nasceu no dia 15 de dezembro de 1944, no município de Xapuri, Acre. Sua família era humilde e tirava seu sustento da extração do látex. Por isso, desde cedo já começou a trabalhar nos seringais para ajudar na renda da família.",
"Missão: explore a fase e colete látex das árvores de seringueira."
]
var current_text_index = 0

@onready var label: Label = $PanelContainer/VBoxContainer/MarginContainer/Label

func _ready() -> void:
	label.text = text_list[current_text_index]

func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		advance_text()

func advance_text():
	if label == null:
		return  # Se 'label' não foi encontrado, saia da função
	elif current_text_index <= text_list.size() - 1:
		label.text = text_list[current_text_index]
		current_text_index += 1
	else:
		start_game_scene()  # Quando terminar, iniciar a fase do jogo

func start_game_scene():                             
	get_tree().change_scene_to_file("res://fases/fase_5.tscn")  # Troque para a cena da fase do jogo
