extends Control

signal game_over
@onready var contador_diamantes := $container/container_diamantes/contador_diamantes as Label
@onready var contador_score := $container/container_score/contador_score as Label
@onready var contador_vidas := $container/container_vida/contador_vidas as Label

@onready var vida_3: TextureRect = $container/container_barra_vida/vida_3
@onready var vida_2: TextureRect = $container/container_barra_vida/vida_2
@onready var vida_1: TextureRect = $container/container_barra_vida/vida_1
@onready var vida_0: TextureRect = $container/container_barra_vida/vida_0

@onready var pedaco_1: TextureRect = $container/container_pedacos_foto/pedaco1
@onready var pedaco_2: TextureRect = $container/container_pedacos_foto/pedaco2
@onready var pedaco_3: TextureRect = $container/container_pedacos_foto/pedaco3
@onready var pedaco_4: TextureRect = $container/container_pedacos_foto/pedaco4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contador_diamantes.text = str("%04d" % Global.diamantes)
	contador_score.text = str("%06d" % Global.score)
	contador_vidas.text = str("%02d" % Global.quantidade_vidas)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if vida_0 and vida_1 and vida_2 and vida_3:
		#Verifica a quantidade de vida
		if Global.vida == 3:
			vida_3.visible = true
			vida_2.visible = false
			vida_1.visible = false
			vida_0.visible = false
		elif Global.vida == 2:
			vida_3.visible = false
			vida_2.visible = true
			vida_1.visible = false
			vida_0.visible = false
		elif Global.vida == 1:
			vida_3.visible = false
			vida_2.visible = false
			vida_1.visible = true
			vida_0.visible = false
		elif Global.vida == 0:
			vida_3.visible = false
			vida_2.visible = false
			vida_1.visible = false
			vida_0.visible = true
	else:
		pass
		
	if pedaco_1 and pedaco_2 and pedaco_3 and pedaco_4:
		if Global.pedacos_foto == 0:
			pedaco_1.visible = false
			pedaco_2.visible = false
			pedaco_3.visible = false
			pedaco_4.visible = false
		if Global.pedacos_foto == 1:
			pedaco_1.visible = true
			pedaco_2.visible = false
			pedaco_3.visible = false
			pedaco_4.visible = false
		if Global.pedacos_foto == 2:
			pedaco_1.visible = true
			pedaco_2.visible = true
			pedaco_3.visible = false
			pedaco_4.visible = false
		if Global.pedacos_foto == 3:
			pedaco_1.visible = true
			pedaco_2.visible = true
			pedaco_3.visible = true
			pedaco_4.visible = false
		if Global.pedacos_foto == 2:
			pedaco_1.visible = true
			pedaco_2.visible = true
			pedaco_3.visible = true
			pedaco_4.visible = true
		else:
			pass
	
	contador_diamantes.text = str("%02d" % Global.diamantes)
	contador_score.text = str("%06d" % Global.score)
	contador_vidas.text = str("%02d" % Global.quantidade_vidas)
	
	if Global.vida == 0 and Global.quantidade_vidas > 0:
		Global.quantidade_vidas -= 1
		game_over.emit()
		Global.vida = 3
