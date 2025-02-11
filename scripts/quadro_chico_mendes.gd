extends Area2D


func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "jogador":
		var waiting_timer = Timer.new()
		waiting_timer.set_wait_time(2)
		waiting_timer.set_one_shot(true)
		self.add_child(waiting_timer)
		waiting_timer.start()
		await(waiting_timer.timeout)
		
		get_tree().change_scene_to_file("res://cenas/finalizacao_fase_5.tscn")
