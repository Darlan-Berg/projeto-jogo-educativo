extends Node2D

@onready var panel_container: PanelContainer = $"../PanelContainer"
@onready var jogo_da_memoria: Node2D = $"."
@onready var foto_e_legenda: VBoxContainer = $"../foto_e_legenda"
@onready var imagem: TextureRect = $"../foto_e_legenda/MarginContainer/CenterContainer/imagem"
@onready var legenda: Label = $"../foto_e_legenda/legenda"

var card_face
var card_back
var init
var number_of_matches
var default_image
var image1
var image2
var image3
var image4
var image5
var image6
var image7
var image8
var name_image1
var name_image2
var name_image3
var name_image4
var name_image5
var name_image6
var name_image7
var name_image8
var last_try_was_pair
var card_one_checked_if_pairing
var card_two_checked_if_pairing
var card_one_str
var card_two_str
var all_remaining_cards = []
var random_card
var card_number
var pares_encontrados = 0
var tween_comecou
var pode_sair_cena_minigame
var legendas = [
	"O Parque Ambiental Chico Mendes promove ações de conscientização e educação ambiental. Dessa forma, preservação da natureza e educação andam lado a lado colaborando na disseminação de conhecimentos.",
	"O parque conta com um zoológico que abriga uma ampla variedade de espécies da fauna local. Todos o animais ficaram impossibilitados de retornar a natureza por terem sido vítimas de acidentes, do tráfico ou de posse ilegal, mas foram resgatados e encontraram um novo lar.",
	"O parque contempla uma área de 57 hectares de Floresta Amazônica. Nela estão presentes diversas espécies da flora local que oferecem comida e abrigo para os animais silvestres. Sendo assim, esse espaço é uma importante fonte para pesquisas científicas que visam a preservação da fauna e flora locais."
]

func _ready():
	# selecionar imagem e legenda a serem mostradas
	if Global.minigame_em_execucao == "acionador_minigame_1":
		imagem.texture = preload("res://minigame-jogo-da-memoria/sprites/entrada_pacm.jpg")
		legenda.text = legendas[0]
	elif Global.minigame_em_execucao == "acionador_minigame_2":
		imagem.texture = preload("res://minigame-jogo-da-memoria/sprites/oncas.jpg")
		imagem.scale = Vector2(1.2, 1.2)
		legenda.text = legendas[1]
	elif Global.minigame_em_execucao == "acionador_minigame_3":
		imagem.texture = preload("res://minigame-jogo-da-memoria/sprites/praca-jardim-pacm.jpg")
		imagem.scale = Vector2(1.1, 1.1)
		legenda.text = legendas[2]
	
	pode_sair_cena_minigame = false
	card_one_str = "Card 1"
	card_two_str = "Card 2"
	last_try_was_pair = false
	
	default_image = preload("res://minigame-jogo-da-memoria/sprites/dandelion-flower.png")
	image1 = preload("res://minigame-jogo-da-memoria/sprites/anta.png")
	name_image1 = "Anta"
	image2 = preload("res://minigame-jogo-da-memoria/sprites/gato-do-mato.png")
	name_image2 = "Gato-do-mato"
	image3 = preload("res://minigame-jogo-da-memoria/sprites/onca-pintada.jpg")
	name_image3 = "Onça-pintada"
	image4 = preload("res://minigame-jogo-da-memoria/sprites/arara-caninde.png")
	name_image4 = "Arara-canindé"
	image5 = preload("res://minigame-jogo-da-memoria/sprites/tucano.jpg")
	name_image5 = "Tucano"
	image6 = preload("res://minigame-jogo-da-memoria/sprites/jabuti-tinga.jpg")
	name_image6 = "Jabuti-tinga"
	image7 = preload("res://minigame-jogo-da-memoria/sprites/macaco-bigodeiro.jpg")
	name_image7 = "Macaco-bigodeiro"
	image8 = preload("res://minigame-jogo-da-memoria/sprites/jiboia.png")
	name_image8 = "Jiboia"
	# isso faz com que as funcoes aleatorias, a cada execucao do jogo,
	# gerem numeros realmente aleatorios
	randomize()
	init = false

func _process(_delta):
	if !init:
		_shuffle_cards()
	
	if pares_encontrados == 8 and !tween_comecou:
		tween_comecou = true
		Global.qtd_minigames_concluidos += 1
		Global.retorno_minigame = true
		var waiting_timer = Timer.new()
		waiting_timer.set_wait_time(2)
		waiting_timer.set_one_shot(true)
		self.add_child(waiting_timer)
		waiting_timer.start()
		await(waiting_timer.timeout)
		
		mostrar_foto_legenda()
	
	if pares_encontrados == 8 and pode_sair_cena_minigame and Input.is_action_just_pressed("enter"):
		Global.minigames_concluidos[Global.minigame_em_execucao] = true
		#print("Global.minigames_concluidos[Global.minigame_em_execucao] = " + str(Global.minigames_concluidos[str(Global.minigame_em_execucao)]) + "\n")
		#print(Global.minigames_concluidos)
		#print("Global.minigames_concluidos[\"acionador_minigame_1\"] = " + str(Global.minigames_concluidos["acionador_minigame_1"]))
		#print("Global.minigames_concluidos[\"acionador_minigame_2\"] = " + str(Global.minigames_concluidos["acionador_minigame_2"]))
		#print("Global.minigames_concluidos[\"acionador_minigame_3\"] = " + str(Global.minigames_concluidos["acionador_minigame_3"]))
		get_tree().change_scene_to_file("res://fases/fase_5.tscn")

func mostrar_foto_legenda():
	var tween = create_tween()
	# limpar que esta na tela
	tween.tween_property(jogo_da_memoria, "position", Vector2(jogo_da_memoria.position.x, jogo_da_memoria.position.y + 1000), 1)
	tween.tween_property(panel_container, "position", Vector2(panel_container.position.x, panel_container.position.y + 1000), 1)
	# trazer a imagem com a legenda
	tween.tween_property(foto_e_legenda, "position", Vector2(-386, -387), 1)
	
	pode_sair_cena_minigame = true

func _shuffle_cards():
	all_remaining_cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_1_card_1 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_1_card_2 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_2_card_1 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_2_card_2 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_3_card_1 = "Card" + str(card_number)
	
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_3_card_2 = "Card" + str(card_number)
	
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_4_card_1 = "Card" + str(card_number)
	
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_4_card_2 = "Card" + str(card_number)
	
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_5_card_1 = "Card" + str(card_number)
	
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_5_card_2 = "Card" + str(card_number)
	
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_6_card_1 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_6_card_2 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_7_card_1 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_7_card_2 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_8_card_1 = "Card" + str(card_number)
	
	random_card = randi()% all_remaining_cards.size()
	card_number = all_remaining_cards[random_card]
	all_remaining_cards.remove_at(random_card)
	var pair_8_card_2 = "Card" + str(card_number)
	
	get_node(pair_1_card_1).card_face = image1
	get_node(pair_1_card_1).card_name = name_image1
	get_node(pair_1_card_2).card_face = image1
	get_node(pair_1_card_2).card_name = name_image1
	
	get_node(pair_2_card_1).card_face = image2
	get_node(pair_2_card_1).card_name = name_image2
	get_node(pair_2_card_2).card_face = image2
	get_node(pair_2_card_2).card_name = name_image2
	
	get_node(pair_3_card_1).card_face = image3
	get_node(pair_3_card_1).card_name = name_image3
	get_node(pair_3_card_2).card_face = image3
	get_node(pair_3_card_2).card_name = name_image3
	
	get_node(pair_4_card_1).card_face = image4
	get_node(pair_4_card_1).card_name = name_image4
	get_node(pair_4_card_2).card_face = image4
	get_node(pair_4_card_2).card_name = name_image4
	
	get_node(pair_5_card_1).card_face = image5
	get_node(pair_5_card_1).card_name = name_image5
	get_node(pair_5_card_2).card_face = image5
	get_node(pair_5_card_2).card_name = name_image5
	
	get_node(pair_6_card_1).card_face = image6
	get_node(pair_6_card_1).card_name = name_image6
	get_node(pair_6_card_2).card_face = image6
	get_node(pair_6_card_2).card_name = name_image6
	
	get_node(pair_7_card_1).card_face = image7
	get_node(pair_7_card_1).card_name = name_image7
	get_node(pair_7_card_2).card_face = image7
	get_node(pair_7_card_2).card_name = name_image7
	
	get_node(pair_8_card_1).card_face = image8
	get_node(pair_8_card_1).card_name = name_image8
	get_node(pair_8_card_2).card_face = image8
	get_node(pair_8_card_2).card_name = name_image8
	
	init = true

func _check_if_pair():
	if get_node("CardOneName").text == get_node("CardTwoName").text:
		get_node("CheckBox").text = "="
		last_try_was_pair = true
		pares_encontrados += 1
	
	# se CardOneName e CardTwoName sao diferentes de "Card 1" e "Card 2"
	# significa que duas cartas foram viradas
	if get_node("CardOneName").text != "Card 1" && get_node("CardTwoName").text != "Card 2":
		# as cartas viradas nao formam um par
		if get_node("CardOneName").text != get_node("CardTwoName").text:
			_disable_all_cards_clicks()
			get_node("CheckBox").text = "!="
			var waiting_timer = Timer.new()
			waiting_timer.set_wait_time(3)
			waiting_timer.set_one_shot(true)
			self.add_child(waiting_timer)
			waiting_timer.start()
			await(waiting_timer.timeout)
			_reset_card_name_strings_and_check_box()
			_turn_around_cards()
			_enable_all_cards_clicks()

func _reset_card_name_strings_and_check_box():
	get_node("CardOneName").text = card_one_str
	get_node("CardTwoName").text = card_two_str
	get_node("CheckBox").text = "?"

func _turn_around_cards():
	get_node(str(card_one_checked_if_pairing)).get_node("Sprite2D").texture = default_image
	get_node(str(card_two_checked_if_pairing)).get_node("Sprite2D").texture = default_image

func _disable_all_cards_clicks():
	get_node("Card1").click_enabled = false
	get_node("Card2").click_enabled = false
	get_node("Card3").click_enabled = false
	get_node("Card4").click_enabled = false
	get_node("Card5").click_enabled = false
	get_node("Card6").click_enabled = false
	get_node("Card7").click_enabled = false
	get_node("Card8").click_enabled = false
	get_node("Card9").click_enabled = false
	get_node("Card10").click_enabled = false
	get_node("Card11").click_enabled = false
	get_node("Card12").click_enabled = false
	get_node("Card13").click_enabled = false
	get_node("Card14").click_enabled = false
	get_node("Card15").click_enabled = false
	get_node("Card16").click_enabled = false

func _enable_all_cards_clicks():
	if get_node("Card1").get_node("Sprite2D").texture == default_image:
		get_node("Card1").click_enabled = true
	if get_node("Card2").get_node("Sprite2D").texture == default_image:
		get_node("Card2").click_enabled = true
	if get_node("Card3").get_node("Sprite2D").texture == default_image:
		get_node("Card3").click_enabled = true
	if get_node("Card4").get_node("Sprite2D").texture == default_image:
		get_node("Card4").click_enabled = true
	if get_node("Card5").get_node("Sprite2D").texture == default_image:
		get_node("Card5").click_enabled = true
	if get_node("Card6").get_node("Sprite2D").texture == default_image:
		get_node("Card6").click_enabled = true
	if get_node("Card7").get_node("Sprite2D").texture == default_image:
		get_node("Card7").click_enabled = true
	if get_node("Card8").get_node("Sprite2D").texture == default_image:
		get_node("Card8").click_enabled = true
	if get_node("Card9").get_node("Sprite2D").texture == default_image:
		get_node("Card9").click_enabled = true
	if get_node("Card10").get_node("Sprite2D").texture == default_image:
		get_node("Card10").click_enabled = true
	if get_node("Card11").get_node("Sprite2D").texture == default_image:
		get_node("Card11").click_enabled = true
	if get_node("Card12").get_node("Sprite2D").texture == default_image:
		get_node("Card12").click_enabled = true
	if get_node("Card13").get_node("Sprite2D").texture == default_image:
		get_node("Card13").click_enabled = true
	if get_node("Card14").get_node("Sprite2D").texture == default_image:
		get_node("Card14").click_enabled = true
	if get_node("Card15").get_node("Sprite2D").texture == default_image:
		get_node("Card15").click_enabled = true
	if get_node("Card16").get_node("Sprite2D").texture == default_image:
		get_node("Card16").click_enabled = true

func _on_quit_button_down() -> void:
	Global.retorno_minigame = true
	get_tree().change_scene_to_file("res://fases/fase_5.tscn")
