extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var jumpCount = 0
var caiu_na_agua_1 = false
var caiu_na_agua_2 = false
var knockback_vector:= Vector2.ZERO

@onready var animador := $anim as AnimatedSprite2D
@onready var remote := $remote as RemoteTransform2D
@onready var som_pulo := $som_pulo as AudioStreamPlayer
@onready var ray_direita: RayCast2D = $ray_direita
@onready var ray_esquerda: RayCast2D = $ray_esquerda

func _physics_process(delta: float) -> void:
	
	if ray_direita.is_colliding():
		Global.vida -= 1
		tomar_dano(Vector2(-200, -200))
	if ray_esquerda.is_colliding():
		Global.vida -= 1
		tomar_dano(Vector2(200, -200))
		
	
	#Verifica a quantidade de vida
	if Global.vida == 3:
		$"../HUD/control/container/container_barra_vida/vida_3".visible = true
		$"../HUD/control/container/container_barra_vida/vida_2".visible = false
		$"../HUD/control/container/container_barra_vida/vida_1".visible = false
		$"../HUD/control/container/container_barra_vida/vida_0".visible = false
	elif Global.vida == 2:
		$"../HUD/control/container/container_barra_vida/vida_3".visible = false
		$"../HUD/control/container/container_barra_vida/vida_2".visible = true
		$"../HUD/control/container/container_barra_vida/vida_1".visible = false
		$"../HUD/control/container/container_barra_vida/vida_0".visible = false
	elif Global.vida == 1:
		$"../HUD/control/container/container_barra_vida/vida_3".visible = false
		$"../HUD/control/container/container_barra_vida/vida_2".visible = false
		$"../HUD/control/container/container_barra_vida/vida_1".visible = true
		$"../HUD/control/container/container_barra_vida/vida_0".visible = false
	elif Global.vida == 0:
		$"../HUD/control/container/container_barra_vida/vida_3".visible = false
		$"../HUD/control/container/container_barra_vida/vida_2".visible = false
		$"../HUD/control/container/container_barra_vida/vida_1".visible = false
		$"../HUD/control/container/container_barra_vida/vida_0".visible = true
	
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
			
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector 

	move_and_slide()
	

func _on_agua_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	Global.vida -= 1
	position.x = -766
	position.y = 151


func _on_agua_2_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	Global.vida -= 1
	position.x = 1970
	position.y = 107
	
func tomar_dano(forca_knockback := Vector2.ZERO, duracao := 0.25): 
	
	if forca_knockback != Vector2.ZERO: 
		knockback_vector = forca_knockback 

		var knockback_tween := get_tree().create_tween() 
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duracao)
		animador.modulate = Color(1,0,0,1) 
		knockback_tween.tween_property(animador, "modulate", Color(1,1,1,1), duracao)
