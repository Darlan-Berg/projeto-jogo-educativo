extends Node2D


'func _enter_tree():
	if Checkpoint.ultima_posicao:
		%jogador.position = Checkpoint.ultima_posicao
	else:
		%jogador.position.x = Checkpoint.posicao_inicial_player[0]
		%jogador.position.y = Checkpoint.posicao_inicial_player[1]'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.game_over:
		Global.game_over = false
		if Checkpoint.ultima_posicao:
			%jogador.position = Checkpoint.ultima_posicao
		else:
			%jogador.position.x = Checkpoint.posicao_inicial_player[0]
			%jogador.position.y = Checkpoint.posicao_inicial_player[1]
