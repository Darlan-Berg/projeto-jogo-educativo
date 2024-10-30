extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var jumpCount = 0

@onready var animador := $anim as AnimatedSprite2D
@onready var remote := $remote as RemoteTransform2D
@onready var som_pulo: AudioStreamPlayer2D = $som_pulo

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y >= 0:
			animador.play("landing")
		if velocity.y < 0:
			animador.play("jump")

	# Handle jump.
	if is_on_floor():
		jumpCount = 0
	if jumpCount < 1:
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
	if direction:
		velocity.x = direction * SPEED
		animador.scale.x = direction
		if is_on_floor():
			animador.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animador.play("idle")

	move_and_slide()
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("inimigos"):
		queue_free()
		
#func seguir_camera(camera):
#	var caminho_camera = camera.get_path()
#	remote.remote_path = caminho_camera
	
