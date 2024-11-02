extends CharacterBody2D

const SPEED = 1000.0

@onready var detec_paredes := $detec_paredes as RayCast2D
@onready var textura := $textura as Sprite2D

var direction := -1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if detec_paredes.is_colliding():
		
		direction *= -1
		detec_paredes.scale.x *= -1
		
	if direction == 1:
		textura.flip_h = false
	else:
		textura.flip_h = true

	velocity.x = direction * SPEED * delta

	move_and_slide()
