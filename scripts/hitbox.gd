extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "jogador":
		body.velocity.y = body.JUMP_VELOCITY
		owner.tomar_dano(Vector2(-500, -400))
		GlobalFase5.inimigos_derrotados.append(str(get_parent().name))
		Global.score += 300
		owner.queue_free()
