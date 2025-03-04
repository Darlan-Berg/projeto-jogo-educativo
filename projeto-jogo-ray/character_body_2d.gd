extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var player: CharacterBody2D = $"."
@onready var animador := $anim as AnimatedSprite2D
@onready var ray_right: RayCast2D = $ray_right
@onready var ray_left: RayCast2D = $ray_left
@onready var ray_bottom: RayCast2D = $ray_bottom
@onready var som_pulo: AudioStreamPlayer = $som_pulo

var jumpCount = 0
var knockback_vector = Vector2.ZERO
var player_life := 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		#if velocity.y >= 0:
		#	animador.play("landing")
		
		if velocity.y >= 1000 and not is_on_floor():
			if Global.current_checkpoint == null:
				get_tree().reload_current_scene()
			else:
				player.position = Global.current_checkpoint
		if velocity.y < 0:	
			animador.play("jump")

	# Handle jump.
	if is_on_floor() and not Global.controles_pausados:
		jumpCount = 0
	if jumpCount < 1 and not Global.controles_pausados:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			som_pulo.play()
		if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
			velocity.y = JUMP_VELOCITY
			jumpCount +=1
			som_pulo.play()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and not Global.controles_pausados:
		velocity.x = direction * SPEED
		animador.scale.x = direction
		if is_on_floor():
			animador.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animador.play("idle")
			
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	if ray_bottom.is_colliding():
		if Global.current_checkpoint == null:
			get_tree().reload_current_scene()
			Global.vida -= 1
		else:
			player.position.x = Global.current_checkpoint[0]
			player.position.y = Global.current_checkpoint[1]
			Global.vida -= 1
	
	if Global.vida == 0:
		Global.quantidade_vidas -= 1
		Global.vida = 3
		get_tree().reload_current_scene()
	
	move_and_slide()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if player_life < 0:
		queue_free()
	else:
		if ray_right.is_colliding():
			take_damage(Vector2(-260.0, -200.0))
		elif ray_left.is_colliding():
			take_damage(Vector2(260.0, -200.0))
		
func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween = get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animador.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animador, "modulate", Color(1,1,1,1), duration)
		Global.vida -= 1
