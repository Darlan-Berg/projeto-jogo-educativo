extends Node2D

var pode_iniciar_minigame = false

func _ready() -> void:
	var foto := $HUD/control/container/container_foto/foto as TextureRect
	foto.texture = preload("res://assets/chico_mendes.jpg")
	foto.scale = Vector2(2.5, 2.5)
	
	Global.fase_em_execucao = 5

func _physics_process(delta: float) -> void:
	if pode_iniciar_minigame == true and Input.is_action_just_pressed("ui_accept"):
		print("to na area")
		comecar_jogo_da_memoria()

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://cenas/final da fase 5/cena1.tscn")


func comecar_jogo_da_memoria():
	print("me chamou")
	var cena_minigame = preload("res://minigame-jogo-da-memoria/scenes/GameManager.tscn")
	var instancia_minigame = cena_minigame.instantiate()

	# Adiciona o minigame à cena principal
	get_tree().root.add_child(instancia_minigame)

	# Configura a posição da câmera para centralizar o minigame
	instancia_minigame.position = $jogador.global_position


func _on_acionador_minigame_1_body_entered(body: Node2D) -> void:
	if body.name == "jogador":
		pode_iniciar_minigame = true


func _on_acionador_minigame_1_body_exited(body: Node2D) -> void:
	pode_iniciar_minigame = false
