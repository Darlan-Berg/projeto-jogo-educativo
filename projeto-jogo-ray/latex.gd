extends Area2D

@onready var botao_iniciar = $control/container_botoes/botao_iniciar as Button
@onready var container_botoes: HBoxContainer = $control/container_botoes/VBoxContainer/container_sequencia_botoes
@onready var som_acerto: AudioStreamPlayer = $som_acerto
@onready var som_erro: AudioStreamPlayer = $som_erro
@onready var timer: Timer = $timer
@onready var barra_timer: TextureProgressBar = $control/container_botoes/VBoxContainer/barra_timer

var tempo_esgotado = false
var sequencia_botoes = ["letra_g", "number_one", "letra_s", "number_four", "cima"]
var nos_salvar = []
var names = []
var indice = 0
var esta_na_area = false
var minigame_ativo = false
var minigame_concluido = false


func _ready():
	pass

func _physics_process(delta: float) -> void:  
	if timer and minigame_ativo:
		barra_timer.value = timer.time_left
	
	if Input.is_action_just_pressed("ui_text_completion_accept") and esta_na_area and not minigame_concluido:
		var i = 0
		while i < container_botoes.get_children().size():
			var elemento = container_botoes.get_children()[i]
			var elemento_nome = container_botoes.get_children()[i].name
			if elemento_nome not in sequencia_botoes:
				elemento.visible = false
			i += 1
		botao_iniciar.visible = false
		container_botoes.visible = true
		barra_timer.visible = true
		minigame_ativo = true
		timer.start()
	
	if minigame_ativo:
		if Input.is_action_just_pressed("ui_down"):
			verificar_sequencia("baixo")
		if Input.is_action_just_pressed("letra_m"):
			verificar_sequencia("letra_m")
		if Input.is_action_just_pressed("ui_left"):
			verificar_sequencia("esquerda")
		if Input.is_action_just_pressed("number_seven"):
			verificar_sequencia("number_seven")
		if Input.is_action_just_pressed("letra_r"):
			verificar_sequencia("letra_r")
			
		if Input.is_action_just_pressed("ui_right"):
			verificar_sequencia("direita")
		if Input.is_action_just_pressed("top"):
			verificar_sequencia("cima")
		if Input.is_action_just_pressed("letra_s"):
			verificar_sequencia("letra_s")
		if Input.is_action_just_pressed("letra_g"):
			verificar_sequencia("letra_g")
		if Input.is_action_just_pressed("number_nine"):
			verificar_sequencia("number_nine")
		if Input.is_action_just_pressed("number_four"):
			verificar_sequencia("number_four")
		if Input.is_action_just_pressed("number_one"):
			verificar_sequencia("number_one")
			
			
			
		
		

func _on_body_entered(body: Node2D) -> void:
				
	if not minigame_concluido:
		botao_iniciar.visible = true
		esta_na_area = true

func _on_body_exited(body: Node2D) -> void:
	botao_iniciar.visible = false
	esta_na_area = false
	container_botoes.visible = false
	barra_timer.visible = false
	
func verificar_sequencia(botao_pressionado):
	if container_botoes:  # Check if container_botoes is valid
		if botao_pressionado == sequencia_botoes[indice]:
			if indice < container_botoes.get_children().size():
				container_botoes.get_children()[indice].visible = false
				indice += 1
				som_acerto.play()
				
				# Se toda a sequencia tiver sido concluida esconder a barra do timer
				if indice == container_botoes.get_children().size():
					minigame_ativo = false
					minigame_concluido = true
					barra_timer.visible = false
					som_acerto.queue_free()
					Global.latex += 1
					som_erro.queue_free()
			else:
				som_erro.play()
		else:
			for botao in container_botoes.get_children():
				botao.visible  = true
			indice = 0
			som_erro.play()
	else:
		print("container_botoes is null!")


func _on_timer_timeout() -> void:
	if not minigame_concluido and esta_na_area:
		tempo_esgotado = true
		for botao in container_botoes.get_children():
			botao.visible  = true
		indice = 0
		timer.start()
		som_erro.play()
	
