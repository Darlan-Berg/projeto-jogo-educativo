extends Node2D


# quando o jogador chegar no fim da fase
func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://cenas/final da fase 5/cena1.tscn")
