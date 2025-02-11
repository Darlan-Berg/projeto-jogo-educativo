extends CanvasLayer


func _on_button1_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/texto_cutscene_5.tscn")


func _on_button5_pressed() -> void:
	Global.fase_em_execucao = 5
	get_tree().change_scene_to_file("res://cenas/texto_cutscene_5.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
