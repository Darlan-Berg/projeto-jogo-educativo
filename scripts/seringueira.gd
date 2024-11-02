extends Area2D


@onready var botao_iniciar = $control/container_botoes/botao_iniciar as Button
@onready var container_botoes = $control/container_botoes/container_sequencia_botoes as HBoxContainer
var current_index = 0  # Índice da sequência, começa no primeiro botão
var timer = 5.0  # Tempo limite para a sequência (5 segundos)
var sequencia_botoes = ["baixo", "direita", "esquerda", "cima", "baixo2"]
var esta_na_area = false
@onready var teste: AudioStreamPlayer = $teste


func _physics_process(delta: float) -> void:  
	if Input.is_action_just_pressed("ui_text_completion_accept") and esta_na_area:
		teste.play()
		botao_iniciar.visible =false
		container_botoes.visible = true
	

func _on_body_entered(body: Node2D) -> void:
	botao_iniciar.visible = true
	esta_na_area = true
	


func _on_body_exited(body: Node2D) -> void:
	botao_iniciar.visible = false
	esta_na_area = false


func _on_botao_iniciar_pressed() -> void:
	print("hdufgfduvdbuvbdvufv dfv vdf f vd vfb fjdbgfdbfgdgdbbfu")
