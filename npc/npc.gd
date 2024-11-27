extends Area2D

var esta_na_area = false
var fim_dialogo = false
@export var timeline = ""

func _physics_process(delta: float) -> void:
	if esta_na_area and Input.is_action_just_pressed("ui_text_completion_accept") and not fim_dialogo:
		Dialogic.start(timeline)
		fim_dialogo = true

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	esta_na_area = true
		
func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	esta_na_area = false
	fim_dialogo = false
