extends Area2D

var card_name
var card_face
var card_back
var click_enabled

func _ready():
	click_enabled = true
	card_name = "Empty"
	card_face = preload("res://minigame-jogo-da-memoria/sprites/dandelion-flower.png")
	card_back = preload("res://minigame-jogo-da-memoria/sprites/dandelion-flower.png")
	# coloca a imagem de dandelion-flower.png como textura do sprite da parte de traz da carta
	get_node("Sprite2D").texture = card_back
	pass

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	if click_enabled:
		# a carta e virada (e outras coisas acontecem tambem)
		if get_parent().last_try_was_pair:
			get_parent().last_try_was_pair = false
			get_parent()._reset_card_name_strings_and_check_box()
		click_enabled = false
		get_node("Sprite").texture = card_face
		
		# PRIMEIRO LANCE
		# se essa condicao for verdadeira significa que a primeira
		# carta para formar um novo par ainda nao foi virada
		if (get_parent().get_node("CardOneName").text == "Card 1"):
			get_parent().get_node("CardOneName").text = card_name
			get_parent().card_one_checked_if_pairing = name
		
		# SEGUNDO LANCE
		# essa condicao e verdadeira quando a primeira carta ja foi virada
		elif (get_parent().get_node("CardOneName").text != "Card 1"):
			if (get_parent().get_node("CardTwoName").text == "Card 2"):
				get_parent().get_node("CardTwoName").text = card_name
				get_parent().card_two_checked_if_pairing = name
				get_parent()._check_if_pair()
