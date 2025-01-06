extends Node2D

func _ready() -> void:
	# pegar o container_foto
	#var container_foto := $HUD/control/container/container_foto as BoxContainer
	# pegar a foto
	var foto := $HUD/control/container/container_foto/foto as TextureRect
	foto.texture = preload("res://assets/chico_mendes.jpg")
	foto.scale = Vector2(2.5, 2.5) # isso não está alterando a escala
	# adicionar um Control a container_foto para que a foto fique mais para cima
	#var control_esp = Control.new()
	#control_esp.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	Global.fase_em_execucao = 5

# quando o jogador chegar no fim da fase
func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://cenas/final da fase 5/cena1.tscn")
