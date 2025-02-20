extends CharacterBody2D


var SPEED = 2500.0
var JUMP_VELOCITY = -400.0

@onready var wall_detector: RayCast2D = $wall_detector
@onready var anim: AnimatedSprite2D = $anim
var direction := 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if wall_detector.is_colliding():
		
		direction *= -1
		wall_detector.scale.x *= -1
		
	if direction == 1:
		anim.scale.x = 1.229
	else:
		anim.scale.x = -1.229
		
	velocity.x = direction * SPEED * delta

	move_and_slide()
