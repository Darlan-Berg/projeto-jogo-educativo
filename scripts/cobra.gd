extends CharacterBody2D

const SPEED = 700.0

@onready var detec_paredes := $detec_paredes as RayCast2D

var direction := -1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if detec_paredes.is_colliding():
		direction *= -1
		detec_paredes.scale.x *= -1

	velocity.x = direction * SPEED * delta

	move_and_slide()
