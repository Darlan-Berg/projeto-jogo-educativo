extends Control


@onready var diamond_counter: Label = $container/container_diamantes/diamond_counter
@onready var latex_counter: Label = $container/container_latexs/latex_counter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diamond_counter.text = str("%06d" % Global.score)
	latex_counter.text = str("%02d" % Global.latexs)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	diamond_counter.text = str("%06d" % Global.score)
	latex_counter.text = str("%02d" % Global.latexs)
