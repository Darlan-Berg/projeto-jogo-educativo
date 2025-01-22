extends Node2D

@onready var jogador: CharacterBody2D = $jogador
@onready var camera_jogador: Camera2D = $jogador/camera

var ir_para_memorial = false


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
	
	if ir_para_memorial and Input.is_action_just_pressed("acessar_minigame"):
		get_tree().change_scene_to_file("res://fases/memorial_chico_mendes.tscn")


func _on_final_body_entered(body: Node2D) -> void:
	if body.name == "jogador":
		ir_para_memorial = true


func _on_final_body_exited(body: Node2D) -> void:
	if body.name == "jogador":
		ir_para_memorial = false
