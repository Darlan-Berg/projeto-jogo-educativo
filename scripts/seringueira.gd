extends Area2D


@onready var botao_iniciar: Button = $control/container_botoes/botao_iniciar
@onready var container_sequencia_botoes: HBoxContainer = $control/container_botoes/container_sequencia_botoes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Torna os containers invisíveis ao iniciar o jogo
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	botao_iniciar.visible= true
	container_sequencia_botoes.visible = false
	

func _on_body_exited(body: Node2D) -> void:
	botao_iniciar.visible = false
	container_sequencia_botoes.visible = false
 
