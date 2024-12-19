extends Area2D

var ultima_posicao = null
var posicao_inicial_player = [366, -5]

@onready var sprite: AnimatedSprite2D = $sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Checkpoint.ultima_posicao = position
	sprite.play("rising")
	
