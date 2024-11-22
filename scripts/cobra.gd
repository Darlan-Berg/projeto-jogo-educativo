extends CharacterBody2D

const SPEED = 1000.0
const distancia = 50

@onready var detec_paredes := $detec_paredes as RayCast2D
@onready var textura := $textura as Sprite2D

var direction := -1
var knockback_vector:= Vector2.ZERO

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
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector 

	move_and_slide()
	
func tomar_dano(forca_knockback := Vector2.ZERO, duracao := 0.25): 
	%colisor.disabled = true
	%colisor_hitbox.disabled = true
	self.collision_mask = 6 
	
	if forca_knockback != Vector2.ZERO: 
		knockback_vector = forca_knockback    

		var knockback_tween := get_tree().create_tween() 
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duracao)
