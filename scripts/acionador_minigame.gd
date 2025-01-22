extends Area2D


func _on_body_entered(body: Node2D) -> void:
	Global.minigame_em_execucao = name
	Global.pode_iniciar_minigame = true


func _on_body_exited(body: Node2D) -> void:
	Global.pode_iniciar_minigame = false
