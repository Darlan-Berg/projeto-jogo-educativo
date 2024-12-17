extends CharacterBody2D

@onready var raycast := $raycast as RayCast2D
@onready var textura := $textura as Sprite2D

const SPEED = 50.0
var direction = 1

func _physics_process(delta: float) -> void:

	if raycast.is_colliding():
		direction *= -1
		raycast.scale.x *= -1
	
	if direction == 1:
		textura.flip_h = false
	else:
		textura.flip_h = true
	
	velocity.x = direction * SPEED

	move_and_slide()

func tomar_dano(forca_knockback := Vector2.ZERO, duracao := 0.25):
	print("O besouro tomou dano")
	self.queue_free()
