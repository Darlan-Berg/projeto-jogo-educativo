extends Area2D


func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		owner.velocity.y = -250.0
		body.animador.play("jump")
		owner.anim.play("dead")
		owner.SPEED = 500
		await owner.anim.animation_finished
		owner.queue_free()
		
