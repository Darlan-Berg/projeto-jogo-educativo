extends Area2D


var finalizar_fase = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "jogagor":
		finalizar_fase = true
		print("entrou")


func _on_body_exited(body: Node2D) -> void:
	if body.name == "jogagor":
		finalizar_fase = false
		print("saiu")
