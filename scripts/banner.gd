"""
extends Area2D

var esta_na_area = false
var fim_dialogo = false

func _physics_process(delta: float) -> void:
	if esta_na_area and Input.is_action_just_pressed("ui_text_completion_accept") and not fim_dialogo:
		Dialogic.start("placa1")
		fim_dialogo = true
	Dialogic.timeline_started.connect(pausar_controles)
	Dialogic.timeline_ended.connect(liberar_controles)

	
func pausar_controles():
	Global.controles_pausados = true


func liberar_controles():
	Global.controles_pausados = false


func _on_body_entered(body: Node2D) -> void:
	esta_na_area = true


func _on_body_exited(body: Node2D) -> void:
	esta_na_area = false
	fim_dialogo = false
"""
