extends Camera2D

@onready var label: Label = $Label

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(label, "position", Vector2(label.position.x, label.position.y - 2500), 10)
	tween.finished.connect(_tween_acabou)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _tween_acabou():
	get_tree().change_scene_to_file("res://cenas/tela_inicial.tscn")
