extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var jumpCount = 0
var caiu_na_agua_1 = false
var caiu_na_agua_2 = false
var knockback_vector:= Vector2.ZERO
var direc_jogador = 1

@onready var animador := $anim as AnimatedSprite2D
@onready var remote := $remote as RemoteTransform2D
@onready var som_pulo := $som_pulo as AudioStreamPlayer
@onready var ray_direita: RayCast2D = $ray_direita
@onready var ray_esquerda: RayCast2D = $ray_esquerda
@onready var som_dano: AudioStreamPlayer = $som_dano

var idle = ""
var run = ""
var jump = ""
var landing = ""

func _ready():
	if Global.fase_em_execucao == 5:
		idle = "idle_pedro"
		run = "run_pedro"
		jump = "jump_pedro"
		landing = "landing_pedro"
	else:
		idle = "idle"
		run = "run"
		jump = "jump"
		landing = "landing"
   
func _physics_process(delta: float) -> void:
	
	"""
	if ray_direita.is_colliding():
		Global.vida -= 1
		tomar_dano(Vector2(-200, -200))
		som_dano.play()
	elif ray_esquerda.is_colliding():
		Global.vida -= 1
		tomar_dano(Vector2(200, -200))
		som_dano.play()
	"""
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y >= 0:
			animador.play(landing)
		if velocity.y < 0:
			animador.play(jump)

	# Handle jump.
	if is_on_floor():
		jumpCount = 0
	if jumpCount < 1:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not Global.controles_pausados:
			velocity.y = JUMP_VELOCITY
			som_pulo.play()
		if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and not Global.controles_pausados:
			velocity.y = JUMP_VELOCITY
			jumpCount +=1
			som_pulo.play()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	self.direc_jogador = Input.get_axis("ui_left", "ui_right")
	if self.direc_jogador and not Global.controles_pausados:
		velocity.x = self.direc_jogador * SPEED
		animador.scale.x = self.direc_jogador
		if is_on_floor():
			animador.play(run)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animador.play(idle)
			
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	move_and_slide()
	

func _on_agua_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	Global.vida -= 1
	if Checkpoint.ultima_posicao:
		position = Checkpoint.ultima_posicao
	else:
		position.x = Checkpoint.posicao_inicial_player[0]
		position.y = Checkpoint.posicao_inicial_player[1]

func _on_agua_2_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	Global.vida -= 1
	if Checkpoint.ultima_posicao:
		position = Checkpoint.ultima_posicao
	else:
		position.x = Checkpoint.posicao_inicial_player[0]
		position.y = Checkpoint.posicao_inicial_player[1]

func _on_espinhos_1_body_entered(body: Node2D) -> void:
	tomar_dano(Vector2(0, -1000))
	
func tomar_dano(forca_knockback := Vector2.ZERO, duracao := 0.25): 
	
	if forca_knockback != Vector2.ZERO: 
		knockback_vector = forca_knockback

		var knockback_tween := get_tree().create_tween() 
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duracao)
		animador.modulate = Color(1,0,0,1) 
		knockback_tween.tween_property(animador, "modulate", Color(1,1,1,1), duracao)
		Global.vida -= 1

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("inimigos"):
		
		if body.velocity.x > 0 and self.velocity.x > 0:
			tomar_dano(Vector2(-400, -200))
		elif body.velocity.x < 0 and self.velocity.x < 0:
			tomar_dano(Vector2(400, -200))
		elif body.velocity.x > 0:
			tomar_dano(Vector2(400, -200))
		elif body.velocity.x < 0:
			tomar_dano(Vector2(-400, -200))
		som_dano.play()
