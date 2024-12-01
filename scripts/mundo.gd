extends Node2D


func _enter_tree():
	if Checkpoint.ultima_posicao:
		%jogador.global_position = Checkpoint.ultima_posicao

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_over:
		Global.game_over = false
		get_tree().reload_current_scene()
		Global.pedacos_foto = 0
		%jogador.position.x = 602
		%jogador.position.y = 1


	
