extends Area2D

var esta_na_area = false
var fim_dialogo = false
@export var timeline = ""

func _physics_process(delta: float) -> void:
	if esta_na_area and not fim_dialogo:
		Dialogic.start(timeline)
		fim_dialogo = true
	Dialogic.timeline_started.connect(pausar_controles)
	Dialogic.timeline_ended.connect(liberar_controles)
	

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	esta_na_area = true # Replace with function body.


func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	esta_na_area = false
	
func pausar_controles():
	Global.controles_pausados = true
	
func liberar_controles():
	Global.controles_pausados = false


func _on_body_entered(body: Node2D) -> void:
	esta_na_area = true # Replace with function body.
	

func _on_body_exited(body: Node2D) -> void:
	esta_na_area = false
