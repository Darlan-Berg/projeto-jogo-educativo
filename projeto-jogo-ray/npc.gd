extends Area2D

var colision : bool = false
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if colision:
		colision = false
		Dialogic.start("dialogo_one")
		get_viewport().set_input_as_handled()


func _on_body_entered(body: Node2D) -> void:
	colision = true
