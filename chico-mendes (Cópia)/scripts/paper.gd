extends Area2D

var coins_collected = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if coins_collected >= 3:
		print("Zerou o nível")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	coins_collected +=1
	queue_free()
