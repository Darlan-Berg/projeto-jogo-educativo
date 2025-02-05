extends Node2D

@onready var jogador: CharacterBody2D = $jogador
@onready var camera_jogador: Camera2D = $jogador/camera


func _ready() -> void:
	
	# limitar a camera para que o background apareca da forma correta
	camera_jogador.limit_top = -16
	
	if Global.retorno_minigame:
		Global.retorno_minigame = false
		
		jogador.position = Global.posicao_jogador
		# remover inimigos que foram derrotados antes de entrar no minigame
		for inimigo in Global.inimigos_derrotados:
			get_node("inimigos/" + str(inimigo)).queue_free()
		# remover diamantes que foram coletados antes de entrar no minigame
		for diamante in Global.diamantes_coletados:
			get_node("diamantes/" + str(diamante)).queue_free()
		
		# desabilitar minigames que ja foram concluidos
		for i in range(1, 4):
			if Global.minigames_concluidos["acionador_minigame_" + str(i)] == true:
				get_node("acionadores/acionador_minigame_" + str(i) + "/CollisionShape2D").disabled = true


func _physics_process(delta: float) -> void:
	if Global.pode_iniciar_minigame and Input.is_action_just_pressed("enter"):
		# salvar o progresso atual
		Global.posicao_jogador = jogador.position
		#Global.minigame_finalizado = 
		get_tree().change_scene_to_file("res://minigame-jogo-da-memoria/scenes/GameManager.tscn")
	
	if Global.ir_para_memorial and Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://fases/memorial_chico_mendes.tscn")
