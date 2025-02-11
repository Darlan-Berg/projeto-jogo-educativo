extends Node2D

@onready var jogador: CharacterBody2D = $jogador
@onready var camera_jogador: Camera2D = $jogador/camera
@onready var painel: PanelContainer = $painel
@onready var label_painel: Label = $painel/MarginContainer/Label

func _ready() -> void:
	
	# limitar a camera para que o background apareca da forma correta
	camera_jogador.limit_top = 4
	
	painel.visible = false
	
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
		get_tree().change_scene_to_file("res://minigame-jogo-da-memoria/scenes/GameManager.tscn")
	
	if Global.ir_para_memorial and Input.is_action_just_pressed("enter"):
		if Global.qtd_minigames_concluidos == 3:
			get_tree().change_scene_to_file("res://fases/memorial_chico_mendes.tscn")
		else:
			print("complete os minigames")

	if Global.qtd_minigames_concluidos == 3:
		label_painel.text = "Minigames concluídos: 3/3\nAcesso liberado!\nClique \"enter\" para entrar"
	else:
		label_painel.text = "Minigames concluídos: %d/3\nComplete todos os minigames\npara poder acessar o memorial" % [Global.qtd_minigames_concluidos]
