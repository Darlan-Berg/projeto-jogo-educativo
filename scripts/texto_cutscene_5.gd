# texto_cutscene_5.gd
extends CanvasLayer

#@export var text_list: Array = [
#"Fase 1: Infância no Seringal",
#"Chico Mendes nasceu no dia 15 de dezembro de 1944, no município de Xapuri, Acre. Sua família era humilde e tirava seu sustento da extração do látex. Por isso, desde cedo já começou a trabalhar nos seringais para ajudar na renda da família.",
#"Missão: explore a fase e colete látex das árvores de seringueira."
#]
#var current_text_index = 0

@onready var label: Label = $PanelContainer/VBoxContainer/MarginContainer/Label
@onready var current_text_index = 0
@onready var text_list: Array = []

func _ready() -> void:
	
	# verificar se e a fase 5 que vai ser executada
	if Global.fase_em_execucao == 5:
		text_list = [
			"Fase 5: Legado",
			"Você é um estudante do Instituto Federal do Acre (IFAC) que está participando de uma viagem de campo ao Parque Ambiental Chico Mendes (PACM). Nesta viagem você deverá coletar informações sobre o parque e sobre a vida e legado do ambientalista para elaborar um trabalho de sua escola, e para isso deverá explorar as dependências do parque até chegar ao Memorial Chico Mendes.",
			"Missão: explore a fase e complete todos os minigames para liberar o acesso ao Memorial Chico Mendes."
		]
		
		label.text = text_list[current_text_index]
	else:
		text_list = [
			"Fase 1: Infância no Seringal",
			"Chico Mendes nasceu no dia 15 de dezembro de 1944, no município de Xapuri, Acre. Sua família era humilde e tirava seu sustento da extração do látex. Por isso, desde cedo já começou a trabalhar nos seringais para ajudar na renda da família.",
			"Missão: explore a fase e colete látex das árvores de seringueira."
			]
			
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
		print(current_text_index)
		print(typeof(current_text_index))
		print(text_list.size() - 1)
		start_game_scene()  # Quando terminar, iniciar a fase do jogo

func start_game_scene():
	# verificar a fase que será executada
	if Global.fase_em_execucao == 5:
		get_tree().change_scene_to_file("res://fases/fase_5.tscn")
	else:
		get_tree().change_scene_to_file("res://cenas/mundo.tscn")  # Troque para a cena da fase do jogo
