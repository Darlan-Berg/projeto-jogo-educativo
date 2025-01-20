extends Node2D

@onready var jogador: CharacterBody2D = $jogador
@onready var camera_jogador: Camera2D = $jogador/camera
var pode_iniciar_minigame = false
var ir_para_memorial = false

func _ready() -> void:
	var foto := $HUD/control/container/container_foto/foto as TextureRect
	foto.texture = preload("res://assets/chico_mendes.jpg")
	foto.scale = Vector2(2.5, 2.5)
	
	Global.fase_em_execucao = 5
	
	if GlobalFase5.retorno_minigame:
		jogador.position = GlobalFase5.posicao_jogador
		# remover inimigos que foram derrotados antes de entrar no minigame
		for inimigo in GlobalFase5.inimigos_derrotados:
			get_node("inimigos/" + str(inimigo)).queue_free()
		GlobalFase5.retorno_minigame = false
	
	camera_jogador.limit_top = -16

func _physics_process(delta: float) -> void:
	if pode_iniciar_minigame and Input.is_action_just_pressed("acessar_minigame"):
		GlobalFase5.posicao_jogador = jogador.position
		#GlobalFase5.minigame_finalizado = 
		get_tree().change_scene_to_file("res://minigame-jogo-da-memoria/scenes/GameManager.tscn")
	
	if ir_para_memorial and Input.is_action_just_pressed("acessar_minigame"):
		get_tree().change_scene_to_file("res://fases/memorial_chico_mendes.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://cenas/final da fase 5/cena1.tscn")


func _on_acionador_minigame_1_body_entered(body: Node2D) -> void:
	if body.name == "jogador":
		pode_iniciar_minigame = true


func _on_acionador_minigame_1_body_exited(body: Node2D) -> void:
	pode_iniciar_minigame = false


func _on_final_body_entered(body: Node2D) -> void:
	if body.name == "jogador":
		ir_para_memorial = true


func _on_final_body_exited(body: Node2D) -> void:
	if body.name == "jogador":
		ir_para_memorial = false
