# fim_fase_5.gd
extends PanelContainer

@onready var elementos_ui = $"." as PanelContainer
var qtd_itens_coletados = 3 #Global.pedacos_foto #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
var num_cena = 0


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		avancar_elementos()

func limpar_cena(container):
	while container.get_child_count() > 0:
		var no_filho = container.get_child(0)
		container.remove_child(no_filho)
		no_filho.queue_free()

func avancar_elementos():
	# limpar cena atual
	limpar_cena(elementos_ui)
	
	if num_cena == 0:
		var label = Label.new()
		# verificar Global.pedaco_foto
		if qtd_itens_coletados == 4:
			label.text = "Parabéns, você encontrou todos os colecionáveis!"
		else:
			label.text = "Hum, infelizmente você não encontrou todos os colecionáveis"
		elementos_ui.add_child(label)
		
		num_cena += 1
		return
	
	elif num_cena == 1 and qtd_itens_coletados == 4:
		
		# mostrar itens coletados
		var itens_container = HBoxContainer.new()
		elementos_ui.add_child(itens_container)
		for i in range(qtd_itens_coletados):
			var imagem = TextureRect.new()
			imagem.texture = load("res://assets/chico_mendes.jpg")
			itens_container.add_child(imagem)
			
		num_cena += 1

	elif num_cena == 1 and qtd_itens_coletados != 4:
		var label = Label.new()
		label.text = "Não desista você vai conseguir da próxima!"
		elementos_ui.add_child(label)

		num_cena += 1
	
	elif num_cena == 2:
		get_tree().change_scene_to_file("res://cenas/tela_inicial.tscn")
