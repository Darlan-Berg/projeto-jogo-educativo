extends Camera2D

@onready var label: Label = $Label
@onready var label_2: Label = $Label2

func _ready() -> void:
	Global.fase_em_execucao = 6
	var tween = create_tween()
	tween.tween_property(label, "position", Vector2(label.position.x, label.position.y - 3000), 60)
	tween.finished.connect(_agradecimento)


func _process(delta: float) -> void:
	pass

func _agradecimento():
	var tween = create_tween()
	tween.tween_property(label_2, "position", Vector2(-393, -54), 1)	
	tween.finished.connect(_tween_acabou)

func _tween_acabou():
	
	var waiting_timer = Timer.new()
	waiting_timer.set_wait_time(5)
	waiting_timer.set_one_shot(true)
	self.add_child(waiting_timer)
	waiting_timer.start()
	await(waiting_timer.timeout)
	
	get_tree().change_scene_to_file("res://cenas/tela_inicial.tscn")
