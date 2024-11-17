extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "jogador":
		body.velocity.y = body.JUMP_VELOCITY
		#owner.tomar_dano(Vector2(-200, -200))
		owner.queue_free()
		Global.score += 300
