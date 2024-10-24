extends Control

@onready var contador_diamantes := $container/container_diamantes/contador_diamantes as Label
@onready var contador_score := $container/container_score/contador_score as Label
@onready var contador_vidas := $container/container_vida/contador_vidas as Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contador_diamantes.text = str("%04d" % Global.diamantes)
	contador_score.text = str("%06d" % Global.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	contador_diamantes.text = str("%04d" % Global.diamantes)
	contador_score.text = str("%06d" % Global.score)
